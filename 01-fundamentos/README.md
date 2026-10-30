# 01 Fundamentos de Forense Digital

## Objetivo

Apresentar os conceitos, princípios, fases e responsabilidades da forense digital, servindo de base para as demais pastas.

## Tópicos abordados

- Definição e ramos da forense digital (computadores, redes, memória, dispositivos móveis, nuvem e IA)
- Princípio da troca de Locard e princípio de não alteração da evidência original
- Fases do processo forense: coleta, exame, análise e relato (NIST SP 800-86)
- Ordem de volatilidade das evidências (RFC 3227)
- Forense, resposta a incidentes e e-discovery: diferenças e interfaces
- Papéis: perito oficial, assistente técnico e analista de DFIR
- Ética, imparcialidade e limites de atuação

## Procedimento de referência

1. Definir o objetivo da investigação e a autoridade legal para realizá-la
2. Preservar o estado dos sistemas e documentar tudo desde o início
3. Coletar as evidências na ordem de volatilidade
4. Examinar e analisar sobre cópias, nunca sobre o original
5. Relatar de forma objetiva, reproduzível e imparcial

## Ferramentas

- Ambiente de laboratório (pasta 29-forensic-tools-lab)
- SIFT Workstation
- Autopsy

## Artefatos e saídas

- Termo de abertura da investigação
- Registro de decisões e premissas
- Glossário e modelo de caso

## Cuidados de integridade e legalidade

- Trabalhar sempre sobre cópias verificadas por hash, nunca sobre a evidência original
- Registrar ferramentas, versões, horários (em UTC) e responsáveis
- Manter a cadeia de custódia (pasta 02-cadeia-de-custodia) e atuar somente com autorização e base legal

## Arquivos previstos para expansão

- glossario-forense.md
- fases-do-processo-forense.md
- modelo-de-abertura-de-caso.md

## Referências

- NIST SP 800-86: Guide to Integrating Forensic Techniques into Incident Response (2006)
- ISO/IEC 27037:2012 (ABNT NBR ISO/IEC 27037:2013): Identificação, coleta, aquisição e preservação de evidência digital
- ISO/IEC 27043:2015: Princípios e processos de investigação de incidentes
- RFC 3227: Guidelines for Evidence Collection and Archiving (2002)
- Carrier, B. File System Forensic Analysis (2005)
