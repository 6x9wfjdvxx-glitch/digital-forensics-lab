# Super Timeline com Plaso e Outras Ferramentas

> **Objetivo pedagógico:** construir linhas do tempo reprodutíveis a partir de imagens e coletas, usando Plaso (log2timeline), The Sleuth Kit, ferramentas de Eric Zimmerman e Timesketch, documentando comandos, versões e parâmetros.

## 1. Abordagens

| Abordagem | Descrição | Quando usar |
|---|---|---|
| Super timeline (Plaso) | Extrai e combina eventos de dezenas de parsers em um único repositório | Visão ampla de uma imagem ou de uma coleta |
| Timeline do sistema de arquivos (TSK) | Cria um arquivo "body" e o converte com `mactime` | Análise rápida de carimbos do sistema de arquivos |
| Timeline por artefatos (ferramentas EZ) | Processa artefatos específicos em CSV e os combina | Foco em Windows, com controle fino |
| Timeline de logs (Hayabusa, Chainsaw) | Gera linha do tempo de eventos EVTX com regras de detecção | Triagem de logs do Windows |
| Plataforma colaborativa (Timesketch) | Importa e analisa timelines em grupo, com marcações e consultas | Equipes e casos grandes |

## 2. Pipeline

```mermaid
flowchart LR
    A["Imagem verificada por hash ou coleta"] --> B["Extração de eventos (Plaso, TSK, EZ Tools)"]
    B --> C["Armazenamento em .plaso ou CSV"]
    C --> D["Filtragem por período e fonte"]
    D --> E["Normalização para UTC"]
    E --> F["Análise no Timesketch ou Timeline Explorer"]
    F --> G["Eventos-chave, hipóteses e relatório"]
```

## 3. Plaso (log2timeline)

### 3.1 Requisitos e cuidados

- Execute em uma estação de análise, sobre uma cópia da imagem (nunca sobre o original).
- Reserve espaço em disco (o arquivo `.plaso` e os temporários podem ser grandes) e memória.
- Registre a versão do Plaso e os parâmetros utilizados.
- Verifique a licença e a documentação da versão instalada.

### 3.2 Comandos básicos

```bash
# Ambiente via Docker (exemplo)
docker run --rm -v /mnt/analise:/data log2timeline/plaso log2timeline.py --version

# Extração de eventos de uma imagem E01 para um arquivo de armazenamento
log2timeline.py --storage-file /mnt/saida/DFL-2026-001-E001.plaso /mnt/analise/DFL-2026-001-E001-IMG01-W1.E01

# Usar um conjunto predefinido de parsers para Windows (verificar presets disponíveis na versão)
log2timeline.py --parsers win7 --storage-file /mnt/saida/E001.plaso /mnt/analise/E001-W1.E01

# Informações sobre o arquivo de armazenamento
pinfo.py -v /mnt/saida/DFL-2026-001-E001.plaso
```

Para fontes com hora local (por exemplo, sistemas FAT), informe o fuso de origem (`--timezone`) conforme a documentação. Para cópias de sombra de volume (VSS), consulte as opções da versão instalada.

### 3.3 Exportação e filtragem

```bash
# Exportar tudo para CSV (formato l2tcsv), saída em UTC
psort.py --output-time-zone UTC -o l2tcsv -w /mnt/saida/E001_completo.csv /mnt/saida/E001.plaso

# Exportar apenas uma janela de tempo
psort.py --output-time-zone UTC -o l2tcsv -w /mnt/saida/E001_janela.csv /mnt/saida/E001.plaso \
  "date > '2026-10-20 00:00:00' AND date < '2026-10-31 00:00:00'"

# Formato dinâmico (colunas selecionadas), útil para planilhas
psort.py --output-time-zone UTC -o dynamic -w /mnt/saida/E001_dyn.csv /mnt/saida/E001.plaso
```

Documente os filtros aplicados e mantenha os arquivos brutos intactos.

## 4. The Sleuth Kit (mactime)

```bash
# Gerar o arquivo body a partir da imagem (use -o com o deslocamento da partição, em setores)
fls -r -m "C:" -o 2048 /mnt/analise/E001-W1.dd > /mnt/saida/body.txt

# Converter para CSV em UTC, com janela de datas
mactime -b /mnt/saida/body.txt -d -z UTC 2026-10-20..2026-10-31 > /mnt/saida/mactime.csv
```

O resultado inclui os carimbos de MACB do sistema de arquivos. Complemente com artefatos de aplicação e logs.

## 5. Ferramentas de Eric Zimmerman (Windows)

```powershell
# $MFT para CSV
MFTECmd.exe -f "E:\coleta\$MFT" --csv E:\saida --csvf mft.csv

# $UsnJrnl para CSV
MFTECmd.exe -f "E:\coleta\$J" --csv E:\saida --csvf usn.csv

# Logs de eventos (EVTX) para CSV
EvtxECmd.exe -d E:\coleta\logs --csv E:\saida --csvf evtx.csv

# Prefetch e Amcache
PECmd.exe -d E:\coleta\Prefetch --csv E:\saida --csvf prefetch.csv
AmcacheParser.exe -f E:\coleta\Amcache.hve --csv E:\saida
```

Abra os CSV no Timeline Explorer, filtrando por período, e combine fontes por coluna de data e hora. Confira as opções na versão instalada.

## 6. Timeline de logs com Hayabusa

```bash
hayabusa csv-timeline -d /mnt/coleta/logs -o /mnt/saida/hayabusa_timeline.csv
```

O Hayabusa aplica regras Sigma a EVTX e produz uma linha do tempo com classificação de severidade, útil para triagem inicial.

## 7. Timesketch

O Timesketch é uma plataforma de código aberto para análise colaborativa de linhas do tempo.

| Recurso | Uso |
|---|---|
| Importação | Arquivos `.plaso` ou CSV com as colunas `message`, `datetime` e `timestamp_desc` |
| Consultas | Pesquisa por texto e por campos, com filtros por período |
| Marcação | Etiquetas e estrelas em eventos relevantes |
| Analisadores | Detecção automática de padrões (por exemplo, logins, domínios) |
| Histórias (stories) | Narrativas ligadas a eventos e consultas |
| Colaboração | Várias pessoas trabalhando no mesmo caso |

Exemplo mínimo de CSV importável:

```
message,datetime,timestamp_desc
"Execucao de binario suspeito",2026-10-28T13:22:10Z,"Prefetch"
"Conexao externa ao dominio X",2026-10-28T13:22:42Z,"Proxy"
```

## 8. Reprodutibilidade e registro

| Item | Registro |
|---|---|
| Entrada | Identificador e hash da imagem ou coleta |
| Ferramenta e versão | Plaso, TSK, EZ Tools e Timesketch |
| Parâmetros | Parsers, filtros, fuso de saída |
| Saída | Nome e hash dos arquivos gerados |
| Responsável e data (UTC) | Analista e horário |
| Intercorrências | Erros de parser, partições ignoradas, lacunas |

## 9. Exemplo prático: pipeline de um caso

| Etapa | Ação |
|---|---|
| 1 | Verificar o hash da cópia de trabalho |
| 2 | Executar o log2timeline com os parsers de Windows |
| 3 | Exportar a janela de 2026-10-20 a 2026-10-31 em UTC |
| 4 | Importar o CSV no Timesketch e anotar eventos-chave |
| 5 | Confirmar execução e persistência com Prefetch, Amcache e EVTX |
| 6 | Exportar a narrativa, os eventos e os hashes para o relatório |

## 10. Casos de uso corporativos

- Resposta a incidente com linha do tempo consolidada de endpoint, proxy e identidade.
- Perícia com entrega de linha do tempo reprodutível por perito externo.
- Hunting retrospectivo sobre imagens guardadas, depois de nova inteligência de ameaças.

## 11. Normas e frameworks relevantes

- NIST SP 800-86 (análise)
- ISO/IEC 27041:2015 (adequação e validação do método)
- ISO/IEC 27042:2015
- NIST CFTT (validação de ferramentas)
- MITRE ATT&CK (mapeamento dos eventos às técnicas)

## 12. Referências

- Documentação do Plaso (log2timeline) e do Timesketch.
- Gudjonsson, K. Mastering the Super Timeline With log2timeline. SANS Reading Room, 2010.
- Carrier, B. The Sleuth Kit: documentação de fls e mactime.
- Zimmerman, E. Documentação do MFTECmd, EvtxECmd, PECmd e Timeline Explorer.
- Yamato Security. Documentação do Hayabusa.
- SANS Institute. FOR508.
