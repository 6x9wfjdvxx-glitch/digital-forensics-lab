# Casos de Uso e Erros Comuns em Nuvem

> **Objetivo pedagógico:** consolidar o aprendizado de forense em nuvem com cenários corporativos realistas, os erros mais frequentes, suas consequências e as medidas de prevenção.

Os casos são fictícios e destinados ao treinamento.

## 1. Caso 1: chave de acesso vazada e mineração de criptomoedas

**Pergunta:** a chave foi usada de forma indevida e o que foi acessado?

| Fonte | Achado |
|---|---|
| Alerta de custos e do provedor | Aumento súbito de custos e notificação sobre credencial exposta |
| CloudTrail | `GetCallerIdentity` e reconhecimento a partir de IP de hospedagem; `RunInstances` com GPUs em 6 regiões; `CreateAccessKey` para outro usuário |
| Evasão | `StopLogging` na trilha da conta (a trilha organizacional manteve os registros) |
| Resposta | Chaves desativadas, sessões revogadas, instâncias removidas após snapshots, usuário criado removido, restrição de regiões por política e varredura de repositórios |

**Lição:** a trilha organizacional em conta separada manteve a evidência mesmo após a tentativa de evasão.

## 2. Caso 2: bucket com dados de clientes acessível publicamente

| Fonte | Achado |
|---|---|
| Alerta de postura | Bucket público com arquivos de clientes |
| Eventos de configuração | `DeletePublicAccessBlock` e `PutBucketPolicy` permissiva, 41 dias antes, por um desenvolvedor, para um teste |
| Logs de acesso a dados | Não habilitados |
| Avaliação | Não é possível comprovar quais objetos foram baixados; o acesso era possível por 41 dias |
| Decisão | Tratar como exposição potencial de todos os dados do bucket; notificação avaliada conforme a LGPD |

**Lição:** sem logs de acesso a dados, o pior caso prevalece; habilite os logs antes do incidente.

## 3. Caso 3: SSRF e credenciais do serviço de metadados

| Fonte | Achado |
|---|---|
| WAF e logs da aplicação | Requisições com URL de metadados no parâmetro de um recurso de importação |
| CloudTrail | Credenciais temporárias da função da instância usadas de IP externo para listar buckets e ler objetos |
| GuardDuty | Achado de exfiltração de credenciais da instância usadas fora da AWS |
| Resposta | Correção da aplicação, IMDSv2 obrigatório, redução das permissões da função e revisão dos dados acessados |

**Lição:** correlacione o log da aplicação com os eventos da nuvem; o IMDSv2 e permissões mínimas reduzem muito o impacto.

## 4. Caso 4: comprometimento do pipeline de CI/CD

| Fonte | Achado |
|---|---|
| Plataforma de código | Alteração em um arquivo de pipeline que enviava segredos a um servidor externo |
| Logs de auditoria da nuvem | Uso da credencial do pipeline para criar funções e acessar segredos |
| Escopo | Artefatos publicados no período e implantados em produção |
| Resposta | Rotação dos segredos do pipeline, revisão e reconstrução de artefatos, revisão de dependências e restrição de permissões do pipeline |

**Lição:** o pipeline é um alvo de alto valor; trate seus segredos e permissões como os de um administrador.

## 5. Caso 5: função de porta dos fundos com confiança externa

| Fonte | Achado |
|---|---|
| CloudTrail | Criação de função com política de confiança para conta externa e anexação de permissão administrativa |
| Uso | `AssumeRole` a partir da conta externa, seguido de acesso a dados e compartilhamento de snapshots |
| Resposta | Remoção da função (com a configuração preservada), revogação de sessões e do compartilhamento, revisão de todas as políticas de confiança da conta |
| Prevenção | Alertas para alterações de confiança, IAM Access Analyzer e políticas de controle de serviço |

**Lição:** a persistência por funções é discreta; monitore alterações de confiança e acessos externos.

## 6. Caso 6: cluster Kubernetes com painel exposto

| Fonte | Achado |
|---|---|
| Logs de auditoria | Criação de pod privilegiado com montagem do sistema de arquivos do nó, a partir do painel exposto |
| Nó | Processo de mineração e acesso às credenciais do nó |
| Resposta | Isolar o nó e o pod, preservar (definições, logs e discos), rotacionar segredos, remover a exposição e restringir o RBAC e as políticas de admissão |

**Lição:** privilégios de pod e exposição da interface de gestão ampliam o impacto até o nó e a conta.

## 7. Caso 7: instância encerrada pelo Auto Scaling antes da coleta

| Fonte | Achado |
|---|---|
| Situação | A instância comprometida foi reciclada por falha em verificação de saúde antes do snapshot |
| Evidências remanescentes | Logs de auditoria, de fluxo e do balanceador; imagem de origem; volumes excluídos ao encerrar |
| Consequência | Sem disco nem memória; a análise ficou restrita aos logs e à imagem |
| Lição aplicada | Automação de preservação: ao receber o alerta, a instância é retirada do grupo e o snapshot é criado automaticamente |

**Lição:** a automação de preservação deve estar pronta antes do incidente; recursos efêmeros não esperam.

## 8. Erros comuns, consequências e prevenção

| Erro | Consequência provável | Prevenção |
|---|---|---|
| Excluir chaves, instâncias e funções antes de preservar | Perda de evidências | Desativar, isolar, copiar e só então remover |
| Confiar só no histórico de eventos de 90 dias | Perda de dados antigos | Trilhas organizacionais com retenção e arquivamento |
| Não habilitar logs de acesso a dados, de fluxo e de DNS | Impossibilidade de comprovar acesso e exfiltração | Habilitar nos ambientes críticos antes do incidente |
| Logs apenas na própria conta de produção | Adulteração e exclusão pelo atacante | Conta de logs separada e imutável |
| Ignorar regiões não utilizadas | Recursos do atacante passam despercebidos | Cobertura de todas as regiões e restrição por política |
| Desativar a chave e esquecer as sessões temporárias já emitidas | Acesso persistente | Revogar sessões e aplicar negação por horário de emissão |
| Compartilhar snapshots cifrados com a chave padrão | Falha na cópia e atraso | Chaves gerenciadas pelo cliente e prontidão |
| Montar volumes com permissão de escrita | Alteração da evidência | Montagem somente leitura e imagem com hash |
| Usar credenciais amplas e compartilhadas na investigação | Falta de rastreabilidade | Contas nominais com permissões mínimas |
| Não registrar o estado antes da contenção | Impossibilidade de reverter ou provar | Registro de ações com estado anterior |
| Presumir que o IP de origem é do atacante | Atribuição errada | Verificar se pertence a serviço do provedor ou a proxies |
| Ignorar pipelines, repositórios e identidades federadas | Vetor não identificado | Escopo inclui CI/CD, código e provedores de identidade |
| Desconsiderar jurisdição e contratos | Violações legais e atrasos | Consulta ao Jurídico e ao DPO desde o início |
| Concluir "sem acesso a dados" sem logs de dados | Afirmação indevida | Declarar a limitação e tratar o pior caso |
| Testar técnicas de ataque em produção | Incidente real | Emulação somente em contas de teste isoladas |

## 9. Exercícios práticos

1. Em uma conta de teste, habilite a trilha organizacional, os logs de fluxo e os eventos de dados de um bucket, e verifique a validação de integridade das trilhas.
2. Use o laboratório flaws.cloud, o CloudGoat ou The Big IAM Challenge (somente em contas e ambientes de prática) e reconstrua, pelo CloudTrail, as ações realizadas.
3. Escreva consultas (Athena ou `gcloud logging read`) para detectar: `StopLogging`, `CreateAccessKey`, `UpdateAssumeRolePolicy`, `ModifySnapshotAttribute` e `RunInstances` em regiões incomuns.
4. Em uma instância de teste, execute o procedimento completo de preservação: proteção, isolamento, snapshot, compartilhamento com a conta forense, imagem com hash e montagem somente leitura.
5. Prepare um pod de teste em um cluster de laboratório e colete: definição, logs, estado, e aplique a técnica de rótulos de quarentena.
6. Elabore o relatório do caso 5, com a linha do tempo, o mapeamento ATT&CK, as ações de contenção (com o estado anterior) e as recomendações.

Para emular técnicas de ataque com o objetivo de testar detecções, use ferramentas como o Stratus Red Team e os testes de nuvem do Atomic Red Team apenas em **contas de teste dedicadas**, com autorização e monitoramento de custos.

## 10. Normas e frameworks relevantes

- MITRE ATT&CK for Cloud: T1078.004, T1098, T1530, T1537, T1552, T1562.008, T1578, T1496, T1195, T1610
- NIST SP 800-201; NIST SP 800-61 Rev. 3; ISO/IEC 27017
- CIS Benchmarks de nuvem; CIS Controls v8.1, controles 5, 6, 8 e 17
- LGPD, arts. 46 e 48

## 11. Referências

- Piper, S. flaws.cloud e flaws2.cloud. Rhino Security Labs. CloudGoat. Wiz. The Big IAM Challenge.
- Datadog. Stratus Red Team; Red Canary. Atomic Red Team.
- MITRE ATT&CK for Cloud. https://attack.mitre.org
- AWS e Google Cloud. Guias de resposta a incidentes.
- The DFIR Report. Relatórios públicos de incidentes.
- SANS Institute. FOR509 e SEC541.
