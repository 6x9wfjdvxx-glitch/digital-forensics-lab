# 26 Investigação de Incidentes com LLM

## Objetivo

Conduzir a resposta e a investigação de incidentes envolvendo LLMs e IA Generativa, da detecção à lição aprendida.

## Tópicos abordados

- Tipos de incidente: vazamento de dados, jailbreak, injeção, agência excessiva, envenenamento de RAG, cadeia de suprimentos e abuso de consumo
- Classificação de severidade e critérios de acionamento
- Contenção: desativar funcionalidades, revogar chaves e restringir ferramentas
- Análise de causa raiz em aplicações com RAG, plugins e agentes
- Notificação a titulares, a autoridades e a clientes
- Lições aprendidas e correções

## Procedimento de referência

1. Detectar, triar e classificar a severidade do incidente
2. Conter: limitar acessos, revogar credenciais e suspender integrações
3. Coletar e preservar prompts, logs, configurações e versões
4. Analisar a causa raiz e o impacto: dados, decisões e ações executadas
5. Comunicar, corrigir e registrar as lições aprendidas

## Ferramentas

- SIEM
- Langfuse e OpenTelemetry
- garak
- PyRIT
- Plataformas de gestão de incidentes
- Velociraptor

## Artefatos e saídas

- Relatório de incidente de LLM
- Linha do tempo
- Plano de ação corretiva

## Cuidados de integridade e legalidade

- Trabalhar sempre sobre cópias verificadas por hash, nunca sobre a evidência original
- Registrar ferramentas, versões, horários (em UTC) e responsáveis
- Manter a cadeia de custódia (pasta 02-cadeia-de-custodia) e atuar somente com autorização e base legal

## Arquivos previstos para expansão

- playbook-vazamento-de-dados-em-llm.md
- playbook-prompt-injection.md
- template-relatorio-de-incidente-llm.md

## Referências

- OWASP Top 10 for LLM Applications (2025)
- NIST AI 100-1 (função Manage)
- ISO/IEC 27035-1:2023
- Regulamento (UE) 2024/1689 (EU AI Act), art. 73 (comunicação de incidentes graves)
- Resolução CD/ANPD nº 15/2024 e pastas 18, 22 e 23 do repositório ai-governance-framework
