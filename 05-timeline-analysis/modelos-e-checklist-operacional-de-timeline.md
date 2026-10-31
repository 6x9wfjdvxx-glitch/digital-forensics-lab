# Modelos e Checklist Operacional de Timeline

> **Objetivo pedagógico:** fornecer modelos de documentos (plano, registro de eventos, narrativa e relatório) e uma lista de verificação executável para todo o ciclo da análise de linha do tempo, garantindo reprodutibilidade, rastreabilidade e revisão por pares.

## 1. Modelo A: Plano de Análise de Timeline

| Campo | Preenchimento |
|---|---|
| Caso | DFL-AAAA-NNN |
| Analista e revisor | |
| Perguntas investigativas | |
| Janela de interesse (UTC) | De ___ a ___ |
| Fontes previstas | |
| Fuso e relógio de cada fonte | |
| Ferramentas e versões | |
| Critérios de filtragem de ruído | |
| Eventos-âncora esperados | |
| Riscos e limitações | |

## 2. Modelo B: Registro de Fontes e Normalização

| ID | Fonte | Origem e hash | Formato de data | Fuso | Resolução | Desvio estimado | Correção aplicada | Observações |
|---|---|---|---|---|---|---|---|---|
| S1 | | | | | | | | |
| S2 | | | | | | | | |

## 3. Modelo C: Registro de Eventos-Chave

| ID | Hora (UTC) | Margem de erro | Fonte primária | Fonte corroborante | Descrição | Hash ou caminho do artefato | Confiança | Técnica ATT&CK |
|---|---|---|---|---|---|---|---|---|
| EV-001 | | | | | | | | |
| EV-002 | | | | | | | | |

## 4. Modelo D: Registro de Hipóteses

| ID | Hipótese | Evidências a favor | Evidências contra | Alternativas | Status (aberta, corroborada, refutada) | Confiança |
|---|---|---|---|---|---|---|
| H1 | | | | | | |

## 5. Modelo E: Narrativa da Linha do Tempo

| Fase | Intervalo (UTC) | Descrição | Eventos de apoio |
|---|---|---|---|
| Acesso inicial | | | EV-xxx |
| Execução | | | |
| Persistência | | | |
| Movimento lateral | | | |
| Coleta e exfiltração | | | |
| Impacto | | | |
| Contenção | | | |

## 6. Modelo F: Estrutura do Relatório de Timeline

| Seção | Conteúdo |
|---|---|
| 1. Resumo executivo | Principais conclusões e confiança |
| 2. Escopo e método | Perguntas, fontes, ferramentas, versões e filtros |
| 3. Normalização | Fusos, desvios e correções |
| 4. Linha do tempo | Tabela de eventos-chave e narrativa por fases |
| 5. Hipóteses | Corroboradas, refutadas e abertas |
| 6. Manipulação e anti-forense | Indícios e limitações |
| 7. Mapeamento ATT&CK | Técnicas e evidências |
| 8. Limitações | Fontes ausentes e incertezas |
| 9. Anexos | Consultas, scripts, hashes e cadeia de custódia |

## 7. Exemplo preenchido: Registro de Eventos-Chave (fictício)

| ID | Hora (UTC) | Margem | Fonte | Corroboração | Descrição | Confiança | ATT&CK |
|---|---|---|---|---|---|---|---|
| EV-001 | 2026-10-28T13:20:07Z | ±1 s | Proxy | EDR e navegador | Download de `fatura.zip` | Alta | T1566 |
| EV-002 | 2026-10-28T13:22:10Z | ±1 s | Prefetch | EDR | Execução de `invoice.exe` | Alta | T1204 |
| EV-003 | 2026-10-28T13:22:12Z | ±1 s | EDR | Registro de tarefas | Criação de tarefa agendada | Alta | T1053.005 |
| EV-004 | 2026-10-28T13:22:42Z | ±2 s | Proxy | DNS | Conexão ao domínio recém-registrado | Média | T1071 |
| EV-005 | 2026-10-28T13:40:30Z | ±1 s | Entra ID | VPN | Logon de IP externo | Alta | T1078 |

## 8. Checklist operacional

**Caso:** DFL-AAAA-NNN
**Analista:** ____________________
**Data e hora de início (UTC):** ____________________

### 8.1 Preparação

- [ ] Perguntas investigativas e janela de interesse definidas
- [ ] Imagens e coletas verificadas por hash
- [ ] Trabalho exclusivamente em cópias
- [ ] Ferramentas validadas e versões registradas
- [ ] Inventário de fontes e fusos preenchido

### 8.2 Extração

- [ ] Parsers e alvos adequados às perguntas
- [ ] Comandos e parâmetros registrados
- [ ] Erros e lacunas de parsing anotados
- [ ] Saídas com hash e armazenamento protegido

### 8.3 Normalização

- [ ] Todos os horários convertidos para UTC
- [ ] Fuso e formato de cada fonte documentados
- [ ] Desvio de relógio estimado por eventos-âncora
- [ ] Correções aplicadas em coluna separada
- [ ] Margem de erro declarada

### 8.4 Análise

- [ ] Filtros de ruído justificados e registrados
- [ ] Eventos-âncora identificados
- [ ] Hipóteses e alternativas registradas
- [ ] Conclusões críticas corroboradas por duas fontes independentes
- [ ] Verificação de manipulação de carimbos e de limpeza de logs
- [ ] Mapeamento para MITRE ATT&CK, quando aplicável

### 8.5 Relato

- [ ] Narrativa por fases elaborada
- [ ] Eventos-chave com fonte, hash e confiança
- [ ] Limitações e incertezas declaradas
- [ ] Revisão por pares realizada
- [ ] Scripts, consultas e hashes anexados

### 8.6 Encerramento

- [ ] Arquivos de timeline armazenados com controle de acesso
- [ ] Cadeia de custódia atualizada
- [ ] Lições aprendidas e lacunas de log registradas

## 9. Resultado da verificação

| Resultado | Condição |
|---|---|
| Conforme | Todos os itens aplicáveis marcados |
| Conforme com ressalvas | Pendências sem impacto nas conclusões, com plano de ação |
| Não conforme | Horários sem normalização, conclusões sem corroboração ou ausência de registro de método |

**Assinatura do analista:** ____________________
**Assinatura do revisor:** ____________________

## 10. Normas e frameworks relevantes

- ISO/IEC 27042:2015; ISO/IEC 27041:2015
- NIST SP 800-86
- MITRE ATT&CK
- ISO/IEC 27002:2022, controles 8.15 e 8.17

## 11. Referências

- ISO/IEC 27042:2015.
- Kent, K. et al. NIST SP 800-86. 2006.
- Casey, E. Digital Evidence and Computer Crime. 3. ed. Academic Press, 2011.
- Heuer, R. Psychology of Intelligence Analysis. CIA, 1999.
