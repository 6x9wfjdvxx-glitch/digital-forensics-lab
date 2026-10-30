# 23 Playbooks Forenses

## Objetivo

Disponibilizar playbooks padronizados para acionar, coletar e investigar por tipo de incidente, com papéis, ordem de coleta e comunicação definidos.

## Tópicos abordados

- Estrutura padrão de um playbook forense
- Playbooks por cenário: ransomware, BEC, credenciais comprometidas, ameaça interna, exfiltração e malware
- Playbooks de IA: vazamento por LLM, prompt injection e deepfake
- Critérios de acionamento, papéis e comunicação
- Evidências obrigatórias e ordem de coleta por cenário
- Testes, exercícios e melhoria contínua

## Procedimento de referência

1. Selecionar o cenário e o playbook correspondente
2. Acionar a equipe e as comunicações definidas
3. Executar as etapas de contenção e de coleta na ordem prevista
4. Registrar as ações, as decisões e as evidências
5. Revisar o playbook após cada uso

## Ferramentas

- Velociraptor
- KAPE
- Plataformas SOAR (por exemplo, Shuffle)
- Gestão de casos (Jira ou ServiceNow)
- Formulários de cadeia de custódia

## Artefatos e saídas

- Biblioteca de playbooks
- Matriz de acionamento
- Registro de exercícios

## Cuidados de integridade e legalidade

- Trabalhar sempre sobre cópias verificadas por hash, nunca sobre a evidência original
- Registrar ferramentas, versões, horários (em UTC) e responsáveis
- Manter a cadeia de custódia (pasta 02-cadeia-de-custodia) e atuar somente com autorização e base legal

## Arquivos previstos para expansão

- playbook-ransomware.md
- playbook-bec.md
- playbook-ameaca-interna.md

## Referências

- NIST SP 800-61 Rev. 3: Incident Response Recommendations and Considerations for Cybersecurity Risk Management (2025)
- ISO/IEC 27035-1:2023: Gestão de incidentes de segurança da informação
- CISA: Incident and Vulnerability Response Playbooks (2021)
- SANS: Incident Handler's Handbook (modelo PICERL)
- MITRE ATT&CK
