# 20 Threat Hunting

## Objetivo

Estruturar a caça proativa a ameaças orientada por hipóteses, inteligência e dados, transformando achados em detecções contínuas.

## Tópicos abordados

- Caça orientada por hipótese e por inteligência
- Frameworks: MITRE ATT&CK, TaHiTI e PEAK
- Pirâmide da Dor e maturidade de hunting
- Fontes de dados: EDR, logs, rede e nuvem
- Consultas, regras Sigma e automação
- Medição e conversão de caças em detecções

## Procedimento de referência

1. Formular a hipótese com base em inteligência e no ATT&CK
2. Definir as fontes de dados e o escopo
3. Executar as consultas e analisar as anomalias
4. Validar os achados e escalar para resposta a incidentes
5. Documentar e transformar em detecção contínua

## Ferramentas

- Velociraptor
- Sigma
- osquery
- KQL (Defender e Sentinel)
- Splunk
- Zeek
- YARA

## Artefatos e saídas

- Plano de hunting
- Relatório de hipóteses e resultados
- Detecções criadas

## Cuidados de integridade e legalidade

- Trabalhar sempre sobre cópias verificadas por hash, nunca sobre a evidência original
- Registrar ferramentas, versões, horários (em UTC) e responsáveis
- Manter a cadeia de custódia (pasta 02-cadeia-de-custodia) e atuar somente com autorização e base legal

## Arquivos previstos para expansão

- template-hipotese-de-hunting.md
- biblioteca-de-hunts.md
- metricas-de-hunting.md

## Referências

- MITRE ATT&CK
- Bianco, D. The Pyramid of Pain (2013) e Hunting Maturity Model
- Splunk SURGe: PEAK Threat Hunting Framework
- TaHiTI: Targeted Hunting integrating Threat Intelligence
- SANS FOR508: Advanced Incident Response, Threat Hunting and Digital Forensics
