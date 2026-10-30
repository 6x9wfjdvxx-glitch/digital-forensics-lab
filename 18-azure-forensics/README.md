# 18 Forense em Azure

## Objetivo

Investigar incidentes no Microsoft Azure e no Microsoft Entra ID usando logs de identidade, de atividade e de recursos.

## Tópicos abordados

- Microsoft Entra ID: logs de entrada (sign-in) e de auditoria
- Azure Activity Log, resource logs e Log Analytics (KQL)
- Snapshots de discos e de máquinas virtuais
- Storage, Key Vault e NSG flow logs
- Microsoft Defender for Cloud e Microsoft Sentinel
- Abuso de identidades: service principals, consentimento de aplicativos e papéis privilegiados

## Procedimento de referência

1. Verificar quais logs estão habilitados e as respectivas retenções
2. Exportar os logs de identidade e de atividade
3. Isolar VMs e criar snapshots dos discos
4. Consultar com KQL criações de recursos, mudanças de papéis e acessos anômalos
5. Documentar consultas, resultados e horários em UTC

## Ferramentas

- Microsoft Sentinel
- Log Analytics (KQL)
- Microsoft-Extractor-Suite
- Azure CLI e PowerShell
- CISA Untitled Goose Tool
- Defender for Cloud

## Artefatos e saídas

- Exportação de logs com hash
- Consultas KQL documentadas
- Relatório de identidades e recursos afetados

## Cuidados de integridade e legalidade

- Trabalhar sempre sobre cópias verificadas por hash, nunca sobre a evidência original
- Registrar ferramentas, versões, horários (em UTC) e responsáveis
- Manter a cadeia de custódia (pasta 02-cadeia-de-custodia) e atuar somente com autorização e base legal

## Arquivos previstos para expansão

- consultas-kql-azure.md
- checklist-azure-vm-snapshot.md
- playbook-comprometimento-entra-id.md

## Referências

- Microsoft Learn: documentação de segurança do Azure (resposta a incidentes)
- Microsoft Learn: monitoramento do Microsoft Entra
- NIST SP 800-201 (2023)
- MITRE ATT&CK (Cloud Matrix: Entra ID e Azure AD)
- SANS FOR509
