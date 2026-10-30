# 17 Forense em Nuvem

## Objetivo

Investigar incidentes em ambientes de nuvem considerando responsabilidade compartilhada, recursos efêmeros e dependência de logs do provedor.

## Tópicos abordados

- Responsabilidade compartilhada e limites de acesso do investigador
- Fontes: logs de API, de controle, de rede e de armazenamento
- Snapshots de discos e volatilidade de recursos efêmeros
- Identidades, chaves, tokens e permissões comprometidas
- Contêineres e serverless
- Jurisdição, contratos e retenção de dados

## Procedimento de referência

1. Definir o escopo e preservar os logs antes que expirem
2. Tirar snapshots e isolar recursos comprometidos sem destruir evidências
3. Coletar logs de API, identidade, rede e armazenamento
4. Revisar permissões, chaves e criação de recursos
5. Documentar com data, região e hash das evidências

## Ferramentas

- AWS CloudTrail e GuardDuty
- Azure Activity Log
- Google Cloud Audit Logs
- Prowler
- ScoutSuite
- Velociraptor

## Artefatos e saídas

- Inventário de logs e retenções
- Snapshots com hash
- Relatório de identidades e permissões afetadas

## Cuidados de integridade e legalidade

- Trabalhar sempre sobre cópias verificadas por hash, nunca sobre a evidência original
- Registrar ferramentas, versões, horários (em UTC) e responsáveis
- Manter a cadeia de custódia (pasta 02-cadeia-de-custodia) e atuar somente com autorização e base legal

## Arquivos previstos para expansão

- checklist-preservacao-em-nuvem.md
- guia-aws-gcp-azure-logs.md
- playbook-credenciais-comprometidas-na-nuvem.md

## Referências

- NIST SP 800-201: Cloud Computing Forensic Reference Architecture (2023)
- NIST IR 8006: NIST Cloud Computing Forensic Science Challenges (2020)
- ISO/IEC 27017:2015
- SANS FOR509: Enterprise Cloud Forensics and Incident Response
- MITRE ATT&CK (Cloud Matrix)
