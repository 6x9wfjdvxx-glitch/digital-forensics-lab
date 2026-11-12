# Exercícios Integrados, Operação e Checklist do Laboratório

> **Objetivo pedagógico:** consolidar o aprendizado do laboratório com exercícios integrados que combinam disco, memória, logs, rede, nuvem e IA; definir rotinas de operação do laboratório (custódia, armazenamento, sanitização de mídias e incidentes do próprio laboratório); oferecer um checklist de maturidade; e propor um roteiro de estudo progressivo e um projeto final.

## 1. Exercício integrado 1: "Caso Lab-01" (disco, linha do tempo e relatório)

| Etapa | Atividade | Arquivo de apoio |
|---|---|---|
| 1 | Crie uma imagem de disco fictícia com 3 pastas, 10 arquivos, 3 exclusões e 1 arquivo renomeado | Prática 1 |
| 2 | Adquira em E01, verifique e documente a custódia | Prática 1 |
| 3 | Recupere os arquivos excluídos e construa a linha do tempo (`mactime` e Plaso) | Prática 1 |
| 4 | Escreva as hipóteses: "arquivos excluídos para ocultar" versus "limpeza rotineira", com evidências a favor e contra | Pastas 05 e 22 |
| 5 | Redija o relatório (resumo, método, resultados, limitações) com o modelo da pasta 22 | Pasta 22 |
| 6 | Peça a um colega que reproduza as etapas 2 e 3 a partir dos seus registros | Arquivo 7 |

## 2. Exercício integrado 2: "Caso Lab-02" (Windows, logs e memória)

| Etapa | Atividade |
|---|---|
| 1 | Na VM de teste, gere eventos benignos (tarefa agendada e conta de teste) e exporte os logs |
| 2 | Analise com EvtxECmd, Hayabusa e Chainsaw e compare as detecções |
| 3 | Capture a memória da VM e execute a triagem (processos, linhas de comando e conexões) |
| 4 | Construa a linha do tempo integrada (logs, artefatos e memória) em UTC |
| 5 | Classifique cada detecção (verdadeiro positivo, falso positivo ou indeterminado) e justifique |
| 6 | Escreva um resumo executivo de uma página e um anexo técnico |

## 3. Exercício integrado 3: "Caso Lab-03" (rede e arquivos)

| Etapa | Atividade |
|---|---|
| 1 | Gere o tráfego periódico benigno (prática 3) e uma captura com tráfego misto |
| 2 | Identifique a periodicidade com Zeek e DuckDB e verifique os alertas do Suricata |
| 3 | Escreva uma regra YARA e uma regra Suricata locais e meça os falsos positivos |
| 4 | Aplique a rotina de triagem estática a 3 arquivos benignos de tipos diferentes |
| 5 | Documente o procedimento de isolamento e o teste de ausência de rota externa |

## 4. Exercício integrado 4: "Caso Lab-04" (nuvem, M365 e IA)

| Etapa | Atividade |
|---|---|
| 1 | Gere eventos benignos de nuvem e reconstrua a atividade pelos logs |
| 2 | No locatário de testes, gere e localize eventos de caixa e de arquivos |
| 3 | No laboratório de IA, registre 20 interações e analise o conjunto (volume e hashes) |
| 4 | Simule a substituição de um artefato de modelo e demonstre a detecção (hash e diferença de tensores) |
| 5 | Escreva a matriz de hipóteses e a recomendação de registros e de controles |

## 5. Exercício final: "Caso integrado" (capstone)

Escolha um dos casos da pasta 28 (por exemplo, o caso 1, de ransomware, ou o caso 2, de BEC) e **reproduza as análises possíveis no laboratório** com dados sintéticos:

| Etapa | Entregável |
|---|---|
| 1 | Geração de dados sintéticos coerentes com a cronologia do caso (logs, tráfego e imagens de teste) |
| 2 | Análises reproduzíveis (consultas, scripts e comandos) em repositório versionado |
| 3 | Linha do tempo integrada, matriz de hipóteses e inventário de evidências com hashes |
| 4 | Registro de validação das ferramentas usadas |
| 5 | Relatório forense completo e resumo executivo |
| 6 | Revisão por pares usando a rubrica da pasta 28 |
| 7 | Lista de melhorias nos playbooks e nos controles |

## 6. Operação do laboratório: rotinas

| Rotina | Frequência | Descrição |
|---|---|---|
| Verificação do ambiente | Diária ou por sessão | Estado das VMs, snapshots, isolamento da rede e sincronização de tempo |
| Atualização controlada | Mensal | Atualizar o host e as ferramentas em ambiente de teste; revalidar o que for necessário |
| Cópias de segurança e teste de restauração | Semanal e trimestral | Evidências, documentação e repositórios |
| Revisão de acessos | Trimestral | Contas, privilégios e registros de acesso físico |
| Inventário de evidências e de mídias | Mensal | Conferir a existência e o estado dos itens, e os lacres |
| Revisão de licenças e de ferramentas | Semestral | Licenças vencidas, ferramentas sem manutenção |
| Exercícios e treinamento | Trimestral | Exercícios de mesa e laboratórios |
| Revisão de procedimentos | Anual | POPs e playbooks |

## 7. Armazenamento, custódia e sanitização de mídias

| Tema | Orientação |
|---|---|
| Armazenamento | Evidências originais em volume criptografado, com acesso restrito, somente leitura, e cópia de segurança em local separado |
| Mídias físicas | Armário ou cofre com acesso registrado, etiquetas, lacres e formulários de custódia (pasta 02) |
| Retenção | Conforme a política do caso, da lei e do cliente; registrar prazos e decisões |
| Devolução | Termo de devolução com verificação do estado e do lacre |
| Sanitização | Antes do reuso ou do descarte, sanitizar as mídias conforme as diretrizes do NIST SP 800-88 (revisão vigente): limpeza, expurgo ou destruição, conforme o tipo e a sensibilidade; SSDs exigem métodos apropriados (por exemplo, apagamento criptográfico ou comandos seguros do dispositivo) |
| Registro | Termo de sanitização com método, ferramenta, data, responsável e verificação |
| Descarte | Destruição com certificado, quando exigido |

```bash
# Exemplo de sobrescrita de um dispositivo de TESTE do laboratório (DESTRUTIVO: confirme o dispositivo antes; nunca execute em discos de casos)
lsblk -o NAME,SIZE,MODEL,SERIAL
# sudo shred -v -n 1 -z /dev/sdX     # somente para mídia de laboratório e conforme a política de sanitização aplicável ao tipo de mídia
```

## 8. Incidentes do próprio laboratório

| Situação | Conduta |
|---|---|
| Suspeita de contaminação (amostra executada fora do ambiente isolado) | Desconectar, preservar o estado, acionar o responsável técnico, tratar como incidente (PB-00) e restaurar a partir de snapshots limpos |
| Perda ou violação de lacre de evidência | Registrar, comunicar o líder e o Jurídico, avaliar o impacto na cadeia de custódia (pasta 02) |
| Acesso não autorizado ao laboratório | Revogar acessos, revisar registros, investigar |
| Falha de armazenamento | Restaurar a partir da cópia de segurança e verificar hashes |
| Ferramenta com comportamento inesperado | Suspender o uso, registrar, revalidar (arquivo 7) |
| Conteúdo ilícito encontrado em uma evidência | Interromper e escalar ao Jurídico (pasta 25 e arquivo 6 da pasta 27) |

## 9. Checklist de maturidade do laboratório

**Laboratório:** ____________________
**Responsável:** ____________________
**Data:** ____________________

### 9.1 Infraestrutura e segurança

- [ ] Estação de análise com disco criptografado e atualizações controladas
- [ ] Rede isolada para amostras, sem rota para a internet e para a produção, com teste de isolamento
- [ ] VMs com snapshots limpos e sem pastas compartilhadas com o host
- [ ] Armazenamento de evidências criptografado, com acesso restrito e cópias de segurança testadas
- [ ] Controle de acesso físico e registro (níveis intermediário e avançado)
- [ ] Tempo sincronizado e fuso registrado (UTC)

### 9.2 Ferramentas e métodos

- [ ] Inventário de ferramentas com versão, origem, hash e licença
- [ ] Instaladores verificados (hash e assinatura) e guardados
- [ ] Validação documentada das ferramentas críticas e revalidação após mudanças
- [ ] Verificação cruzada entre ferramentas independentes para achados relevantes
- [ ] Repositório Git de scripts, consultas e runbooks

### 9.3 Processos e documentação

- [ ] Procedimentos de aquisição, custódia, análise, descarte e incidentes do laboratório
- [ ] Registro de comandos e de ambiente em cada caso
- [ ] Formulários de custódia e manifestos de hashes padronizados
- [ ] Modelos de relatório e revisão por pares
- [ ] Sanitização de mídias documentada
- [ ] Programa de treinamento e exercícios periódicos

### 9.4 Legal e privacidade

- [ ] Dados de treino sintéticos ou públicos, com licenças registradas
- [ ] Evidências reais apenas no ambiente de produção do laboratório
- [ ] Portões legais e de privacidade nos procedimentos de casos
- [ ] Controle do uso de licenças de software

## 10. Resultado da verificação

| Resultado | Condição |
|---|---|
| Conforme | Todos os itens aplicáveis marcados |
| Conforme com ressalvas | Pendências sem impacto na integridade das evidências e na segurança, com plano de ação |
| Não conforme | Ausência de isolamento da rede de amostras, de validação de ferramentas críticas, de cópias de segurança testadas ou de controle de acesso às evidências; corrigir antes de operar casos reais |

**Assinatura do responsável:** ____________________
**Assinatura do revisor:** ____________________

## 11. Roteiro de estudo sugerido (12 semanas)

| Semanas | Foco | Práticas e pastas |
|---|---|---|
| 1 e 2 | Montagem do laboratório, inventário e validação básica | Arquivos 1, 2 e 7; pastas 02 a 04 |
| 3 e 4 | Disco, recuperação e linha do tempo | Prática 1; pastas 05 e 10 |
| 5 e 6 | Windows, logs e memória | Prática 2; pastas 07, 09 e 11 |
| 7 e 8 | Rede e arquivos suspeitos | Prática 3; pastas 13 e 15 |
| 9 e 10 | Nuvem, Microsoft 365 e IA | Prática 4; pastas 17 a 19 e 24 a 26 |
| 11 | Relatórios e playbooks | Pastas 22 e 23 |
| 12 | Projeto final e revisão por pares | Exercício final; pasta 28 |

## 12. Referências de formação (opcional)

Programas de certificação reconhecidos em forense digital e resposta a incidentes (por exemplo, certificações de análise forense de endpoints e de memória, de análise de malware, de forense de nuvem e de resposta a incidentes oferecidas por organizações de formação) podem complementar o estudo prático. Verifique o conteúdo, os pré-requisitos e a validade atual de cada programa antes de escolher.

## 13. Casos de uso corporativos

- Programa interno de capacitação com avaliação prática por projetos.
- Avaliação de maturidade do laboratório e plano de melhoria.
- Preparação do laboratório para casos reais e para auditorias de qualidade.

## 14. Normas e frameworks relevantes

- ABNT NBR ISO/IEC 17025; ISO/IEC 27037, 27041, 27042 e 27043; ISO 21043
- NIST SP 800-86; NIST SP 800-88 (sanitização de mídias); NIST SP 800-84 (exercícios)
- ISO/IEC 27001:2022 e 27002:2022 (controles físicos e de acesso); CIS Controls v8.1
- LGPD, arts. 6º, 46 e 50; CPP, arts. 158-A a 158-F

## 15. Referências

- NIST. SP 800-88: Guidelines for Media Sanitization (revisão vigente).
- NIST. SP 800-84: Guide to Test, Training, and Exercise Programs.
- SWGDE. Requirements for Digital Forensic Laboratory Quality Assurance.
- Pastas 02, 22, 23 e 28 deste repositório; arquivos 1 a 7 desta pasta.
