# 25 Forense de Prompts

## Objetivo

Analisar prompts, conversas e rastros de ferramentas de aplicações com LLM para investigar injeção, vazamento e abuso.

## Tópicos abordados

- Prompts, system prompts, histórico de conversas e tool calls como evidência
- Injeção de prompt direta e indireta e jailbreaks
- Vazamento de dados e do prompt de sistema
- Reconstrução de sessões, atribuição de usuário e linha do tempo
- Retenção, privacidade e minimização dos logs de prompts
- Agentes: rastreamento de ações, permissões e agência excessiva

## Procedimento de referência

1. Preservar os logs de prompts, respostas, metadados e tool calls com hash
2. Reconstruir a sessão e a sequência de eventos
3. Identificar padrões de injeção, jailbreak ou exfiltração
4. Avaliar o que foi exposto ou executado
5. Documentar o impacto e as correções: filtros, privilégios e monitoramento

## Ferramentas

- Langfuse e OpenTelemetry
- SIEM
- Scripts de análise em Python
- garak
- PyRIT

## Artefatos e saídas

- Dossiê de sessão (prompts, respostas e tool calls)
- Relatório de injeção e exfiltração
- Recomendações de controles

## Cuidados de integridade e legalidade

- Trabalhar sempre sobre cópias verificadas por hash, nunca sobre a evidência original
- Registrar ferramentas, versões, horários (em UTC) e responsáveis
- Manter a cadeia de custódia (pasta 02-cadeia-de-custodia) e atuar somente com autorização e base legal

## Arquivos previstos para expansão

- checklist-coleta-de-logs-de-llm.md
- guia-reconstrucao-de-sessao.md
- catalogo-de-padroes-de-injecao.md

## Referências

- OWASP Top 10 for LLM Applications (2025)
- MITRE ATLAS: AML.T0051 (LLM Prompt Injection) e AML.T0054 (LLM Jailbreak)
- NIST AI 100-2: Adversarial Machine Learning
- Lei nº 13.709/2018 (LGPD), arts. 6º e 46
- Pasta 22-governanca-de-llm-e-generative-ai do repositório ai-governance-framework
