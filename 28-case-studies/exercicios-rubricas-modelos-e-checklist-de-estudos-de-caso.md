# Exercícios, Rubricas, Modelos e Checklist de Estudos de Caso

> **Objetivo pedagógico:** oferecer o material de aplicação dos estudos de caso: banco de exercícios por caso, injetos para exercícios de mesa, um pequeno conjunto de dados sintéticos para prática de análise, rubricas de avaliação com níveis de desempenho, modelos para escrever novos casos e checklist de qualidade, além dos erros comuns na análise de casos.

## 1. Banco de exercícios por competência

| Competência | Exercício | Casos |
|---|---|---|
| Preservação e priorização | Liste as fontes por ordem de perda e justifique a ordem; indique o que você exportaria nos primeiros 30 minutos | 1, 2, 4 |
| Linha do tempo | Construa a linha do tempo integrada em UTC, com fonte e confiança; identifique as lacunas | Todos |
| Hipóteses | Preencha a matriz de hipóteses; indique que evidência discriminaria entre elas | 2, 3, 4, 5 |
| Consultas e análise | Escreva as consultas de detecção e de reconstrução (KQL, SQL ou `jq`) | 1, 2, 3, 4, 5 |
| Decisão | Registre as decisões críticas com alternativas, critérios e justificativa | Todos |
| Impacto e obrigações | Preencha a matriz de obrigações com gatilho, prazo e responsável | 1, 2, 4, 5 |
| Comunicação | Redija SITREP, comunicado a usuários e resumo executivo | 1, 2, 5 |
| Relatório | Escreva o relatório com fatos, inferências, confiança e limitações | Todos |
| Recomendações | Priorize controles por impacto e esforço, com métricas de verificação | Todos |
| IA e mídias sintéticas | Reconstrua o trace, avalie a injeção e a mídia suspeita | 3, 5 |

## 2. Injetos para exercício de mesa (exemplo: caso 1)

| Hora do exercício | Injeto (informação liberada pelo facilitador) | Decisão esperada |
|---|---|---|
| T+0 | Alertas de criptografia em massa em servidores de arquivos às 02:50 | Declarar o incidente, convocar o comitê e abrir o canal fora de banda |
| T+15 min | O EDR mostra criptografia em curso em 120 máquinas; o servidor de backup não responde | Isolar segmentos; proteger backups; iniciar a preservação |
| T+30 min | A equipe de TI propõe desligar todos os servidores | Avaliar o impacto na memória e a decisão de manter sistemas-chave ligados por tempo limitado |
| T+60 min | Um e-mail dos atacantes afirma ter copiado 2 TB e exige pagamento em 72 horas | Acionar Jurídico, DPO e seguradora; adotar o pior caso para dados; não responder sem orientação |
| T+90 min | A imprensa pergunta sobre a parada da produção | Preparar a declaração com fatos e incertezas |
| T+2 h | Descobre-se que o AD foi comprometido | Planejar a reconstrução da identidade antes da restauração dos serviços |
| T+3 h | Surge dúvida sobre o prazo de comunicação à ANPD | Definir o marco da ciência e preparar a comunicação preliminar |
| T+4 h | Um diretor propõe pagar o resgate para acelerar a retomada | Registrar critérios, riscos, restrições legais e a decisão |

Injetos análogos podem ser criados para os demais casos, alterando as informações e as pressões (financeiras, de imprensa e jurídicas).

## 3. Conjunto de dados sintéticos para prática (caso 1: VPN e controladores de domínio)

Salve os arquivos abaixo em uma pasta de laboratório e use o DuckDB (ou Python) para analisá-los. Os dados são **inteiramente fictícios**.

`vpn_logs.csv`

```
horario_utc,usuario,ip_origem,perfil,mfa_usado,resultado
2026-08-27T13:05:10Z,svc-manut,198.51.100.10,legado,nao,sucesso
2026-08-28T13:10:44Z,svc-manut,198.51.100.10,legado,nao,sucesso
2026-09-02T03:12:08Z,svc-manut,203.0.113.45,legado,nao,sucesso
2026-09-02T03:40:19Z,svc-manut,203.0.113.45,legado,nao,sucesso
2026-09-03T02:58:31Z,svc-manut,203.0.113.45,legado,nao,sucesso
2026-09-03T14:00:02Z,ana.silva,198.51.100.22,padrao,sim,sucesso
2026-09-04T09:12:55Z,carlos.lima,198.51.100.31,padrao,sim,sucesso
```

`eventos_dc.csv`

```
horario_utc,evento_id,usuario,origem,detalhe
2026-09-08T22:40:11Z,4769,svc-sql,SRV-SALTO01,tiquete_rc4
2026-09-08T22:40:15Z,4769,svc-erp,SRV-SALTO01,tiquete_rc4
2026-09-08T22:40:19Z,4769,svc-backup,SRV-SALTO01,tiquete_rc4
2026-09-12T04:30:02Z,4662,adm-ti02,SRV-SALTO01,replicacao_diretorio
2026-09-15T02:20:40Z,7045,adm-ti02,DC01,novo_servico_executavel
```

```sql
-- DuckDB: acessos pelo perfil legado fora do padrão de origem e de horário
SELECT usuario, ip_origem, count(*) AS acessos,
       min(CAST(horario_utc AS TIMESTAMP)) AS primeiro, max(CAST(horario_utc AS TIMESTAMP)) AS ultimo
FROM read_csv_auto('vpn_logs.csv')
WHERE perfil = 'legado' AND mfa_usado = 'nao'
GROUP BY usuario, ip_origem
ORDER BY primeiro;

-- Linha do tempo combinada dos dois conjuntos
SELECT horario_utc, 'vpn' AS fonte, usuario, ip_origem AS origem, perfil AS detalhe FROM read_csv_auto('vpn_logs.csv')
UNION ALL
SELECT horario_utc, 'dc', usuario, origem, detalhe FROM read_csv_auto('eventos_dc.csv')
ORDER BY horario_utc;
```

**Perguntas:** qual acesso foge do padrão de origem e de horário? Que sequência liga o acesso por VPN às ações nos controladores de domínio? Que evidências adicionais você buscaria?

## 4. Rubrica de avaliação de uma análise de caso

Pontue cada critério de 0 a 4 (0: ausente; 1: insuficiente; 2: parcial; 3: adequado; 4: exemplar).

| Critério | 1 (insuficiente) | 3 (adequado) | 4 (exemplar) |
|---|---|---|---|
| Preservação e priorização | Preserva sem critério ou depois de conter | Prioriza por volatilidade e retenção, e preserva antes de conter | Justifica a ordem, registra estado anterior e considera lacunas de logs |
| Linha do tempo | Eventos soltos, horários mistos | Linha em UTC, com fontes | Corroboração por segunda fonte, confiança e lacunas declaradas |
| Raciocínio por hipóteses | Uma única explicação | Hipóteses alternativas com evidências a favor e contra | Identifica o que discriminaria as hipóteses e declara confiança |
| Rigor probatório | Sem hashes ou custódia | Hashes, custódia e separação entre fato e inferência | Reprodutibilidade, validação de ferramentas e limitações explícitas |
| Decisões | Ações sem justificativa | Decisões com critérios | Alternativas, riscos, trade-offs e registro no livro de decisões |
| Conformidade e privacidade | Ignora obrigações | Identifica obrigações e portões legais | Prazos, proporcionalidade, minimização e pior caso fundamentado |
| Comunicação | Técnica e confusa | Clara para o público | Distingue "sabemos" e "não sabemos"; adequada a cada destinatário |
| Recomendações | Genéricas | Específicas e priorizadas | Verificáveis, com responsáveis, prazos e métricas |
| Integração entre pastas | Usa técnicas isoladas | Aplica as pastas e os playbooks relevantes | Combina fontes de naturezas diferentes e explica as dependências |

**Níveis globais:** 0 a 12 iniciante; 13 a 22 em desenvolvimento; 23 a 30 proficiente; 31 a 36 avançado.

## 5. Modelo para escrever um novo estudo de caso

| Campo | Orientação |
|---|---|
| Título e tipo | Fictício, composto, laboratório ou público |
| Declaração de natureza | "Caso fictício, para treinamento", com aviso sobre dados sintéticos |
| Objetivos de aprendizagem | 3 a 5 objetivos mensuráveis, ligados às pastas |
| Resumo | Organização, ameaça, impacto, detecção e desfecho |
| Contexto e controles existentes | O ambiente e as lacunas relevantes |
| Cronologia | Em UTC, com fontes |
| Evidências | Identificadores e origem; consultas e comandos de exemplo |
| Dilemas e decisões | Opções realistas, sem "resposta óbvia" |
| Impacto e obrigações | Dados, financeiro, legal e contratual |
| Trecho de relatório | Fatos, inferências, confiança e limitações |
| O que funcionou e o que falhou | Sem culpabilizar indivíduos |
| Lições e recomendações | Priorizadas e verificáveis |
| Mapeamento | Pastas e playbooks |
| Perguntas e exercícios | Discussão e prática |
| Referências | Normas, documentação e fontes públicas |

## 6. Checklist de qualidade de um estudo de caso

**Caso:** ____________________
**Autor e revisor:** ____________________
**Data:** ____________________

### 6.1 Conteúdo

- [ ] Natureza do caso declarada (fictício, composto, laboratório ou público)
- [ ] Objetivos de aprendizagem claros e ligados às pastas e aos playbooks
- [ ] Cronologia coerente, em UTC, com fontes
- [ ] Evidências e análises realistas (consultas e comandos plausíveis)
- [ ] Decisões com dilemas reais e justificativas
- [ ] Impacto e obrigações legais coerentes com a LGPD e a regulação aplicável
- [ ] Lições e recomendações específicas, priorizadas e verificáveis

### 6.2 Ética e segurança

- [ ] Dados e identidades inteiramente fictícios (ou anonimizados de forma irreversível)
- [ ] IPs e domínios em faixas reservadas para documentação ou exemplos
- [ ] Sem instruções operacionais de ataque; comportamentos do adversário descritos apenas no nível necessário à detecção
- [ ] Sem conteúdo ilícito, íntimo ou ofensivo
- [ ] Casos públicos com fontes primárias, datas e distinção entre fato, relato e inferência
- [ ] Nenhuma especulação sobre pessoas ou organizações além das fontes

### 6.3 Aplicação

- [ ] Perguntas de discussão e exercícios incluídos
- [ ] Rubrica de avaliação aplicável
- [ ] Injetos de mesa e dados sintéticos, quando adequados
- [ ] Revisão por pares realizada

## 7. Erros comuns na análise de estudos de caso

| Erro | Consequência | Prevenção |
|---|---|---|
| Procurar "a resposta certa" única | Rigidez e perda de aprendizado sobre decisões sob incerteza | Discutir alternativas e trade-offs |
| Concluir com base em hindsight (o que se sabe depois) | Julgamento injusto das decisões tomadas | Avaliar a decisão com a informação disponível à época |
| Culpar indivíduos | Cultura de medo e perda de aprendizado | Focar em sistemas e processos |
| Tratar a atribuição como fato | Conclusões frágeis | Citar como declaração da fonte e declarar a confiança |
| Ignorar as lacunas de registros | Conclusões excessivas | Registrar lacunas e adotar o pior caso para o impacto |
| Misturar fato, inferência e opinião | Relatórios inconsistentes | Separar explicitamente |
| Aplicar técnicas isoladas sem integrar as fontes | Visão incompleta | Correlacionar identidade, rede, endpoint, nuvem e IA |
| Esquecer as obrigações legais e os prazos | Descumprimentos | Matriz de obrigações desde o início |
| Usar dados reais no treinamento | Violação de privacidade | Dados sintéticos |
| Reproduzir informações de incidentes públicos sem conferir as fontes | Erros e desinformação | Fontes primárias e data de consulta |

## 8. Projeto final sugerido (capstone)

| Etapa | Entregável |
|---|---|
| 1 | Escolha de um caso (fictício deste repositório ou um cenário próprio) e plano de análise |
| 2 | Linha do tempo integrada, matriz de hipóteses e inventário de evidências |
| 3 | Consultas e análises reproduzíveis, em repositório versionado |
| 4 | Livro de decisões e matriz de obrigações |
| 5 | Relatório forense completo (modelo da pasta 22) e resumo executivo de uma página |
| 6 | Apresentação de 15 minutos à "direção", com perguntas |
| 7 | Revisão por pares com a rubrica da seção 4 |
| 8 | Lições aprendidas e proposta de melhoria dos playbooks (pasta 23) |

## 9. Casos de uso corporativos

- Programa de capacitação com avaliação objetiva por rubrica.
- Banco de cenários de exercícios de mesa e de laboratório para o SOC, o DFIR, o jurídico e a conformidade.
- Processo de revisão de lições aprendidas com padronização de relatórios.

## 10. Normas e frameworks relevantes

- NIST SP 800-84; NIST SP 800-61 Rev. 3; ISO/IEC 27035; ISO/IEC 27043
- CISA. Tabletop Exercise Packages; FIRST. CSIRT Services Framework
- ISO 21043 (interpretação e relato); LGPD, arts. 6º e 46

## 11. Referências

- Grance, T. et al. NIST SP 800-84. 2006.
- CISA. Tabletop Exercise Packages.
- Documentação do DuckDB.
- Pastas 22, 23 e 30 deste repositório; arquivos 1 a 7 desta pasta.
