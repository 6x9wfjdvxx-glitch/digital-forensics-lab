# Metodologia de Estudos de Caso Forenses

> **Objetivo pedagógico:** definir como estudar, escrever e usar estudos de caso forenses para treinamento: tipos de caso, estrutura padrão, perguntas de análise por fase, uso do raciocínio por hipóteses e do livro de decisões, mapeamento entre casos, pastas e playbooks, formatos de aplicação (leitura guiada, exercício de mesa, laboratório e redação de relatório), e regras éticas e legais para casos fictícios e públicos.

## 1. Por que estudar casos

Os fundamentos das pastas 01 a 27 ensinam técnicas isoladas. Em um incidente real, elas aparecem **combinadas, sob pressão, com informação incompleta e com decisões que não têm resposta única**. Os estudos de caso treinam:

| Competência | Como o caso a treina |
|---|---|
| Priorização | Decidir o que preservar primeiro quando tudo é urgente |
| Integração | Correlacionar fontes de naturezas diferentes (identidade, rede, endpoint, nuvem e IA) |
| Raciocínio por hipóteses | Sustentar e descartar hipóteses com evidências |
| Decisão sob incerteza | Escolher entre alternativas imperfeitas e registrar a justificativa |
| Comunicação | Informar direção, jurídico e usuários com fatos e incertezas |
| Conformidade | Identificar obrigações legais e contratuais e seus prazos |
| Aprendizado | Converter falhas em controles |

## 2. Tipos de estudo de caso

| Tipo | Descrição | Vantagens | Cuidados |
|---|---|---|---|
| Caso fictício completo | Cenário inventado, com cronologia, evidências e decisões, de ponta a ponta | Controle didático; sem risco de exposição de dados reais | Realismo: baseie-se em padrões documentados |
| Caso composto | Mistura de elementos de vários incidentes reais, anonimizados | Riqueza de detalhes | Garantir que ninguém seja identificável |
| Análise de incidente público | Estudo de um incidente amplamente documentado, a partir de fontes primárias | Autenticidade e discussão de decisões reais | Distinguir fato, relato e inferência; não especular (arquivo 7) |
| Caso de laboratório com dados sintéticos | Conjunto de logs e artefatos gerados para análise prática | Treino técnico prático | Documentar a geração dos dados |
| Caso de mesa (tabletop) | Cenário narrado com "injetos" de informação ao longo do tempo | Treino de decisão e de comunicação | Facilitação e objetivos claros |

## 3. Estrutura padrão de um estudo de caso

| Seção | Conteúdo |
|---|---|
| Resumo | Organização, ameaça, impacto, desfecho e pastas relacionadas |
| Contexto e ativos | Ambiente, sistemas, dados e controles existentes |
| Gatilho e abertura | Como o caso começou; classificação e autorização (PB-00) |
| Cronologia | Linha do tempo em UTC, com fontes |
| Evidências | Identificadores, fontes, hashes e custódia |
| Análise por fase | Reconstrução técnica com consultas e comandos de exemplo |
| Decisões críticas | Opções, critérios, decisão tomada e justificativa |
| Impacto e obrigações | Dados, pessoas, financeiro, legal e contratual |
| Resultado e recuperação | O que foi feito e o resultado |
| Trecho de relatório | Exemplo de resumo executivo e de achado com grau de confiança |
| O que funcionou e o que falhou | Balanço objetivo, sem culpabilizar pessoas |
| Lições aprendidas | Controles e melhorias |
| Mapeamento | Pastas e playbooks relacionados |
| Perguntas de discussão | Para estudo individual ou em grupo |
| Exercícios | Atividades práticas |

## 4. Perguntas de análise por fase

| Fase | Perguntas-guia |
|---|---|
| Detecção e abertura | Quem detectou, quando e como? Qual a gravidade? Há autorização e escopo? O que pode ser perdido nas próximas horas? |
| Preservação | Quais fontes expiram primeiro? O que foi congelado antes de qualquer alteração? Qual a ordem de volatilidade? |
| Reconstrução | Qual o primeiro indício de atividade? Qual o acesso inicial? Como o atacante se moveu? O que foi acessado e exfiltrado? |
| Hipóteses | Que hipóteses explicam os fatos? Que evidência discriminaria entre elas? Que explicação inocente existe? |
| Contenção | A ação preserva evidências e reduz o dano? Qual o estado anterior registrado? |
| Impacto | Que dados, pessoas e decisões foram afetados? Qual o pior caso plausível dado o que não se sabe? |
| Obrigações | Que notificações e prazos se aplicam? Quem decide? |
| Comunicação | O que sabemos e o que não sabemos? Quem precisa saber e quando? |
| Aprendizado | Que controle teria impedido ou detectado antes? Que lacuna de registro prejudicou a investigação? |

## 5. Ferramentas de trabalho do caso

| Ferramenta | Uso |
|---|---|
| Livro de decisões | Cada decisão, com data e hora, responsável, alternativas, critérios e justificativa |
| Linha do tempo em UTC | Eventos com fonte, confiança e corroboração (pasta 05) |
| Matriz de hipóteses | Hipótese, evidências a favor, evidências contra e conclusão provisória |
| Inventário de evidências | Identificador, origem, hash e custódia |
| Registro de lacunas | Logs ausentes, expirados ou não habilitados |
| Matriz de obrigações | Norma, gatilho, prazo, responsável e status |

## 6. Mapeamento dos casos para as pastas e os
