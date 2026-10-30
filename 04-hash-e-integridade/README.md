# 04 Hash e Integridade

## Objetivo

Padronizar o uso de funções de hash para comprovar a integridade das evidências em toda a sua vida útil.

## Tópicos abordados

- Funções de hash criptográficas (SHA-256 e SHA-3) e suas propriedades
- Fragilidades de MD5 e SHA-1 e seu uso residual em verificações de integridade
- Hash de arquivos, volumes e imagens forenses
- Listas de hashes conhecidos (NSRL) e filtragem de arquivos
- Hash difuso (ssdeep e TLSH) para identificar similaridade
- Verificação de hash em cada transferência

## Procedimento de referência

1. Calcular o hash da fonte antes da aquisição, quando possível
2. Calcular o hash da imagem após a aquisição
3. Comparar e registrar os resultados
4. Verificar novamente a cada cópia ou transferência
5. Armazenar os hashes em registro separado e protegido

## Ferramentas

- sha256sum
- Get-FileHash (PowerShell)
- hashdeep
- FTK Imager
- ssdeep
- TLSH

## Artefatos e saídas

- Registro de hashes
- Procedimento de verificação
- Relatório de divergências

## Cuidados de integridade e legalidade

- Trabalhar sempre sobre cópias verificadas por hash, nunca sobre a evidência original
- Registrar ferramentas, versões, horários (em UTC) e responsáveis
- Manter a cadeia de custódia (pasta 02-cadeia-de-custodia) e atuar somente com autorização e base legal

## Arquivos previstos para expansão

- procedimento-de-verificacao-de-hash.md
- registro-de-hashes.md
- guia-de-hash-difuso.md

## Referências

- NIST FIPS 180-4: Secure Hash Standard (SHS)
- NIST FIPS 202: SHA-3 Standard
- NIST National Software Reference Library (NSRL)
- ISO/IEC 27037:2012
- Kornblum, J. Identifying almost identical files using context triggered piecewise hashing (2006)
