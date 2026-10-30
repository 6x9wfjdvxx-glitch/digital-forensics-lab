# 05 Análise de Linha do Tempo

## Objetivo

Reconstruir a sequência de eventos de um incidente correlacionando carimbos de data e hora de múltiplas fontes.

## Tópicos abordados

- Carimbos de data e hora MACB (Modified, Accessed, Changed, Born)
- Fusos horários, UTC e desvio de relógio
- Super timeline: combinação de múltiplas fontes
- Pivoteamento e filtragem por janela de tempo
- Detecção de manipulação de timestamps (timestomping)
- Correlação com eventos externos: rede, e-mail e nuvem

## Procedimento de referência

1. Normalizar todos os horários para UTC e documentar o fuso de cada fonte
2. Gerar a linha do tempo com o Plaso a partir das imagens
3. Filtrar por janela de interesse e por tipo de artefato
4. Marcar eventos-chave e hipóteses
5. Validar os eventos críticos com ao menos duas fontes independentes

## Ferramentas

- Plaso (log2timeline e psort)
- Timesketch
- Autopsy Timeline
- Timeline Explorer
- MFTECmd

## Artefatos e saídas

- Super timeline
- Linha do tempo resumida do incidente
- Registro de eventos-chave e fontes

## Cuidados de integridade e legalidade

- Trabalhar sempre sobre cópias verificadas por hash, nunca sobre a evidência original
- Registrar ferramentas, versões, horários (em UTC) e responsáveis
- Manter a cadeia de custódia (pasta 02-cadeia-de-custodia) e atuar somente com autorização e base legal

## Arquivos previstos para expansão

- guia-super-timeline.md
- template-timeline-do-incidente.md
- checklist-validacao-de-horarios.md

## Referências

- Documentação do Plaso (log2timeline)
- Timesketch (projeto de código aberto)
- SANS FOR508: Advanced Incident Response, Threat Hunting and Digital Forensics
- Carrier, B. File System Forensic Analysis (2005)
- MITRE ATT&CK T1070.006: Indicator Removal, Timestomp
