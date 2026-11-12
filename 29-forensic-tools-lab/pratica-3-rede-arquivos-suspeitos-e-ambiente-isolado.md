# Prática 3: Rede, Arquivos Suspeitos e Ambiente Isolado

> **Objetivo pedagógico:** praticar a análise de tráfego de rede (capturas, Zeek, Suricata e consultas), a detecção de comunicação periódica (beaconing) com um tráfego benigno gerado localmente, a análise estática de arquivos com ferramentas padrão, a escrita e o teste de regras YARA com marcadores de laboratório e a operação de um ambiente isolado (snapshots e rede somente host), tudo com **material benigno ou de treinamento**.

> **Segurança:** esta prática **não usa malware real**. Para praticar a detecção por antivírus, use o arquivo de teste padrão EICAR, disponível no site eicar.org. Para análises de amostras reais, siga a pasta 15 e as regras de isolamento do arquivo 1, e somente com autorização e fonte confiável.

## 1. Preparação

| Item | Descrição |
|---|---|
| VM de análise de rede | Linux com `tshark`, Zeek, Suricata e DuckDB |
| Caso | `DFL-LAB-003` |
| Capturas públicas | Conjuntos públicos de treinamento (por exemplo, amostras do projeto Wireshark e exercícios públicos de análise de tráfego), com licença verificada |
| Rede | A VM não deve ter acesso à rede de produção durante a análise de capturas de terceiros |

## 2. Gerar um tráfego periódico benigno (beaconing de laboratório)

Este exercício simula, de forma inofensiva, uma comunicação periódica entre dois processos **na mesma máquina**.

```bash
mkdir -p /lab/casos/DFL-LAB-003/{evidencias,saidas} && cd /lab/casos/DFL-LAB-003/evidencias

# Terminal 1: servidor web local simples
mkdir -p /tmp/site_lab && echo "ok" > /tmp/site_lab/ping
cd /tmp/site_lab && python3 -m http.server 8080 --bind 127.0.0.1

# Terminal 2: captura na interface de loopback
sudo tcpdump -i lo -w /lab/casos/DFL-LAB-003/evidencias/beacon_lab.pcap tcp port 8080

# Terminal 3: cliente que consulta o servidor a cada 30 segundos, 40 vezes (cerca de 20 minutos)
for i in $(seq 1 40); do curl -s http://127.0.0.1:8080/ping > /dev/null; sleep 30; done
```

Ao final, interrompa a captura (Ctrl+C) e o servidor, e calcule o hash do arquivo `beacon_lab.pcap`.

## 3. Análise com `tshark`

```bash
cd /lab/casos/DFL-LAB-003/evidencias
sha256sum beacon_lab.pcap > beacon_lab.pcap.sha256

tshark -r beacon_lab.pcap -q -z io,phs                  # hierarquia de protocolos
tshark -r beacon_lab.pcap -q -z conv,tcp                # conversas TCP
tshark -r beacon_lab.pcap -Y "http.request" -T fields -e frame.time_epoch -e ip.src -e ip.dst -e http.request.uri | head -n 20
```

## 4. Análise com Zeek e detecção de periodicidade

```bash
cd /lab/casos/DFL-LAB-003/saidas
zeek -C -r ../evidencias/beacon_lab.pcap
ls            # conn.log, http.log e outros

# Exportar campos de conexões para CSV
zeek-cut ts id.orig_h id.resp_h id.resp_p < conn.log | tr '\t' ',' > conn.csv
```

```sql
-- DuckDB: intervalos entre conexões por origem, destino e porta (candidatos a beaconing)
WITH c AS (
  SELECT orig, resp, porta, ts,
         ts - lag(ts) OVER (PARTITION BY orig, resp, porta ORDER BY ts) AS delta
  FROM read_csv('conn.csv', columns={'ts':'DOUBLE','orig':'VARCHAR','resp':'VARCHAR','porta':'INTEGER'}, header=false)
)
SELECT orig, resp, porta, count(*) AS conexoes,
       round(avg(delta), 1) AS media_s, round(stddev(delta), 2) AS desvio_s
FROM c
WHERE delta IS NOT NULL
GROUP BY ALL
HAVING count(*) > 20 AND stddev(delta) < 2
ORDER BY conexoes DESC;
```

**Perguntas:** o intervalo médio corresponde aos 30 segundos configurados? Qual o desvio? Que variações (*jitter*) um tráfego real teria, e como isso afetaria os limiares? Que falsos positivos existem (atualizações automáticas, verificações de saúde e aplicativos legítimos)?

## 5. Análise com Suricata

```bash
# Atualizar as regras de código aberto (requer internet; faça antes de isolar a VM)
sudo suricata-update

cd /lab/casos/DFL-LAB-003/saidas
mkdir -p suricata && suricata -r ../evidencias/beacon_lab.pcap -l suricata -k none
cat suricata/fast.log | head
jq 'select(.event_type=="alert")' suricata/eve.json | head
```

**Exercício:** o tráfego benigno gerou alertas? Por quê? Escreva uma regra local simples (por exemplo, para o URI `/ping` no porto 8080) e teste:

```
alert http any any -> any 8080 (msg:"LAB DFL: acesso ao URI /ping"; http.uri; content:"/ping"; sid:9000001; rev:1;)
```

```bash
# Teste da regra local (salve a regra em lab.rules)
suricata -r ../evidencias/beacon_lab.pcap -S lab.rules -l suricata_regra -k none
cat suricata_regra/fast.log
```

## 6. Capturas públicas de treinamento

Use capturas públicas de exercícios de análise de tráfego (conferindo a licença) para praticar: identificar hosts, protocolos e conversas; reconstruir sessões HTTP e extrair objetos de forma segura; identificar consultas DNS incomuns; produzir um relatório. Extrair objetos significa salvar arquivos transmitidos, que podem ser maliciosos: faça isso **somente na VM isolada** e **nunca execute** os arquivos extraídos.

```bash
# Exemplo: listar consultas DNS e exportar objetos HTTP em uma captura pública (VM isolada)
tshark -r captura_publica.pcap -Y "dns.flags.response==0" -T fields -e frame.time -e ip.src -e dns.qry.name | sort | uniq -c | sort -nr | head -n 30
mkdir -p objetos_http && tshark -r captura_publica.pcap --export-objects http,objetos_http
sha256sum objetos_http/* > objetos_http_hashes.sha256
```

## 7. Análise estática de arquivos benignos

```bash
mkdir -p /lab/casos/DFL-LAB-003/arquivos && cd /lab/casos/DFL-LAB-003/arquivos
cp /usr/bin/ls ./binario_exemplo      # binário legítimo do sistema, para treinar a rotina de triagem
file binario_exemplo
sha256sum binario_exemplo
strings -n 8 binario_exemplo | head -n 30
exiftool binario_exemplo | head -n 20
```

Treine a rotina de triagem estática (pasta 15, PB-21): identificar o tipo, calcular hashes, listar *strings* relevantes, examinar metadados e registrar. Em seguida, repita com um documento de escritório e um arquivo compactado **criados por você**.

## 8. Regras YARA com marcadores de laboratório

```
rule Lab_Marcador_Teste
{
    meta:
        descricao = "Detecta o marcador de teste do laboratório DFL"
        autor = "Laboratorio DFL"
        versao = "1.0"
    strings:
        $m = "DFL-LAB-MARCADOR-001" ascii
    condition:
        $m
}
```

```bash
echo "conteudo com DFL-LAB-MARCADOR-001 no meio" > teste_positivo.txt
echo "conteudo sem o marcador" > teste_negativo.txt
yara -s lab_marcador.yar teste_positivo.txt teste_negativo.txt
yara -r lab_marcador.yar /lab/casos/DFL-LAB-003/arquivos
```

**Exercícios:** (1) crie uma regra que combine duas *strings* e uma condição de tamanho de arquivo; (2) teste contra um conjunto de arquivos legítimos do sistema para avaliar falsos positivos; (3) documente a regra, a versão e os resultados.

## 9. Teste de detecção com o arquivo EICAR

Baixe o arquivo de teste EICAR do site oficial (eicar.org) **somente em uma VM do laboratório**. Objetivos: observar a reação do antivírus do host e da VM; verificar se as exclusões estão corretas; registrar o comportamento em log; e confirmar que a pasta de amostras do laboratório está isolada. O arquivo é inofensivo e serve apenas para testar a detecção.

## 10. Operação do ambiente isolado

| Procedimento | Descrição |
|---|---|
| Antes | Restaurar o snapshot limpo; verificar que a rede é "somente host" e que não há rota para a internet; sem pastas compartilhadas e sem área de transferência |
| Durante | Registrar os comandos e as observações; capturar tráfego se necessário |
| Depois | Exportar apenas os resultados necessários (relatórios e hashes), por meio de mídia controlada; restaurar o snapshot |
| Teste de isolamento | Da VM isolada, tentar acessar a internet e a rede de produção (deve falhar) |

```bash
# Teste de isolamento (a VM isolada NÃO deve alcançar nenhum destino externo)
ping -c 2 -W 2 1.1.1.1 || echo "Sem rota para a internet (esperado)"
curl -m 5 -sI https://example.com || echo "Sem acesso externo (esperado)"
ip route
```

## 11. Registro e relatório

| Documento | Conteúdo |
|---|---|
| Inventário de capturas e de arquivos | Origem, licença e hashes |
| Registro de análise de rede | Hosts, protocolos, conversas, alertas e conclusões |
| Registro de regras (YARA e Suricata) | Regras, versões, testes e falsos positivos |
| Mini-relatório | Fatos, método, resultados e limitações |

## 12. Perguntas de verificação

| Pergunta | Resposta esperada |
|---|---|
| Que sinais indicam comunicação periódica? | Intervalos regulares, tamanhos semelhantes e destino constante |
| Por que o desvio-padrão baixo não prova comunicação maliciosa? | Muitos serviços legítimos são periódicos |
| Por que nunca executar objetos extraídos de uma captura? | Podem ser maliciosos |
| Por que testar regras contra arquivos legítimos? | Para estimar falsos positivos |
| Por que manter a VM isolada sem rota para a internet? | Evitar comunicação com infraestrutura externa e fuga de contaminação |

## 13. Casos de uso corporativos

- Treinamento de analistas de rede e de resposta a incidentes.
- Desenvolvimento e teste de regras de detecção (Suricata e YARA).
- Validação de procedimentos de isolamento do laboratório.

## 14. Normas e frameworks relevantes

- MITRE ATT&CK (T1071, T1095, T1573); NIST SP 800-61 Rev. 3; NIST SP 800-83 Rev. 1
- ISO/IEC 27037 e 27043; CIS Controls v8.1, controles 10 e 13

## 15. Referências

- Documentação do Wireshark, do `tshark`, do Zeek, do Suricata e do YARA.
- Sanders, C. Practical Packet Analysis. No Starch Press.
- EICAR. European Institute for Computer Antivirus Research, arquivo de teste.
- Pastas 13 e 15 deste repositório; PB-21 e PB-23 (pasta 23).
