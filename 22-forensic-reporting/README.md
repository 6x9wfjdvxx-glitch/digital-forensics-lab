# 22 Relatórios Forenses

## Objetivo

Transformar a investigação em documentos defensáveis e úteis: laudos, pareceres, relatórios técnicos, relatórios de situação e executivos e comunicações regulatórias, com estrutura completa, linguagem clara e calibrada, anexos verificáveis, integridade do próprio documento, atuação como perito ou assistente técnico, contraditório e controle de qualidade por revisão de pares.

## Trilha de estudo recomendada

```mermaid
flowchart LR
    A["1. Fundamentos e tipos"] --> B["2. Estrutura do laudo"]
    B --> C["3. Redação e incerteza"]
    C --> D["4. Evidências, anexos e hashes"]
    D --> E["5. Relatórios executivos e comunicação"]
    E --> F["6. Atuação pericial e contraditório"]
    F --> G["7. Ferramentas e checklist"]
    G --> H["8. Casos e erros comuns"]
```

## Conteúdo da pasta

| Ordem | Arquivo | Objetivo |
|---|---|---|
| 1 | [fundamentos-tipos-e-requisitos-do-relatorio-forense.md](fundamentos-tipos-e-requisitos-do-relatorio-forense.md) | Tipos, públicos, princípios, fato versus opinião e enquadramento legal |
| 2 | [estrutura-do-laudo-e-do-relatorio-tecnico.md](estrutura-do-laudo-e-do-relatorio-tecnico.md) | Seções do laudo, respostas a quesitos e parecer do assistente técnico |
| 3 | [redacao-tecnica-clareza-e-comunicacao-de-incerteza.md](redacao-tecnica-clareza-e-comunicacao-de-incerteza.md) | Linguagem, escalas de confiança, vieses e figuras |
| 4 | [evidencias-anexos-hashes-e-reprodutibilidade.md](evidencias-anexos-hashes-e-reprodutibilidade.md) | Anexos, hashes, reprodutibilidade, redação segura e assinatura |
| 5 | [relatorios-executivos-de-incidentes-e-comunicacao-com-stakeholders.md](relatorios-executivos-de-incidentes-e-comunicacao-com-stakeholders.md) | SITREP, relatório executivo, notificações e privilégio |
| 6 | [atuacao-pericial-assistencia-tecnica-e-contraditorio.md](atuacao-pericial-assistencia-tecnica-e-contraditorio.md) | Papéis, processo pericial, quesitos, ética e inquirição |
| 7 | [ferramentas-fluxo-modelos-e-checklist-de-relatorios-forenses.md](ferramentas-fluxo-modelos-e-checklist-de-relatorios-forenses.md) | Pandoc, fluxo de revisão, modelos e checklist |
| 8 | [casos-de-uso-e-erros-comuns-em-relatorios-forenses.md](casos-de-uso-e-erros-comuns-em-relatorios-forenses.md) | Sete cenários, erros comuns e exercícios |

## Princípios

- Imparcialidade, veracidade e objetividade: o relatório expõe fatos e análise, e não advoga
- Separar fatos observados, inferências e opiniões, e remeter cada afirmação a evidências referenciadas
- Declarar método, ferramentas, validação, premissas, limitações e grau de confiança
- Considerar hipóteses alternativas e apresentar as evidências contrárias
- Responder a todos os quesitos, dentro do escopo do encargo, sem opiniões jurídicas
- Normalizar horários em UTC e permitir a reprodução dos resultados por terceiros
- Proteger dados pessoais com minimização, pseudonimização e redação verdadeira
- Revisão por pares, assinatura, hash e carimbo de tempo; comunicação calibrada em incidentes

## Relação com outras pastas

- 01-fundamentos, 02-cadeia-de-custodia e 04-hash-e-integridade: princípios, custódia e hashes que alimentam o relatório
- 05-timeline-analysis: linha do tempo e normalização de tempo
- 06-evidencias-digitais: valor probatório e admissibilidade
- 16-ransomware-investigation: comunicação de incidentes, notificações e relatórios para a direção
- 21-osint-for-investigations: preservação e relatórios de fontes abertas
- 23-forensic-playbooks: modelos operacionais que geram os registros do relatório
- 30-lessons-learned: relatório pós-incidente e melhoria contínua

## Referências

- ISO/IEC 27037, 27041, 27042 e 27043; ISO/IEC 17025; NIST IR 8354 (2022); NIST SP 800-86; NIST CFTT
- ENFSI. Best Practice Manual for the Forensic Examination of Digital Technology; Guideline for Evaluative Reporting in Forensic Science (2015)
- Casey, E. Digital Evidence and Computer Crime. 3. ed. (2011); Casey, E. Error, uncertainty, and loss in digital evidence (2002)
- National Research Council. Strengthening Forensic Science in the United States: A Path Forward (2009)
- Brasil. CPC (Lei nº 13.105/2015), arts. 156 a 158 e 464 a 480; CPP, arts. 158-A a 158-F e 159; Código Penal, art. 342
- Brasil. LGPD (Lei nº 13.709/2018); Resolução CD/ANPD nº 15/2024; MP nº 2.200-2/2001 e Lei nº 14.063/2020
- Daubert v. Merrell Dow Pharmaceuticals (1993); Regra 702 das Regras Federais de Prova dos EUA
- RFC 3161 (carimbo do tempo); ISO 19005 (PDF/A); documentação do Pandoc
- NIST SP 800-61 Rev. 3; CISA #StopRansomware Guide
