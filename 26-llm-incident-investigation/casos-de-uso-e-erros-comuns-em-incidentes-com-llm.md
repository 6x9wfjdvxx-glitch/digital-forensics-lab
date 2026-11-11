# Casos de Uso e Erros Comuns em Incidentes com LLM

> **Objetivo pedagógico:** consolidar o aprendizado de investigação de incidentes com LLM e agentes com cenários corporativos realistas, os erros mais frequentes, suas consequências e as medidas de prevenção.

Os casos são fictícios e destinados ao treinamento.

## 1. Caso 1: agente de suporte exfiltra dados após ler e-mail externo

| Fonte | Achado |
|---|---|
| Trace | Execução do resumo diário; contexto com e-mail externo; chamada da ferramenta de envio com destino externo e corpo com dados de clientes |
| Auditoria do Microsoft 365 | `Send` pelo aplicativo do agente, coerente com o trace |
| Permissões | Ferramenta de envio sem restrição de destino e sem aprovação; conta com leitura ampla do CRM |
| Alcance | 3 execuções semelhantes entre 14 usuários que receberam o e-mail |
| Resposta | Ferramenta limitada a destinos internos e com aprovação humana; escopo de leitura reduzido; mensagens removidas após preservação; avaliação pelo DPO |

**Lição:** o dano foi viabilizado pelas permissões; a injeção foi o gatilho.

## 2. Caso 2: vazamento entre locatários em um assistente multicliente

| Fonte | Achado |
|---|---|
| Relato | Um cliente recebeu trechos de documentos de outro cliente |
| Registros de recuperação | Trechos devolvidos a consultas do cliente A pertenciam ao locatário B |
| Causa | Um único índice, com filtro por locatário aplicado apenas na interface, e não na consulta ao banco vetorial; um caminho alternativo de API não aplicava o filtro |
| Alcance | 212 consultas em 9 dias retornaram trechos de outros locatários |
| Resposta | API retirada do ar, filtros aplicados na camada de dados, índices separados por locatário, testes negativos de isolamento, notificações contratuais e avaliação de dados pessoais |

**Lição:** controles de acesso devem estar na camada de dados; teste caminhos alternativos e o isolamento por locatário.

## 3. Caso 3: servidor MCP com descrições alteradas após a aprovação

| Fonte | Achado |
|---|---|
| Detecção | Alerta de egresso: o ambiente do agente enviou dados a um domínio novo |
| Inventário | Um servidor de ferramentas de terceiros foi atualizado 6 dias após a aprovação; o manifesto mudou (hash diferente) |
| Análise | A nova descrição de uma ferramenta continha instruções dirigidas ao modelo, que induziam a leitura de arquivos de configuração e o envio de seu conteúdo |
| Credenciais | Chaves presentes nos arquivos lidos consideradas comprometidas |
| Resposta | Servidor desabilitado, versões e hashes fixados, rotação das chaves, revisão do processo de aprovação e verificação periódica dos manifestos |

**Lição:** aprove versões e hashes, e monitore alterações de manifestos; atualizações automáticas de ferramentas de terceiros são risco.

## 4. Caso 4: agente de código introduz segredos e dependência suspeita

| Fonte | Achado |
|---|---|
| Alerta | A varredura de segredos do pipeline encontrou uma chave de nuvem em um commit gerado com o assistente |
| Investigação | Histórico de commits e registros do assistente: a chave estava no contexto do prompt do desenvolvedor e foi repetida no código |
| Dependências | Um pacote sugerido pelo assistente não existia; um terceiro registrou o nome pouco depois, com conteúdo suspeito; o pacote foi adicionado ao projeto |
| Resposta | Revogação da chave, remoção do pacote, revisão dos ambientes de build, políticas de revisão de dependências e proibição de segredos em prompts |

**Lição:** código assistido exige as mesmas verificações de qualquer código; verifique a existência e a origem de dependências sugeridas.

## 5. Caso 6: explosão de custos por laço de agente

| Fonte | Achado |
|---|---|
| Alerta | Custo diário 18 vezes acima do normal |
| Trace | O agente repetia uma busca na web, induzido por uma página com texto que o instruía a continuar pesquisando |
| Controles ausentes | Sem limite de iterações, sem orçamento por execução e sem restrição de domínios |
| Resposta | Limites de iterações e de orçamento, lista de domínios permitidos, alertas de custo por aplicação |

**Lição:** limites de consumo são controles de segurança; injeções também podem causar negação de carteira.

## 6. Caso 7: contaminação persistente da memória do agente

| Fonte | Achado |
|---|---|
| Relato | O agente passou a incluir, em todos os resumos, um link para um site externo |
| Investigação | Uma entrada de memória de longo prazo, gravada durante a leitura de um documento externo, instruía o agente a incluir o link em respostas futuras |
| Alcance | A memória era compartilhada por uma equipe de 22 pessoas |
| Resposta | Exportação e remoção da entrada, escopo de memória por usuário, revisão das gravações por política e testes de regressão |

**Lição:** a memória persiste a injeção; limite seu escopo e revise o que o agente pode gravar.

## 7. Caso 8: agente com permissões amplas exclui registros

| Fonte | Achado |
|---|---|
| Alerta | Exclusão de 340 registros de um sistema de tickets |
| Trace | O agente interpretou um pedido ambíguo de "limpar duplicatas" e chamou a ferramenta de exclusão em lote |
| Permissões | A ferramenta permitia exclusão definitiva, sem aprovação nem limite de volume |
| Recuperação | Restauração a partir do backup do sistema de tickets; exclusão lógica e limites de volume; aprovação para ações destrutivas |
| Avaliação | Não houve ataque: falha de projeto de permissões e de ambiguidade; incidente de integridade |

**Lição:** ações destrutivas exigem aprovação, reversibilidade e limites; nem todo incidente é ataque.

## 8. Erros comuns, consequências e prevenção

| Erro | Consequência provável | Prevenção |
|---|---|---|
| Não congelar versões (modelo, prompt, ferramentas, índice e memória) antes de corrigir | Perda de evidências e de causa raiz | Procedimento de congelamento e hashes |
| Limpar memória ou reconstruir o índice sem exportar | Impossibilidade de reconstruir o incidente | Exportar antes de alterar |
| Excluir credenciais em vez de desativá-las | Perda de rastreabilidade | Desativar e preservar |
| Confiar apenas no trace | Ações não registradas passam despercebidas | Corroborar com auditorias dos sistemas de destino |
| Atribuir o incidente ao modelo, ignorando permissões e controles | Correções ineficazes | Análise de agência excessiva e de arquitetura |
| Considerar só ataques e ignorar falhas de projeto | Incidentes recorrentes | Distinguir falha, abuso e ataque |
| Aprovar servidores e ferramentas sem fixar versões e hashes | Alterações posteriores não detectadas | Inventário, hashes e verificação periódica |
| Controles de acesso apenas na interface | Vazamentos por caminhos alternativos | Controles na camada de dados e testes negativos |
| Memória global ou compartilhada sem controle | Contaminação em larga escala | Escopo por usuário e revisão de gravações |
| Reativar sem testes de regressão e de segurança | Reincidência | Validação e liberação gradual |
| Ausência de limites de iteração, de custo e de volume | Negação de carteira e danos em lote | Limites e orçamentos |
| Credenciais e segredos no contexto ou nos prompts | Vazamento por saída e por logs | Cofre de segredos, mascaramento e varredura |
| Comunicações com afirmações categóricas sem evidência | Retratações e danos de reputação | Fatos verificados, incertezas explícitas |
| Não envolver o fornecedor e o Jurídico cedo | Perda de registros e de prazos | Contatos prévios e preservação imediata |
| Realizar testes ofensivos em produção | Novos incidentes | Ambientes de teste autorizados |

## 9. Exercícios práticos

1. Monte um agente simples de laboratório (com ferramentas fictícias e registro de traces) e gere execuções normais; registre os traces no formato do modelo D.
2. Em ambiente de teste, simule um conteúdo externo com uma instrução **inofensiva** para o agente (por exemplo, "adicione uma frase específica ao final do resumo") e investigue: fonte, linha do tempo, trace e alcance.
3. Escreva a matriz C (ferramentas, permissões e identidades) do seu agente de laboratório e aplique o privilégio mínimo; documente a diferença antes e depois.
4. Crie um índice de RAG de laboratório com documentos fictícios de dois "setores" e implemente filtros por permissão; escreva testes negativos de acesso e uma consulta SQL que detecte recuperações indevidas.
5. Gere manifestos de ferramentas de um servidor de laboratório em duas versões, altere uma descrição inofensiva e demonstre a detecção por hash e por `diff`.
6. Treine o congelamento: preencha o modelo B para o seu sistema de laboratório e meça o tempo.
7. Realize um exercício de mesa com o cenário do caso 1, usando o PB-45 e os modelos A, D e E.
8. Escreva o relatório do caso 2 (vazamento entre locatários), com a linha do tempo, a causa, as notificações e as recomendações.

Use somente dados fictícios e ambientes de laboratório. Não teste técnicas de injeção ou de exfiltração contra sistemas de terceiros ou de produção.

## 10. Normas e frameworks relevantes

- OWASP Top 10 para LLM; OWASP GenAI Security Project; MITRE ATLAS; NIST AI 600-1
- NIST SP 800-61 Rev. 3; ISO/IEC 27035; ISO/IEC 42001:2023
- LGPD, arts. 6º, 46, 48; CDC, arts. 14 e 20; Regulamento (UE) 2024/1689 (arts. 50 e 73)

## 11. Referências

- OWASP. Top 10 for LLM Applications e GenAI Security Project (edições vigentes).
- MITRE. ATLAS: estudos de caso.
- Responsible AI Collaborative. AI Incident Database.
- Pastas 17, 19, 22, 23, 24 e 25 deste repositório.
