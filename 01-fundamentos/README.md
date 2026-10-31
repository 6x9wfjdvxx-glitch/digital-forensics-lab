# 01 Fundamentos de Forense Digital

## Objetivo

Apresentar os conceitos, princípios, fases, normas e responsabilidades da forense digital, servindo de base para todas as demais pastas do laboratório.

## Trilha de estudo recomendada

```mermaid
flowchart LR
    A["1. Glossário"] --> B["2. Princípios e volatilidade"]
    B --> C["3. Fases do processo"]
    C --> D["4. Normas e frameworks"]
    D --> E["5. Papéis e ética"]
    E --> F["6. Abertura de caso"]
    F --> G["7. Checklist operacional"]
    G --> H["8. Casos de uso corporativos"]
```

## Conteúdo da pasta

| Ordem | Arquivo | Objetivo |
|---|---|---|
| 1 | [glossario-forense.md](glossario-forense.md) | Padronizar o vocabulário técnico, jurídico e operacional |
| 2 | [principios-e-ordem-de-volatilidade.md](principios-e-ordem-de-volatilidade.md) | Princípios forenses, RFC 3227 e exemplo de coleta de dados voláteis |
| 3 | [fases-do-processo-forense.md](fases-do-processo-forense.md) | Fases do processo, relação com resposta a incidentes e diagramas |
| 4 | [normas-e-frameworks-aplicaveis.md](normas-e-frameworks-aplicaveis.md) | ISO/IEC, NIST, MITRE ATT&CK, CIS Controls, SANS e legislação |
| 5 | [papeis-responsabilidades-e-etica.md](papeis-responsabilidades-e-etica.md) | Papéis, RACI, fluxo de autorização e princípios éticos |
| 6 | [modelo-de-abertura-de-caso.md](modelo-de-abertura-de-caso.md) | Ficha de abertura, termo de autorização e exemplo preenchido |
| 7 | [checklist-operacional-de-fundamentos.md](checklist-operacional-de-fundamentos.md) | Lista de verificação do ciclo completo da investigação |
| 8 | [casos-de-uso-corporativos.md](casos-de-uso-corporativos.md) | Cinco cenários corporativos para aplicação prática |

## Princípios que orientam todo o laboratório

- Preservar a integridade da evidência original e trabalhar sobre cópias verificadas por hash
- Documentar cada ação no momento em que ocorre, com horários em UTC
- Coletar na ordem de volatilidade e somente o necessário à finalidade
- Atuar com autorização, base legal e respeito à privacidade
- Relatar de forma imparcial, reproduzível e com limitações declaradas

## Relação com outras pastas

- 02-cadeia-de-custodia: aprofunda o registro e a proteção da posse das evidências
- Pastas de coleta, hash e linha do tempo: aplicam os princípios e as fases deste módulo
- Pastas de relatórios, playbooks e lições aprendidas: formalizam o relato e a melhoria contínua

## Cuidados de integridade e legalidade

- Trabalhar sempre sobre cópias verificadas por hash, nunca sobre a evidência original
- Registrar ferramentas, versões, horários (em UTC) e responsáveis
- Manter a cadeia de custódia e atuar somente com autorização e base legal

## Referências

- NIST SP 800-86: Guide to Integrating Forensic Techniques into Incident Response (2006)
- NIST SP 800-61 Rev. 3: Incident Response Recommendations and Considerations for Cybersecurity Risk Management (2025)
- ISO/IEC 27037:2012 (ABNT NBR ISO/IEC 27037:2013); ISO/IEC 27041:2015; ISO/IEC 27042:2015; ISO/IEC 27043:2015
- RFC 3227: Guidelines for Evidence Collection and Archiving (2002)
- ACPO Good Practice Guide for Digital Evidence, versão 5 (2012)
- MITRE ATT&CK; CIS Controls v8.1; SANS Incident Handler's Handbook
- Carrier, B. File System Forensic Analysis (2005)
- Casey, E. Digital Evidence and Computer Crime. 3. ed. (2011)
