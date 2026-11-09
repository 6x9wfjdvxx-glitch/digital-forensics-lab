# Casos de Uso e Erros Comuns em Forense de IA

> **Objetivo pedagógico:** consolidar o aprendizado de forense de IA com cenários corporativos realistas, os erros mais frequentes, suas consequências e as medidas de prevenção.

Os casos são fictícios e destinados ao treinamento.

## 1. Caso 1: modelo substituído no armazenamento antes da promoção

| Fonte | Achado |
|---|---|
| Monitoramento | Queda de desempenho do modelo para um subgrupo após a promoção da v18 |
| Registro e armazenamento | Promoção fora da janela; hash do arquivo diferente do registrado; escrita no objeto às 22:38 UTC por uma chave de acesso de um usuário externo ao time de ML |
| Testes | Saídas diferentes em 6% das entradas, concentradas no subgrupo |
| Resposta | Preservação, desativação da chave, restauração da v17, investigação do acesso e revisão de permissões; imutabilidade das versões no registro |

**Lição:** o hash registrado no momento do treinamento e a auditoria do armazenamento tornaram a substituição demonstrável.

## 2. Caso 2: modelo de repositório público com código executável ao carregar

| Fonte | Achado |
|---|---|
| Situação | Um cientista de dados baixou um modelo de formato baseado em serialização de objetos de um publicador desconhecido |
| Detecção | O EDR registrou uma conexão de saída do ambiente de treinamento logo após o carregamento |
| Análise | A inspeção estática do arquivo (em ambiente isolado) mostrou importação de módulos de execução de processos |
| Resposta | Isolamento do ambiente, revogação de credenciais de nuvem presentes, revisão de dados acessíveis e política de uso de formatos seguros e de varredura prévia |

**Lição:** trate artefatos de modelo como código; carregue-os somente após verificação, em ambiente isolado.

## 3. Caso 3: painel de orquestração de ML exposto e mineração em GPU

| Fonte | Achado |
|---|---|
| Alerta | Custos de nuvem 12 vezes acima do normal em um cluster de GPU |
| Logs | Acessos sem autenticação ao painel do orquestrador, a partir de IPs externos; criação de trabalhos desconhecidos |
| Nós | Processos de mineração e acesso a credenciais montadas nos contêineres |
| Resposta | Preservação e isolamento (PB-30 e PB-35), remoção de recursos, rotação de segredos, fechamento da exposição e autenticação obrigatória |

**Lição:** ferramentas de ciência de dados são alvos frequentes; exigem autenticação, segmentação e monitoramento.

## 4. Caso 4: envenenamento de dados em ciclo de feedback

| Fonte | Achado |
|---|---|
| Situação | Um sistema de recomendação passou a promover conteúdos de baixa qualidade |
| Análise | Dados de retreinamento incluíam interações geradas por contas automatizadas criadas na mesma semana; os rótulos implícitos (cliques) foram manipulados |
| Investigação | O versionamento de dados mostrou o aumento súbito de amostras com padrões repetidos; a auditoria do pipeline confirmou que não havia filtros de qualidade |
| Resposta | Restauração da versão de dados anterior, filtros contra contas automatizadas, retreinamento e monitoramento por subgrupo |

**Lição:** ciclos de feedback são vetores de envenenamento; o versionamento e a linhagem de dados permitem demonstrar o que mudou.

## 5. Caso 5: extração de modelo via API

| Fonte | Achado |
|---|---|
| Logs | Três contas novas com volume 40 vezes maior que o normal, consultas em grade sistemática próximas às fronteiras de decisão, distribuídas por 120 IPs |
| Impacto | Modelo proprietário, termos de uso que proíbem a engenharia reversa |
| Resposta | Suspensão das contas, limites de taxa, redução da granularidade das saídas, preservação dos logs e avaliação contratual pelo Jurídico |

**Lição:** o monitoramento por padrão de consulta e a preservação dos logs de inferência são decisivos.

## 6. Caso 6: colaborador cola dados de clientes em ferramenta pública de IA

| Fonte | Achado |
|---|---|
| DLP e proxy | Três envios de planilhas com CPFs a um serviço de IA público, por conta pessoal |
| Portão legal | Jurídico, RH e DPO autorizaram a apuração restrita aos registros corporativos |
| Fornecedor | Solicitação de exclusão e declaração sobre retenção; conteúdo exato não verificável |
| Medidas | Orientação, bloqueio de domínios de IA não aprovados, ferramenta corporativa com controles, ajuste do DLP e avaliação de notificação pelo DPO |

**Lição:** responda com proporcionalidade e declare as limitações; a solução é também oferecer alternativa corporativa segura.

## 7. Caso 7: auditoria de decisão de crédito e disparidade entre grupos

| Fonte | Achado |
|---|---|
| Solicitação | Titular pede revisão de negativa automatizada (LGPD, art. 20) |
| Reconstrução | O modelo v12, os dados e as regras do momento foram reconstruídos; a decisão foi reproduzida |
| Viés | O monitoramento mostra uma taxa de negativa maior para um grupo, sem justificativa documentada |
| Resposta | Revisão humana da decisão do titular; avaliação jurídica e de governança da disparidade; documentação e plano de correção |

**Lição:** a reprodutibilidade e os registros mínimos permitem responder ao titular e identificar problemas sistêmicos.

## 8. Erros comuns, consequências e prevenção

| Erro | Consequência provável | Prevenção |
|---|---|---|
| Carregar modelos não confiáveis em estações ou em produção | Execução de código malicioso | Ambiente isolado, formatos seguros, inspeção estática e varredura |
| Não registrar hashes e proveniência de modelos e de dados | Impossibilidade de provar adulteração | Manifestos, assinaturas e registros imutáveis |
| Não preservar versões (modelo, dados e código) antes de retreinar ou restaurar | Perda de evidências | Congelar versões e usar tags imutáveis |
| Tratar queda de desempenho como ataque sem considerar causas legítimas | Conclusões infundadas | Hipóteses alternativas (deriva, erros de pipeline e mudanças legítimas) |
| Afirmar a existência de porta dos fundos sem evidência específica | Alegações infundadas | Declarar indícios e confiança; testes dirigidos por especialistas |
| Não registrar entradas e saídas de decisões críticas | Impossibilidade de auditar ou de reproduzir | Registros mínimos com retenção e proteção |
| Ignorar o não determinismo | Conclusões de "inconsistência" indevidas | Registrar sementes e parâmetros; reprodução estatística |
| Exposição de notebooks, rastreadores e painéis sem autenticação | Comprometimento e abuso de recursos | Autenticação, segmentação e inventário |
| Copiar dados pessoais de treinamento para análise sem necessidade | Violação da LGPD | Minimização, análise em ambiente seguro e acesso restrito |
| Usar detectores de texto de IA como prova | Falsos positivos e injustiças | Evidências de proveniência, metadados e contexto |
| Responder a vazamentos por IA somente com punição | Subnotificação e continuidade do risco | Proporcionalidade, orientação, ferramentas aprovadas e canal de reporte |
| Tratar explicações (SHAP e LIME) como prova de causalidade | Conclusões enganosas | Declarar a metodologia e as limitações |
| Ausência de documentação de governança (RIPD, cartões e validações) | Dificuldade de demonstrar diligência | Documentação mantida e versionada |
| Não envolver a equipe de ciência de dados na investigação | Interpretações técnicas incorretas | Equipe multidisciplinar e revisão por pares |
| Desconsiderar dependências externas e contratos de fornecedores | Falta de acesso a logs e de poder de exigir exclusão | Cláusulas de auditoria, retenção e cooperação |

## 9. Exercícios práticos

1. Em um ambiente de laboratório, treine um modelo simples, registre-o no MLflow, calcule os hashes dos artefatos e monte o registro do conjunto de versões (modelo B).
2. Simule a substituição de um artefato no armazenamento e demonstre a divergência de hash, a auditoria de acesso e a comparação estrutural e comportamental entre as versões.
3. Com arquivos de teste **seguros e inofensivos** (por exemplo, gerados por você em laboratório, sem comportamento malicioso), pratique a inspeção estática com `pickletools` e com um varredor, e a leitura de metadados do `safetensors`.
4. Para um conjunto de dados de exercício, versione com DVC e simule uma alteração não autorizada; identifique-a por `dvc diff` e por hashes.
5. Analise um estudo de caso público do MITRE ATLAS e preencha a matriz ataque, evidência e ação com as fontes que você teria preservado.
6. Escreva consultas de detecção para extração de modelo em logs de gateway de exemplo.
7. Reconstrua uma decisão de crédito fictícia, com o modelo E, e escreva o relatório com análise de viés (usando Fairlearn) e limitações.
8. Elabore a política de uso de IA e o plano de resposta a vazamentos por ferramentas de IA para uma organização fictícia, com portões legais e proporcionalidade.

Use somente dados fictícios e ambientes de laboratório; não crie nem distribua artefatos maliciosos.

## 10. Normas e frameworks relevantes

- MITRE ATLAS; NIST AI 100-2; NIST AI RMF 1.0; OWASP Machine Learning Security Top 10
- ISO/IEC 42001:2023; ISO/IEC 23894:2023; ISO/IEC 27037, 27042 e 27043
- Regulamento (UE) 2024/1689; LGPD, arts. 6º, 20, 37, 38, 46 e 48

## 11. Referências

- MITRE ATLAS. Estudos de caso. https://atlas.mitre.org
- Responsible AI Collaborative. AI Incident Database.
- NIST AI 100-2 (edição vigente); NIST AI RMF 1.0.
- Carlini, N. et al. Extracting Training Data from Large Language Models. 2021.
- Barocas, S.; Hardt, M.; Narayanan, A. Fairness and Machine Learning. 2019.
- Pastas 17, 18, 19, 22 e 23 deste repositório.
