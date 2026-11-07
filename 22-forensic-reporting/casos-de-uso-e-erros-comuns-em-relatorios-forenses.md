# Casos de Uso e Erros Comuns em Relatórios Forenses

> **Objetivo pedagógico:** consolidar o aprendizado de relatórios forenses com cenários realistas, os erros mais frequentes, suas consequências e as medidas de prevenção.

Os casos são fictícios e destinados ao treinamento.

## 1. Caso 1: laudo contestado por lacunas na cadeia de custódia

| Fato | Detalhe |
|---|---|
| Situação | O laudo concluiu que arquivos confidenciais foram copiados para mídia removível |
| Contestação | A parte contrária apontou que o laudo não registrava o hash da imagem forense nem a data de recebimento do notebook |
| Análise | Os registros existiam no laboratório, mas não constavam do laudo |
| Consequência | Pedido de nova perícia e atraso de 4 meses |
| Correção | Inclusão da tabela de evidências e hashes (Anexo B) e dos formulários de custódia (Anexo A) em todos os laudos |

**Lição:** o que não está no relatório é difícil de provar; documente a custódia e os hashes no próprio documento.

## 2. Caso 2: conclusão além do escopo do encargo

| Fato | Detalhe |
|---|---|
| Situação | O perito concluiu que o réu "agiu de má-fé e cometeu desvio de dados" |
| Contestação | Impugnação do laudo por extrapolar o exame técnico (CPC, art. 473, § 2º) |
| Resultado | O juiz desconsiderou a parte opinativa e determinou esclarecimentos |
| Correção | Reescrever a conclusão: "A conta do réu foi usada para copiar os arquivos X e Y para o dispositivo Z em [data e hora]. Não cabe ao perito qualificar a intenção." |

**Lição:** o perito descreve fatos técnicos e conclui dentro de sua competência; a qualificação jurídica cabe ao juízo.

## 3. Caso 3: linha do tempo com erro de fuso horário

| Fato | Detalhe |
|---|---|
| Situação | O relatório apresentou horários locais misturados com UTC, invertendo a ordem entre o logon do usuário e a execução de um comando |
| Descoberta | O assistente técnico adverso detectou a inversão ao reprocessar os registros |
| Consequência | Perda de credibilidade do relatório e questionamento de outras conclusões |
| Correção | Padronizar tudo em UTC, indicar o fuso local e validar a linha do tempo por revisão de pares |

**Lição:** erros de tempo comprometem toda a narrativa; normalize e revise.

## 4. Caso 4: excesso de certeza ("prova")

| Fato | Detalhe |
|---|---|
| Situação | O relatório afirmou que um único registro "prova" que o usuário abriu um documento |
| Problema | A fonte única (data de acesso) era alterável e havia uma explicação alternativa (indexação de busca) |
| Consequência | Impugnação e perda de peso do laudo |
| Correção | "O registro é consistente com a abertura do documento (fonte única, confiança baixa); outra explicação plausível é a indexação por busca" |

**Lição:** use linguagem calibrada e considere explicações alternativas.

## 5. Caso 5: falha de redação segura expõe dados pessoais

| Fato | Detalhe |
|---|---|
| Situação | Em um relatório distribuído à diretoria, nomes e CPFs foram cobertos por tarjas pretas desenhadas sobre o texto |
| Descoberta | O texto permanecia extraível do PDF e foi copiado e repassado |
| Consequência | Incidente de privacidade e comunicação à ANPD |
| Correção | Pseudonimização na origem, redação verdadeira e teste de extração de texto e de metadados antes da distribuição |

**Lição:** tarja visual não é redação; verifique o resultado final.

## 6. Caso 6: relatório de situação com especulação durante um incidente

| Fato | Detalhe |
|---|---|
| Situação | Um SITREP afirmou que um grupo específico era o autor do ataque e que "nenhum dado foi acessado" |
| Descoberta | Dois dias depois, a investigação mostrou exfiltração de dados e a atribuição não se sustentou |
| Consequência | Retratação, perda de confiança da direção e questionamentos de clientes |
| Correção | Modelo de SITREP com seções "o que sabemos" e "o que não sabemos"; revisão jurídica das declarações externas |

**Lição:** declare incertezas, evite atribuições precoces e afirmações categóricas.

## 7. Caso 7: relatório negativo bem redigido

| Fato | Detalhe |
|---|---|
| Situação | A investigação não encontrou evidências de acesso do colaborador aos arquivos em questão |
| Redação | "Nos logs do servidor (retenção de 30 dias, sem lacunas identificadas), não há registros de acesso à pasta X pela conta Y no período de 01 a 15/10. A ausência de registros não permite concluir que o acesso não ocorreu: logs de endpoint e de rede não foram fornecidos." |
| Resultado | O relatório foi aceito como fiel e útil; a empresa decidiu ampliar a coleta antes de decidir sobre medidas disciplinares |

**Lição:** relatar resultados negativos com cobertura e limitações é tão importante quanto relatar achados positivos.

## 8. Erros comuns, consequências e prevenção

| Erro | Consequência provável | Prevenção |
|---|---|---|
| Não responder a todos os quesitos | Nulidade parcial e pedido de esclarecimentos | Quadro de respostas aos quesitos e verificação final |
| Misturar fatos, inferências e opiniões | Contestação e perda de credibilidade | Separar seções e usar escalas de confiança |
| Conclusões fora do escopo ou jurídicas | Impugnação (CPC, art. 473, § 2º) | Delimitar o encargo; restringir-se ao exame técnico |
| Falta de hashes e de cadeia de custódia no documento | Prova frágil | Anexos A e B obrigatórios |
| Horários sem normalização | Narrativas incorretas | UTC, fuso declarado e revisão por pares |
| Ferramentas sem versão e sem validação | Questionamento da prova | Registrar versões e validar; segunda ferramenta |
| Usar "prova" e linguagem categórica sem base | Perda de credibilidade | Linguagem calibrada |
| Ignorar hipóteses alternativas e evidências contrárias | Viés e impugnação | Matriz de hipóteses e seção de alternativas |
| Omitir limitações | Conclusões inflacionadas | Seção de limitações e ressalvas |
| Falta de revisão por pares | Erros não detectados | Fluxo obrigatório de revisão |
| Dados pessoais em excesso e redação falha | Violação de privacidade | Minimização, pseudonimização e teste de redação |
| Jargão sem explicação | Incompreensão e desconfiança | Glossário e linguagem simples |
| Mudar conclusões técnicas por pressão do cliente ou do Jurídico | Parcialidade e risco de responsabilidade | Independência; alterações de conteúdo apenas pelo perito, com justificativa registrada |
| Capturas de tela como prova única | Prova contestável | Fonte original, hash e método |
| Entregar sem hash, assinatura e termo de entrega | Dúvida sobre a integridade do documento | Pacote de entrega verificável |
| Declarações categóricas em SITREPs e comunicações externas | Retratações e danos de reputação | Fatos verificados, incertezas explícitas e revisão jurídica |

## 9. Exercícios práticos

1. Com um caso de treinamento (por exemplo, os conjuntos de dados do NIST CFReDS "Data Leakage Case" ou "Hacking Case"), elabore o laudo completo, com todas as seções, quesitos fictícios, tabela de evidências e hashes, linha do tempo e declaração.
2. Redija as respostas a cinco quesitos técnicos, indicando para cada uma o grau de confiança e as limitações.
3. Reescreva dez frases com linguagem categórica ("prova", "obviamente") em linguagem calibrada, com referência a achados.
4. Faça a revisão crítica de um laudo de exemplo, listando as questões de cadeia de custódia, método, ferramentas, tempo e interpretação, e escreva o parecer de assistente técnico.
5. Simule uma inquirição: um colega faz os ataques da seção 8.1 do arquivo anterior e você responde com calma, objetividade e reconhecimento de limites.
6. Elabore um SITREP, um resumo executivo e uma comunicação a titulares para o mesmo incidente fictício, consistentes entre si.
7. Teste a redação segura: gere um PDF com dados fictícios, aplique a redação e verifique, com extração de texto e de metadados, se há vazamento.
8. Gere o relatório com Pandoc, calcule os hashes, aplique um carimbo de tempo de teste e monte o pacote de entrega com o termo.

Use sempre dados fictícios ou públicos de treinamento nos exercícios.

## 10. Normas e frameworks relevantes

- ISO/IEC 27037, 27041, 27042, 27043; ISO/IEC 17025
- CPC, arts. 158, 465 a 480; CPP, arts. 158-A a 158-F e 159; Código Penal, art. 342
- LGPD, arts. 6º, 46, 48
- ENFSI Guideline for Evaluative Reporting; NIST IR 8354

## 11. Referências

- NIST CFReDS. Computer Forensic Reference Data Sets (Data Leakage Case e Hacking Case).
- Casey, E. Digital Evidence and Computer Crime. 3. ed. 2011.
- Casey, E. Error, uncertainty, and loss in digital evidence. International Journal of Digital Evidence, 2002.
- ENFSI. Guideline for Evaluative Reporting in Forensic Science. 2015.
- Brasil. Lei nº 13.105/2015 (CPC); Decreto-Lei nº 3.689/1941 (CPP).
