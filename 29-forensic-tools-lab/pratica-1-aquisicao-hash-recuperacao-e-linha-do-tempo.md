# Prática 1: Aquisição, Hash, Recuperação e Linha do Tempo

> **Objetivo pedagógico:** praticar, com um disco de teste criado pelo próprio aluno, o ciclo básico de uma investigação de disco: criar e proteger a evidência original, calcular e verificar hashes, adquirir uma imagem em formato forense (E01), listar e recuperar arquivos excluídos com o Sleuth Kit, buscar conteúdo com `bulk_extractor`, construir linhas do tempo com `mactime` e com o Plaso, e documentar custódia, comandos e resultados.

> Use a estação de análise do laboratório (arquivo 1), em uma VM Linux. Os dados são fictícios. Os comandos que usam `sudo` afetam apenas o arquivo de imagem criado nesta prática.

## 1. Preparação do caso de laboratório

```bash
CASO=DFL-LAB-001
mkdir -p /lab/casos/$CASO/{00-autorizacao,01-evidencias-originais,02-copias-de-trabalho,03-saidas-de-analise,04-relatorios,05-custodia-e-registros}
cd /lab/casos/$CASO
echo "Caso de laboratório DFL-LAB-001: exercício com dados fictícios. Autorizado por: <seu nome>. Data (UTC): $(date -u +%FT%TZ)" > 00-autorizacao/autorizacao.txt

# Registrar o início da sessão de trabalho: grava os comandos e as saídas em um arquivo com horário
script -a -t 2> 05-custodia-e-registros/sessao_tempos.txt 05-custodia-e-registros/sessao_comandos.txt
# (digite "exit" ao final da prática para encerrar a gravação)
```

## 2. Criar o disco de teste (evidência original fictícia)

Usamos um sistema de arquivos FAT32, em que arquivos excluídos costumam ser recuperáveis de forma didática.

```bash
cd /lab/casos/DFL-LAB-001/01-evidencias-originais
dd if=/dev/zero of=disco_teste.img bs=1M count=256 status=progress
mkfs.vfat -F 32 -n LABDFL disco_teste.img

mkdir -p /tmp/montagem_lab
sudo mount -o loop,uid=$(id -u),gid=$(id -g) disco_teste.img /tmp/montagem_lab

# Criar conteúdo fictício
echo "Relatório financeiro fictício, versão 1" > /tmp/montagem_lab/relatorio_financeiro.txt
echo "Lista de contatos fictícia: Ana, Bruno, Carla" > /tmp/montagem_lab/contatos.txt
mkdir -p /tmp/montagem_lab/projetos
echo "Plano do projeto Aurora (fictício)" > /tmp/montagem_lab/projetos/plano_aurora.txt
echo "Senha de teste: Lab#2026 (fictícia)" > /tmp/montagem_lab/anotacoes.txt
sleep 5
# Excluir arquivos para a prática de recuperação
rm /tmp/montagem_lab/anotacoes.txt
rm /tmp/montagem_lab/projetos/plano_aurora.txt
sync
sudo umount /tmp/montagem_lab

# Congelar a evidência original
sha256sum disco_teste.img | tee disco_teste.img.sha256
chmod a-w disco_teste.img disco_teste.img.sha256
```

Anote a data e a hora, o hash e a descrição no formulário de custódia (pasta 02).

## 3. Aquisição em formato forense e verificação

```bash
cd /lab/casos/DFL-LAB-001
ewfacquire -u -t 01-evidencias-originais/evidencia_E01 -C DFL-LAB-001 -D "Disco de teste fictício FAT32" \
  -e "Analista Exemplo" -N "Exercício de laboratório" -c best -f encase6 -S 0 -d sha256 \
  01-evidencias-originais/disco_teste.img

ewfverify 01-evidencias-originais/evidencia_E01.E01
ewfinfo 01-evidencias-originais/evidencia_E01.E01 > 03-saidas-de-analise/ewfinfo.txt
sha256sum 01-evidencias-originais/evidencia_E01.E01 > 01-evidencias-originais/evidencia_E01.E01.sha256
```

**Verificações a documentar:** o hash calculado pelo `ewfacquire` coincide com o do arquivo `disco_teste.img`? O `ewfverify` indica sucesso? Os metadados (caso, descrição e examinador) estão corretos?

## 4. Exploração do sistema de arquivos

```bash
cd /lab/casos/DFL-LAB-001
# Informações do sistema de arquivos e listagem completa (incluindo excluídos)
fsstat 01-evidencias-originais/disco_teste.img | head -n 30
fls -r -p 01-evidencias-originais/disco_teste.img       # arquivos alocados
fls -r -p -d 01-evidencias-originais/disco_teste.img    # somente entradas excluídas
```

Registre os nomes e os números de entrada (inode) dos arquivos excluídos. Nos sistemas FAT, a primeira letra do nome de um arquivo excluído costuma ser perdida na exibição, e as atribuições de data e hora mostram o último acesso e a modificação.

## 5. Recuperação de arquivos excluídos

```bash
# Substitua <INODE> pelo número listado em "fls -d" para o arquivo excluído
icat 01-evidencias-originais/disco_teste.img <INODE> > 03-saidas-de-analise/recuperado_anotacoes.txt
cat 03-saidas-de-analise/recuperado_anotacoes.txt

# Recuperar em lote os arquivos (inclusive excluídos) para uma pasta de saída
mkdir -p 03-saidas-de-analise/tsk_recover
tsk_recover -e 01-evidencias-originais/disco_teste.img 03-saidas-de-analise/tsk_recover
find 03-saidas-de-analise/tsk_recover -type f -exec sha256sum {} \; > 03-saidas-de-analise/hashes_recuperados.sha256
```

**Pontos de atenção:** compare o conteúdo recuperado com o que foi criado; registre se algum arquivo foi parcialmente recuperado; observe que, em sistemas como ext4, a recuperação de arquivos excluídos é bem mais difícil, pois a estrutura que aponta para os dados é limpa na exclusão.

## 6. Busca de conteúdo com `bulk_extractor`

```bash
bulk_extractor -o 03-saidas-de-analise/bulk 01-evidencias-originais/disco_teste.img
ls 03-saidas-de-analise/bulk
head -n 20 03-saidas-de-analise/bulk/email.txt 2>/dev/null
grep -a -i "senha de teste" 01-evidencias-originais/disco_teste.img | head
```

Explique por que a busca por *strings* na imagem bruta ainda encontra o texto do arquivo excluído, mesmo sem o nome do arquivo.

## 7. Linha do tempo de arquivos (`mactime`)

```bash
cd /lab/casos/DFL-LAB-001
fls -r -m "/" 01-evidencias-originais/disco_teste.img > 03-saidas-de-analise/body.txt
mactime -b 03-saidas-de-analise/body.txt -d -z UTC > 03-saidas-de-analise/linha_tsk.csv
head -n 20 03-saidas-de-analise/linha_tsk.csv
```

Identifique: a ordem de criação dos arquivos; os horários de modificação e de último acesso; a sequência temporal compatível com a criação e a exclusão. Lembre que o sistema FAT registra horários em horário local da máquina que gravou (sem fuso), o que exige atenção à interpretação (pasta 05).

## 8. Linha do tempo com o Plaso

```bash
cd /lab/casos/DFL-LAB-001
log2timeline.py --storage-file 03-saidas-de-analise/lab.plaso 01-evidencias-originais/evidencia_E01.E01
psort.py -o dynamic -w 03-saidas-de-analise/linha_plaso.csv 03-saidas-de-analise/lab.plaso
wc -l 03-saidas-de-analise/linha_plaso.csv
head -n 10 03-saidas-de-analise/linha_plaso.csv
sha256sum 03-saidas-de-analise/lab.plaso 03-saidas-de-analise/linha_plaso.csv > 03-saidas-de-analise/hashes_saidas.sha256
```

Compare a linha do tempo do Plaso com a do `mactime`: quais eventos aparecem em cada uma? Qual a granularidade? Que filtros você aplicaria para reduzir o ruído (por exemplo, intervalo de tempo e tipo de evento)?

```bash
# Consulta em DuckDB sobre a linha do tempo do Plaso (ajuste os nomes das colunas ao CSV gerado)
duckdb -c "SELECT * FROM read_csv_auto('03-saidas-de-analise/linha_plaso.csv') LIMIT 10;"
```

## 9. Encerramento e documentação

```bash
exit    # encerra a gravação da sessão iniciada na seção 1
cd /lab/casos/DFL-LAB-001
find . -type f -print0 | sort -z | xargs -0 sha256sum > 05-custodia-e-registros/manifesto_final.sha256
```

Preencha:

| Documento | Conteúdo |
|---|---|
| Formulário de custódia | Evidência (`disco_teste.img`), criação, hashes, responsável, local de guarda |
| Registro de ferramentas e versões | Versões do `ewfacquire`, do Sleuth Kit, do `bulk_extractor` e do Plaso |
| Registro de análise | Comandos principais, resultados e observações |
| Mini-relatório (1 página) | Fatos, método, resultados e limitações |

## 10. Perguntas de verificação

| Pergunta | Resposta esperada |
|---|---|
| Por que gerar o hash antes da aquisição? | Para demonstrar que a imagem é idêntica à fonte e que a evidência original não foi alterada |
| Por que trabalhar com uma cópia e manter o original em somente leitura? | Para preservar a integridade e permitir repetir a análise |
| O que a presença de strings de um arquivo excluído na imagem demonstra? | Que a exclusão remove a referência no sistema de arquivos, mas o conteúdo pode permanecer até ser sobrescrito |
| Que limitações tem a recuperação em sistemas de arquivos modernos? | Estruturas limpas na exclusão e o uso de TRIM em SSDs reduzem ou impedem a recuperação |
| Por que declarar o fuso horário? | Para evitar interpretações erradas de horários e permitir correlação em UTC |

## 11. Variações e extensões

| Extensão | Descrição |
|---|---|
| Sistema de arquivos ext4 e NTFS | Repita com `mkfs.ext4` e `mkfs.ntfs` (se disponíveis) e compare a recuperação |
| Partições | Crie uma imagem com tabela de partições (`parted` ou `fdisk`) e use `mmls` para listar |
| Adulteração simulada | Altere 1 byte da cópia e demonstre que o `ewfverify` ou o hash detecta a diferença |
| Imagens públicas | Pratique com imagens de treinamento do NIST CFReDS e do Digital Corpora (verifique licenças) |

## 12. Casos de uso corporativos

- Treinamento de novos analistas no ciclo de aquisição e verificação.
- Padronização de runbooks de aquisição e de linha do tempo (PB-13 e PB-15).
- Base para a validação de ferramentas (arquivo 7).

## 13. Normas e frameworks relevantes

- ISO/IEC 27037; ISO/IEC 27042; NIST SP 800-86; NIST CFTT
- CPP, arts. 158-A a 158-F; LGPD, arts. 6º e 46

## 14. Referências

- Carrier, B. File System Forensic Analysis. Addison-Wesley, 2005.
- Documentação do The Sleuth Kit, do libewf, do `bulk_extractor` e do Plaso.
- NIST CFReDS e Digital Corpora (conjuntos de dados forenses de treinamento).
- Pastas 02, 03, 04, 05 e 10 deste repositório; PB-13 e PB-15 (pasta 23).
