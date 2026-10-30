# 30 Lições Aprendidas

## Objetivo

Transformar cada investigação em melhoria: análise pós-incidente, causas raiz, ações corretivas e atualização de playbooks e detecções.

## Tópicos abordados

- Revisão pós-incidente sem atribuição de culpa (blameless)
- Análise de causa raiz: 5 porquês e diagrama de Ishikawa
- Métricas: MTTD, MTTR, tempo de contenção e cobertura de evidências
- Ações corretivas e preventivas com responsável e prazo
- Atualização de playbooks, detecções e treinamentos
- Base de conhecimento e compartilhamento de lições

## Procedimento de referência

1. Realizar a reunião de lições aprendidas logo após o encerramento
2. Reconstruir os fatos e a linha do tempo com as evidências
3. Identificar causas raiz e fatores contribuintes
4. Definir ações com responsável, prazo e verificação de eficácia
5. Atualizar playbooks e base de conhecimento e comunicar

## Ferramentas

- Modelos de post-mortem
- Jira ou Confluence (ou similares)
- Painéis de métricas
- Timesketch
- MITRE ATT&CK Navigator

## Artefatos e saídas

- Relatório pós-incidente
- Plano de ação corretiva
- Atualizações de playbooks

## Cuidados de integridade e legalidade

- Trabalhar sempre sobre cópias verificadas por hash, nunca sobre a evidência original
- Registrar ferramentas, versões, horários (em UTC) e responsáveis
- Manter a cadeia de custódia (pasta 02-cadeia-de-custodia) e atuar somente com autorização e base legal

## Arquivos previstos para expansão

- template-pos-incidente.md
- metricas-dfir.md
- registro-de-licoes-aprendidas.md

## Referências

- NIST SP 800-61 Rev. 3 (2025)
- ISO/IEC 27035-1:2023
- Google SRE Book: Postmortem Culture: Learning from Failure
- SANS: Incident Handler's Handbook
- ISO/IEC 27001:2022, cláusula 10.2 (não conformidade e ação corretiva)
