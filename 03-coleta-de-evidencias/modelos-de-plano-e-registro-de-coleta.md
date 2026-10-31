# Modelos de Plano e Registro de Coleta

> **Objetivo pedagógico:** fornecer os modelos dos documentos da fase de coleta (plano, triagem, diário de coleta ao vivo e relatório), demonstrar seu preenchimento e garantir a rastreabilidade das decisões. Os formulários de custódia A a F estão na pasta 02.

## 1. Modelo A: Plano de Coleta

| Campo | Preenchimento |
|---|---|
| Caso | DFL-AAAA-NNN |
| Versão e data (UTC) | |
| Líder e responsável pela coleta | |
| Autorização (referência) | |
| Perguntas investigativas | |
| Período de interesse | |
| Escopo (hosts, contas, serviços, localidades) | |
| Exclusões e restrições | |
| Considerações legais e de privacidade | |
| Janela de execução | |
| Riscos e contingências | |

### Fontes e priorização

| ID | Fonte | Valor (1 a 5) | Volatilidade (1 a 5) | Esforço (1 a 5) | Prioridade | Método de coleta | Responsável | Prazo |
|---|---|---|---|---|---|---|---|---|
| F1 | | | | | | | | |
| F2 | | | | | | | | |

Prioridade = (Valor × 2) + (Volatilidade × 2) − Esforço.

### Recursos necessários

| Recurso | Quantidade e especificação |
|---|---|
| Ferramentas e versões | |
| Bloqueadores de escrita | |
| Mídias de destino | |
| Material de custódia (lacres, embalagens, bolsas Faraday) | |
| Pessoas e papéis | |

## 2. Modelo B: Registro de Triagem

| Campo | Preenchimento |
|---|---|
| Caso | |
| Host ou sistema | |
| Data e hora de início e fim (UTC) | |
| Analista | |
| Ferramenta, versão e parâmetros | |
| Alvos coletados | |
| Volume coletado | |
| Hash do pacote coletado | |
| Local de armazenamento | |
| Indicadores encontrados | |
| Classificação (sem indício, suspeito, comprometido) | |
| Decisão (encerrar, aquisição completa, monitorar) | |
| Limitações | |

## 3. Modelo C: Diário de Coleta ao Vivo

| Hora (UTC) | Ação executada | Comando ou ferramenta e versão | Saída (arquivo) | Hash | Observações e impacto |
|---|---|---|---|---|---|
| | | | | | |
| | | | | | |

Preencher em tempo real; não completar de memória.

## 4. Modelo D: Relatório de Coleta

| Seção | Conteúdo |
|---|---|
| 1. Identificação | Caso, evidências, responsáveis e datas |
| 2. Autorização e escopo | Referências e limites |
| 3. Método | Fontes, ferramentas, versões e justificativas das decisões |
| 4. Resultados | Itens coletados, volumes, hashes e locais de armazenamento |
| 5. Intercorrências | Falhas, erros de leitura, divergências, desvios do plano |
| 6. Impacto da coleta | Alterações conhecidas no sistema ao vivo |
| 7. Limitações | O que não foi coletado e por quê |
| 8. Custódia | Referência aos formulários e ao manifesto |
| 9. Próximos passos | Aquisições adicionais, análises e comunicações |

## 5. Exemplo preenchido: Plano de Coleta (fictício)

| Campo | Preenchimento |
|---|---|
| Caso | DFL-2026-002 |
| Líder | Analista Sênior |
| Autorização | Termo TA-2026-018 (Jurídico, DPO e CISO) |
| Perguntas | Houve execução de código malicioso na estação do usuário X? Há comunicação com infraestrutura externa suspeita? |
| Período | 2026-10-20 a 2026-10-30 (UTC) |
| Escopo | Notebook patrimônio 654321, conta do usuário X, logs de proxy e de EDR |
| Exclusões | Dispositivos pessoais e conteúdo de e-mails |

| ID | Fonte | V | Vol | Esf | Prioridade | Método |
|---|---|---|---|---|---|---|
| F1 | Memória do notebook | 5 | 5 | 2 | 18 | Captura ao vivo |
| F2 | Logs de proxy e DNS | 5 | 4 | 1 | 17 | Exportação do SIEM |
| F3 | Telemetria do EDR | 4 | 4 | 1 | 15 | Exportação da plataforma |
| F4 | Imagem do disco | 4 | 2 | 3 | 9 | Aquisição com bloqueador de escrita |

## 6. Exemplo preenchido: Registro de Triagem (fictício)

| Campo | Preenchimento |
|---|---|
| Host | WKS-0457 |
| Janela | 2026-10-30T16:02Z a 16:14Z |
| Ferramenta | Coletor de triagem, versão registrada |
| Alvos | Prefetch, Amcache, tarefas, Run keys, histórico de navegador, logs Security e PowerShell |
| Volume | 1,3 GB |
| Hash do pacote | Registrado em manifesto SHA-256 |
| Indicadores | Execução de binário em pasta temporária; conexão a domínio recém-registrado |
| Classificação | Suspeito |
| Decisão | Aquisição completa do disco e captura de memória |

## 7. Casos de uso corporativos

- Padronização do plano de coleta em todas as investigações do laboratório.
- Apresentação do relatório de coleta a Jurídico e Auditoria como evidência de método.
- Revisão por pares dos planos de coleta antes da execução em incidentes de alto impacto.

## 8. Normas e frameworks relevantes

- ISO/IEC 27037:2012 e ISO/IEC 27043:2015 (documentação do processo)
- NIST SP 800-86, seção 3
- ISO/IEC 27002:2022, controle 5.28
- ISO/IEC 17025:2017 (registros técnicos, como referência de qualidade)

## 9. Referências

- ABNT NBR ISO/IEC 27037:2013; ISO/IEC 27043:2015.
- Kent, K. et al. NIST SP 800-86. 2006.
- SWGDE. Best Practices for Computer Forensic Acquisitions.
- Casey, E. Digital Evidence and Computer Crime. 3. ed. Academic Press, 2011.
