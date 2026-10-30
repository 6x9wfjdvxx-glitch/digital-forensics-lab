# 08 Forense em Linux

## Objetivo

Investigar sistemas Linux, incluindo servidores em produção, por meio de logs, persistência, contas e sistemas de arquivos.

## Tópicos abordados

- Sistemas de arquivos ext4, XFS e Btrfs e seus metadados
- Logs: /var/log, auth.log ou secure, journald e auditd
- Histórico de shell, cron, systemd e persistência
- Contas, chaves SSH, sudoers e escalada de privilégio
- Artefatos de pacotes, contêineres (Docker) e rootkits
- Aquisição de memória e de discos em servidores em produção

## Procedimento de referência

1. Avaliar se o sistema pode ser desligado e preservar os dados voláteis
2. Capturar a memória e os dados voláteis
3. Criar a imagem do disco ou coletar artefatos com script confiável
4. Analisar logs, persistência, usuários e conexões
5. Correlacionar e documentar os achados

## Ferramentas

- The Sleuth Kit
- Autopsy
- UAC (Unix-like Artifacts Collector)
- LiME
- AVML
- Volatility 3
- Velociraptor
- osquery

## Artefatos e saídas

- Relatório de logs e autenticação
- Inventário de persistências
- Relatório de integridade de binários

## Cuidados de integridade e legalidade

- Trabalhar sempre sobre cópias verificadas por hash, nunca sobre a evidência original
- Registrar ferramentas, versões, horários (em UTC) e responsáveis
- Manter a cadeia de custódia (pasta 02-cadeia-de-custodia) e atuar somente com autorização e base legal

## Arquivos previstos para expansão

- checklist-triagem-linux.md
- guia-logs-linux.md
- coleta-em-containers.md

## Referências

- Altheide, C.; Carvey, H. Digital Forensics with Open Source Tools (2011)
- SANS FOR577: Linux Incident Response and Threat Hunting
- Documentação do journald e do auditd (man-pages)
- MITRE ATT&CK (Linux)
