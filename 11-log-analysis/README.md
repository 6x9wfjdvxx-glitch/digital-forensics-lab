# 11 Análise de Logs

## Objetivo

Coletar, normalizar e analisar logs de sistemas, aplicações, rede, identidade e nuvem para reconstruir eventos e detectar atividades maliciosas.

## Tópicos abordados

- Fontes de log: sistema operacional, aplicações, rede, identidade e nuvem
- Normalização, sincronização de tempo e retenção
- Eventos Windows prioritários: 4624, 4625, 4688, 4672, 7045 e 1102
- Syslog, auditd e logs web (Apache, Nginx e IIS)
- Detecção com regras Sigma e consultas (KQL e SPL)
- Integridade dos logs e centralização em SIEM

## Procedimento de referência

1. Mapear e coletar as fontes relevantes preservando o original
2. Normalizar horários e formatos
3. Buscar padrões de autenticação, privilégios, execução e persistência
4. Correlacionar entre as fontes
5. Documentar as consultas, os resultados e as limitações

## Ferramentas

- Chainsaw
- Hayabusa
- Sigma
- Splunk
- Elastic e OpenSearch
- Wazuh
- Microsoft Sentinel (KQL)
- Log Parser

## Artefatos e saídas

- Relatório de análise de logs
- Biblioteca de consultas e regras
- Inventário de fontes de log

## Cuidados de integridade e legalidade

- Trabalhar sempre sobre cópias verificadas por hash, nunca sobre a evidência original
- Registrar ferramentas, versões, horários (em UTC) e responsáveis
- Manter a cadeia de custódia (pasta 02-cadeia-de-custodia) e atuar somente com autorização e base legal

## Arquivos previstos para expansão

- eventos-windows-prioritarios.md
- consultas-kql-e-spl.md
- checklist-fontes-de-log.md

## Referências

- NIST SP 800-92: Guide to Computer Security Log Management (2006)
- MITRE ATT&CK: Data Sources
- Projeto Sigma (regras de detecção)
- Lei nº 12.965/2014 (Marco Civil da Internet), arts. 13 e 15 (guarda de registros)
- ISO/IEC 27002:2022, controle 8.15 (registro de eventos)
