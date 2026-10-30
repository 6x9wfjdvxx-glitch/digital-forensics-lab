# 10 Forense de Disco

## Objetivo

Adquirir e analisar discos e volumes, recuperando arquivos e metadados com preservação da integridade.

## Tópicos abordados

- Estruturas de disco: MBR, GPT, partições e volumes
- Sistemas de arquivos (NTFS, FAT e exFAT, ext4 e APFS): metadados e alocação
- Imagens forenses (RAW/dd, E01 e AFF4) e bloqueio de escrita
- Recuperação de arquivos excluídos e file carving
- Espaço não alocado, slack space e fluxos de dados alternativos (ADS)
- Discos criptografados (BitLocker, FileVault e LUKS) e seus desafios

## Procedimento de referência

1. Conectar o dispositivo com bloqueador de escrita
2. Criar a imagem e verificar o hash
3. Montar a imagem em modo somente leitura
4. Analisar o sistema de arquivos, os arquivos excluídos e os artefatos
5. Registrar os métodos, os caminhos e os resultados

## Ferramentas

- FTK Imager
- Autopsy e The Sleuth Kit
- X-Ways Forensics (comercial)
- EnCase (comercial)
- PhotoRec
- Bulk Extractor
- libewf (ewf-tools)

## Artefatos e saídas

- Imagem forense (E01) com hash
- Relatório de arquivos excluídos recuperados
- Mapa de partições e volumes

## Cuidados de integridade e legalidade

- Trabalhar sempre sobre cópias verificadas por hash, nunca sobre a evidência original
- Registrar ferramentas, versões, horários (em UTC) e responsáveis
- Manter a cadeia de custódia (pasta 02-cadeia-de-custodia) e atuar somente com autorização e base legal

## Arquivos previstos para expansão

- checklist-imagem-de-disco.md
- guia-file-carving.md
- tratamento-de-discos-criptografados.md

## Referências

- Carrier, B. File System Forensic Analysis (2005)
- NIST Computer Forensic Tool Testing (CFTT) Program
- ISO/IEC 27037:2012
- SANS FOR500: Windows Forensic Analysis
- Microsoft Learn: documentação técnica do NTFS
