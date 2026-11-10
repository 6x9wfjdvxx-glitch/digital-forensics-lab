# Casos de Uso e Erros Comuns em Forense de Prompts

> **Objetivo pedagógico:** consolidar o aprendizado de forense de prompts com cenários corporativos realistas, os erros mais frequentes, suas consequências e as medidas de prevenção.

Os casos são fictícios e destinados ao treinamento.

## 1. Caso 1: contrato colado em assistente público

| Fonte | Achado |
|---|---|
| Proxy e DLP | Envio de documento com cláusulas confidenciais a um serviço de IA público, às 15:10 UTC, por um analista jurídico |
| Conta | Conta pessoal; sem acesso corporativo ao histórico |
| Providências | Portão legal com Jurídico, RH e DPO; solicitação de colaboração ao colaborador, que exportou o histórico de forma voluntária |
| Conversa | O contrato foi colado integralmente com o pedido de resumo; a resposta não continha dados adicionais |
| Fornecedor | Pedido de exclusão e de declaração sobre retenção e uso para treinamento, com protocolo |
| Resultado | Violação de política e de confidencialidade contratual, com notificação ao cliente conforme o contrato; ferramenta corporativa aprovada e orientação |

**Lição:** sem registros do serviço, a colaboração voluntária e os registros corporativos permitiram reconstruir o fato, com proporcionalidade.

## 2. Caso 2: injeção indireta em assistente de e-mail

| Fonte | Achado |
|---|---|
| Alerta | Envio automático de uma lista de contatos a um endereço externo, sem pedido do usuário |
| Fonte do conteúdo | E-mail externo com parágrafo de texto invisível dirigido ao assistente |
| Linha do tempo | E-mail recebido 08:02; resumo diário às 08:15; chamada da ferramenta de envio às 08:15:04 |
| Alcance | 14 usuários receberam a mensagem; 3 assistentes executaram a ação |
| Resposta | Remoção das mensagens após preservação, bloqueio do remetente, remoção da permissão de envio automático e aprovação humana |

**Lição:** preserve o e-mail de origem e o rastro das ferramentas; o controle decisivo foi o privilégio mínimo e a aprovação humana.

## 3. Caso 3: chatbot de atendimento orientou cliente de forma incorreta

| Fonte | Achado |
|---|---|
| Reclamação | Cliente alega ter recebido do chatbot a informação de que poderia cancelar sem multa |
| Preservação | Retenção legal do banco de conversas e do repositório de prompts |
| Reconstrução | A conversa original contém a frase; o prompt do sistema vigente em 12/10 (recuperado do histórico) não continha a política atualizada de cancelamento; o contexto recuperado trouxe um documento antigo |
| Reexecução | Em 20/11, o modelo atualizado respondeu de outro modo; documentado como não determinismo e atualização |
| Resultado | Falha de conteúdo da base de conhecimento e de governança de versões; a empresa honrou a informação ao cliente e corrigiu a base |

**Lição:** a versão do prompt, o contexto recuperado e a conversa original foram decisivos; a reexecução não serve de prova.

## 4. Caso 4: uso do assistente corporativo para assédio

| Fonte | Achado |
|---|---|
| Denúncia | Uma colaboradora relata mensagens ofensivas geradas com ajuda de IA e enviadas por e-mail |
| Portão legal | RH e Jurídico autorizam a apuração restrita às contas e aos registros corporativos |
| Evidências | Registros do assistente corporativo, e-mails enviados e metadados; a conta usada pertence ao acusado; sessão do dispositivo e da rede compatíveis |
| Autoria | Corroborada por logs de acesso físico e de dispositivo; sem uso de estilometria |
| Resultado | Fatos documentados e entregues ao RH, que conduziu o procedimento disciplinar, assegurando o direito de defesa |

**Lição:** a autoria foi demonstrada por corroboração técnica, e não pelo estilo do texto.

## 5. Caso 5: assistente com RAG expõe documentos de RH

| Fonte | Achado |
|---|---|
| Relato | Um colaborador recebeu, em uma resposta, trechos de uma política de remuneração restrita |
| Registros de RAG | A consulta recuperou documentos de uma pasta de RH indexada sem filtros de permissão do usuário |
| Análise | O índice foi construído com uma conta de serviço com acesso amplo; os controles de acesso do documento original não foram propagados |
| Impacto | 37 usuários receberam trechos do documento em 3 semanas, conforme os registros |
| Resposta | Remoção do índice, reconstrução com permissões por documento, notificação interna e avaliação pelo DPO |

**Lição:** registros de recuperação mostram exatamente o que foi exposto; a falha estava no controle de acesso do índice, e não no modelo.

## 6. Caso 6: preservação de registros em litígio

| Fonte | Achado |
|---|---|
| Situação | Litígio sobre recomendações dadas por um assistente a clientes |
| Providências | Retenção legal do banco de conversas e dos rastros de observabilidade; suspensão do descarte automático de 90 dias |
| Dificuldade | O conteúdo contém dados pessoais de milhares de clientes; a parte contrária pediu a exibição |
| Solução | Filtros por cliente e por período, pseudonimização dos demais dados, revisão pelo Jurídico e exportação com hashes e termo de extração |

**Lição:** a retenção legal e a minimização precisam andar juntas; planeje a produção com escopo e com proteção de dados de terceiros.

## 7. Caso 7: chave de API vazada e abuso do serviço

| Fonte | Achado |
|---|---|
| Alerta de custos | Custo 25 vezes acima do normal em um projeto de IA |
| Gateway e faturamento | Requisições de IPs externos usando uma chave publicada em um repositório público, em volume alto e em horários contínuos |
| Conteúdo | Sem registro de conteúdo (somente metadados); o uso aparentava geração de texto em massa |
| Resposta | Revogação e rotação da chave, limites de uso e de rede, varredura de repositórios por segredos e revisão de custos com o provedor |

**Lição:** os metadados do gateway e do faturamento bastaram para o escopo, mesmo sem o conteúdo; a rotação imediata é a prioridade.

## 8. Erros comuns, consequências e prevenção

| Erro | Consequência provável | Prevenção |
|---|---|---|
| Acessar conversas de contas pessoais sem consentimento ou ordem | Prova ilícita e violação de privacidade | Portões legais; colaboração do titular; registros corporativos |
| Ler o conteúdo antes de esgotar metadados e controles de rede | Invasão desproporcional | Proporcionalidade: começar pelos metadados |
| Não preservar os registros com retenção curta | Perda de provas | Preservação imediata e retenção legal |
| Usar a reexecução do prompt como prova do que foi respondido | Prova frágil e contestável | Preservar o original; tratar a reexecução como teste |
| Ignorar a versão do prompt do sistema e o contexto recuperado | Conclusões erradas sobre a causa da resposta | Repositório versionado e registros de RAG |
| Considerar só a ramificação principal da conversa | Perda do ramo realmente utilizado | Reconstruir a árvore completa e identificar o ramo usado |
| Atribuir autoria pelo estilo do texto ou por detectores de IA | Acusações injustas | Corroboração técnica independente |
| Concluir sobre intenção a partir de um prompt isolado | Conclusões infundadas | Hipóteses alternativas e contexto |
| Reproduzir dados pessoais e segredos nos relatórios | Novos incidentes de privacidade | Quantificar e mascarar; acesso restrito |
| Copiar ou distribuir conteúdo ilícito encontrado | Responsabilidade legal e danos | Interromper, não copiar e acionar o Jurídico |
| Registrar todos os prompts sem proteção ou retê-los indefinidamente | Risco de privacidade e de vazamento | Registro em camadas, criptografia, acesso restrito e retenção definida |
| Registrar somente a pergunta e a resposta, sem o contexto | Impossibilidade de reconstruir a causa | Registrar versões, contexto recuperado e ferramentas |
| Não considerar o não determinismo e as atualizações do modelo | Conclusões de "inconsistência" indevidas | Declarar a limitação e preservar o original |
| Subestimar a injeção indireta e o conteúdo externo | Incidentes repetidos | Preservar as fontes; privilégio mínimo; aprovação humana |
| Não envolver RH, Jurídico e DPO em casos que envolvem pessoas | Violações de direitos e nulidades | Governança e portões legais |

## 9. Exercícios práticos

1. Monte um laboratório com um modelo local (por exemplo, executado em uma VM) e uma aplicação simples de conversa que grave os registros no formato do modelo E; gere interações fictícias e preserve-as com hash.
2. Escreva uma rotina de reconstrução de conversa a partir de um JSON em formato de árvore (dados fictícios) e identifique o ramo utilizado.
3. Crie um conjunto de prompts fictícios com CPFs **sintéticos** e e-mails de teste, aplique a detecção com validação e quantifique, sem reproduzir os valores.
4. Escreva consultas em DuckDB para identificar usuários com volume anormal de tokens e picos fora do expediente.
5. Em ambiente de laboratório, crie um documento de teste com **texto invisível inofensivo** e verifique se as buscas por caracteres de largura zero e por comentários HTML o detectam.
6. Monte uma linha do tempo de um incidente de injeção indireta **simulado** (dados fictícios): e-mail de origem, rastro de contexto, chamada de ferramenta e impacto; preencha as matrizes C e D.
7. Elabore a política de acesso a registros de IA para uma organização fictícia, com portões legais, proporcionalidade, retenção e tratamento de conteúdo ilícito.
8. Redija o relatório do caso 3 (chatbot de atendimento), com a versão do prompt, o contexto recuperado, o não determinismo e as limitações.

Use somente dados fictícios e ambientes de laboratório. Não execute ataques contra sistemas de terceiros nem reproduza conteúdo ilícito.

## 10. Normas e frameworks relevantes

- OWASP Top 10 para LLM; MITRE ATLAS; NIST AI 600-1; NIST AI RMF 1.0
- ISO/IEC 27037, 27042; ISO/IEC 42001:2023; ISO/IEC 27701
- LGPD, arts. 6º, 7º, 11, 20, 37, 38, 46 e 48; Marco Civil da Internet; ECA, arts. 240 a 241-E

## 11. Referências

- Greshake, K. et al. Indirect Prompt Injection (2023).
- OWASP. Top 10 for LLM Applications (edição vigente); MITRE. ATLAS.
- Responsible AI Collaborative. AI Incident Database.
- Pastas 12, 19, 22, 23 e 24 deste repositório.
