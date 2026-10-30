# 19 Forense em Microsoft 365

## Objetivo

Investigar incidentes em Microsoft 365, com foco em BEC, abuso de contas, consentimento OAuth e acesso a dados colaborativos.

## Tópicos abordados

- Unified Audit Log (Microsoft Purview) e retenção conforme licença
- Exchange Online: auditoria de caixa de correio, message trace e regras de caixa
- BEC: encaminhamentos, regras ocultas e consentimento OAuth
- SharePoint e OneDrive: acessos e compartilhamentos
- Teams e atividades colaborativas
- Microsoft Defender XDR: advanced hunting

## Procedimento de referência

1. Confirmar quais auditorias estão habilitadas e a retenção
2. Exportar o Unified Audit Log e os logs de entrada
3. Revisar regras de caixa, encaminhamentos e permissões
4. Investigar consentimentos OAuth e acesso a arquivos
5. Documentar e recomendar a contenção: revogar sessões, redefinir credenciais e exigir MFA

## Ferramentas

- Microsoft Purview
- Microsoft-Extractor-Suite
- Hawk
- CISA Untitled Goose Tool
- Defender XDR (advanced hunting)
- PowerShell (Exchange Online)

## Artefatos e saídas

- Exportação do audit log com hash
- Relatório de BEC
- Lista de contas e regras comprometidas

## Cuidados de integridade e legalidade

- Trabalhar sempre sobre cópias verificadas por hash, nunca sobre a evidência original
- Registrar ferramentas, versões, horários (em UTC) e responsáveis
- Manter a cadeia de custódia (pasta 02-cadeia-de-custodia) e atuar somente com autorização e base legal

## Arquivos previstos para expansão

- checklist-bec-m365.md
- consultas-unified-audit-log.md
- playbook-consentimento-oauth.md

## Referências

- Microsoft Learn: atividades do log de auditoria (Microsoft Purview)
- Microsoft Learn: auditoria do Exchange Online
- CISA: Untitled Goose Tool
- FBI IC3: Business Email Compromise
- MITRE ATT&CK (Office 365 e SaaS)
