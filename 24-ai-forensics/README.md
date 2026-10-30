# 24 Forense de IA

## Objetivo

Investigar sistemas de IA e Machine Learning preservando modelos, dados, pipelines e registros de inferência para apurar adulteração, abuso e falhas.

## Tópicos abordados

- Fontes de evidência em sistemas de IA: dados, modelo, pipeline, inferência e logs
- Proveniência de dados e de modelos: linhagem, versões e hashes
- Detecção de envenenamento, backdoors e adulteração de modelos
- Ataques de extração, inversão e inferência de pertinência
- Logs de inferência, prompts, saídas, métricas e decisões
- Preservação de ambientes de MLOps e de registros de modelos

## Procedimento de referência

1. Identificar o sistema, o modelo, a versão e os componentes envolvidos
2. Preservar os artefatos (pesos, configurações, dados, logs e prompts) com hash
3. Reconstruir o ciclo de vida: treino, validação, implantação e mudanças
4. Analisar indícios de adulteração, deriva ou abuso
5. Relatar ligando a evidência técnica ao impacto

## Ferramentas

- MLflow
- DVC
- Weights & Biases
- Ferramentas de SBOM e AIBOM
- OpenTelemetry
- ModelScan
- Velociraptor

## Artefatos e saídas

- Inventário de artefatos de IA preservados
- Relatório de proveniência
- Matriz de ameaças MITRE ATLAS

## Cuidados de integridade e legalidade

- Trabalhar sempre sobre cópias verificadas por hash, nunca sobre a evidência original
- Registrar ferramentas, versões, horários (em UTC) e responsáveis
- Manter a cadeia de custódia (pasta 02-cadeia-de-custodia) e atuar somente com autorização e base legal

## Arquivos previstos para expansão

- checklist-preservacao-de-artefatos-de-ia.md
- guia-proveniencia-de-modelos.md
- mapeamento-mitre-atlas.md

## Referências

- NIST AI 100-2: Adversarial Machine Learning: A Taxonomy and Terminology of Attacks and Mitigations
- MITRE ATLAS: Adversarial Threat Landscape for AI Systems
- NIST AI 100-1: AI Risk Management Framework 1.0
- Regulamento (UE) 2024/1689 (EU AI Act), arts. 12 e 72
- ISO/IEC 42001:2023
