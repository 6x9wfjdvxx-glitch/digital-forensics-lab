# 27 Investigação de Deepfakes

## Objetivo

Investigar mídias sintéticas ou manipuladas combinando análise técnica, proveniência e contexto, com transparência sobre o grau de confiança.

## Tópicos abordados

- Tipos: troca de rosto, síntese de voz, imagens e vídeos gerados
- Análise de metadados, codecs e histórico de edição
- Indícios visuais e acústicos de síntese e suas limitações
- Proveniência e autenticidade: C2PA (Content Credentials) e marcas d'água
- Fraudes com deepfake: fraude do CEO, extorsão e falsa identidade
- Aspectos legais e preservação da evidência original

## Procedimento de referência

1. Preservar o arquivo original com hash e a origem do conteúdo
2. Extrair e analisar metadados, codecs e a cadeia de distribuição
3. Aplicar múltiplas técnicas de análise visual, de áudio e de proveniência
4. Verificar o contexto e as fontes originais
5. Relatar o grau de confiança e as limitações (nenhum detector é conclusivo isoladamente)

## Ferramentas

- ExifTool
- FFmpeg
- InVID-WeVerify
- Sonic Visualiser
- Verificadores de Content Credentials (C2PA)
- Amped Authenticate (comercial)

## Artefatos e saídas

- Relatório de autenticidade
- Registro de proveniência
- Parecer com grau de confiança

## Cuidados de integridade e legalidade

- Trabalhar sempre sobre cópias verificadas por hash, nunca sobre a evidência original
- Registrar ferramentas, versões, horários (em UTC) e responsáveis
- Manter a cadeia de custódia (pasta 02-cadeia-de-custodia) e atuar somente com autorização e base legal

## Arquivos previstos para expansão

- checklist-analise-de-video.md
- checklist-analise-de-audio.md
- playbook-fraude-com-deepfake.md

## Referências

- C2PA: Technical Specification (Content Credentials)
- NIST GenAI Evaluation Program
- Regulamento (UE) 2024/1689 (EU AI Act), art. 50 (transparência para conteúdo sintético)
- Código Penal, arts. 171 (estelionato) e 307 (falsa identidade)
- Berkeley Protocol on Digital Open Source Investigations (ONU, 2020)
