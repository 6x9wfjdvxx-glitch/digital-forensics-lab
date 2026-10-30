# 16 Investigação de Ransomware

## Objetivo

Conduzir a investigação de incidentes de ransomware: vetor de acesso, escopo, exfiltração, recuperação e comunicação.

## Tópicos abordados

- Ciclo de ataque: acesso inicial, movimentação lateral, exfiltração e criptografia
- Dupla extorsão e vazamento de dados
- Identificação da família e do vetor de acesso inicial
- Análise de backups, shadow copies e possibilidade de recuperação
- Notas de resgate, carteiras e inteligência de ameaças
- Comunicação do incidente e aspectos regulatórios (LGPD e ANPD)

## Procedimento de referência

1. Conter o ataque e preservar evidências voláteis e logs
2. Identificar o paciente zero e o vetor de acesso inicial
3. Mapear o escopo: contas, hosts e dados exfiltrados
4. Avaliar os backups e as opções de recuperação
5. Documentar, notificar as partes obrigadas e consolidar as lições

## Ferramentas

- Velociraptor
- KAPE
- Volatility 3
- ID Ransomware
- No More Ransom
- Chainsaw e Hayabusa
- EDR da organização

## Artefatos e saídas

- Relatório de escopo e impacto
- Linha do tempo do ataque
- Lista de IOCs e de dados afetados

## Cuidados de integridade e legalidade

- Trabalhar sempre sobre cópias verificadas por hash, nunca sobre a evidência original
- Registrar ferramentas, versões, horários (em UTC) e responsáveis
- Manter a cadeia de custódia (pasta 02-cadeia-de-custodia) e atuar somente com autorização e base legal

## Arquivos previstos para expansão

- playbook-ransomware.md
- checklist-comunicacao-de-incidente.md
- roteiro-analise-de-vetor-inicial.md

## Referências

- CISA: #StopRansomware Guide (2023)
- No More Ransom Project
- Lei nº 13.709/2018 (LGPD), art. 48
- Resolução CD/ANPD nº 15/2024 (comunicação de incidente de segurança)
- MITRE ATT&CK T1486: Data Encrypted for Impact
