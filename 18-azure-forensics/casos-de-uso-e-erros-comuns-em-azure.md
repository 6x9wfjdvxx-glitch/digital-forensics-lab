# Casos de Uso e Erros Comuns em Azure

> **Objetivo pedagógico:** consolidar o aprendizado de forense no Azure e no Microsoft Entra ID com cenários corporativos realistas, os erros mais frequentes, suas consequências e as medidas de prevenção.

Os casos são fictícios e destinados ao treinamento.

## 1. Caso 1: segredo de entidade de serviço vazado e leitura de Key Vault

**Pergunta:** o segredo foi usado e o que foi acessado?

| Fonte | Achado |
|---|---|
| Repositório de código | Segredo de um registro de aplicativo publicado em um arquivo de configuração |
| `AADServicePrincipalSignInLogs` | Entradas da entidade de serviço de um IP de hospedagem, fora do padrão |
| `AzureActivity` | A entidade de serviço lista grupos de recursos e atribui função de Colaborador a outra entidade |
| Logs do Key Vault | `SecretList` e `SecretGet` de 14 segredos pela mesma identidade |
| Resposta | Preservar logs e configuração; rotacionar o segredo e os 14 segredos expostos; remover a atribuição indevida; restringir a rede do cofre; varrer repositórios por segredos |

**Lição:** entradas de entidades de serviço são uma categoria própria de log; considere todos os segredos acessíveis pela identidade como expostos.

## 2. Caso 2: phishing com proxy reverso e consentimento de aplicativo

| Fonte | Achado |
|---|---|
| `SigninLogs` | Entrada com MFA bem-sucedida de IP de hospedagem e agente incomum; Identity Protection indica "atacante no meio" |
| `AADNonInteractiveUserSignInLogs` | Uso do token do mesmo IP nas horas seguintes |
| `AuditLogs` | `Consent to application` para um aplicativo desconhecido com `Mail.Read` e `offline_access` |
| Alcance | Mais 6 usuários consentiram ao mesmo aplicativo |
| Resposta | Revogar sessões, redefinir credenciais e MFA, remover o aplicativo e os consentimentos, ajustar a política de consentimento do locatário, bloquear a infraestrutura do phishing |

**Lição:** o MFA tradicional não impede o roubo de sessão; os consentimentos de aplicativos mantêm o acesso mesmo após a troca da senha.

## 3. Caso 3: elevação de acesso por Administrador Global comprometido

| Fonte | Achado |
|---|---|
| Entra ID | Entrada de Administrador Global de IP incomum; ativação de PIM com justificativa genérica |
| Log de atividade (locatário) | `Microsoft.Authorization/elevateAccess/action`, seguido de atribuição de Proprietário no escopo raiz a uma conta nova |
| Recursos | Criação de VMs de GPU em várias assinaturas |
| Resposta | Preservar; remover as atribuições e a conta criada; revogar sessões e revisar o PIM; ativar alertas para elevação de acesso; revisar contas de emergência |

**Lição:** a elevação de acesso dá controle de todas as assinaturas; monitore e alerte sobre esse evento.

## 4. Caso 4: abuso de Run Command em máquinas virtuais

| Fonte | Achado |
|---|---|
| `AzureActivity` | Dezenas de execuções de `RUNCOMMAND/ACTION` por uma entidade de serviço, em horário incomum |
| VMs | Logs do agente mostram scripts baixando e executando um binário |
| Impacto | Mineração e instalação de uma chave SSH do atacante |
| Resposta | Preservar as VMs (bloqueio, isolamento e snapshots), revogar as credenciais da entidade de serviço, restringir a permissão de Run Command e criar alertas para a operação |

**Lição:** Run Command dispensa credenciais de rede; sua execução fica no log de atividade e deve ser monitorada.

## 5. Caso 5: SAS de longa duração e exfiltração de blobs

| Fonte | Achado |
|---|---|
| `StorageBlobLogs` | 18 mil `GetBlob` de um IP externo com `AuthenticationType` igual a `SAS`, 42 GB |
| Origem | SAS com validade de 1 ano enviada por e-mail a um terceiro |
| Resposta | Regenerar chaves da conta (invalidando a SAS), limitar prazos por política, usar SAS de delegação de usuário, classificar os dados e avaliar notificações |

**Lição:** SAS de longa duração são credenciais de portador; prefira acesso por Entra ID e prazos curtos.

## 6. Caso 6: persistência por federação de domínio

| Fonte | Achado |
|---|---|
| `AuditLogs` | `Set federation settings on domain` por uma conta de administrador comprometida |
| Efeito | Um provedor de identidade controlado pelo atacante foi confiável para o domínio, permitindo forjar tokens para qualquer usuário (T1484.002) |
| Resposta | Reverter a federação, revisar todas as entradas do período, rotacionar certificados e credenciais, revisar a identidade híbrida e comunicar o incidente |

**Lição:** alterações de federação são eventos de altíssimo impacto; alerte para elas e proteja as contas que podem realizá-las.

## 7. Caso 7: falta de diagnósticos nas assinaturas

| Fonte | Achado |
|---|---|
| Situação | O atacante criou recursos em uma assinatura de testes sem configurações de diagnóstico |
| Evidências | Log de atividade (90 dias) disponível, mas sem logs de recursos e sem exportação |
| Consequência | Foi possível provar a criação de recursos e o ator, mas não o que os recursos fizeram |
| Lição aplicada | Política do Azure que implanta automaticamente as configurações de diagnóstico em todas as assinaturas |

**Lição:** assinaturas esquecidas são pontos cegos; imponha o diagnóstico por política.

## 8. Erros comuns, consequências e prevenção

| Erro | Consequência provável | Prevenção |
|---|---|---|
| Depender da retenção nativa de logs do Entra ID e do log de atividade | Perda de evidências antigas | Exportar para o Log Analytics e para armazenamento imutável |
| Analisar apenas entradas interativas | Tokens e aplicativos passam despercebidos | Analisar as quatro categorias de entradas |
| Redefinir a senha sem revogar sessões e sem remover consentimentos | Acesso persistente | Revogar sessões, tokens e consentimentos |
| Excluir recursos e credenciais antes da preservação | Perda de evidências | Bloquear, isolar, copiar e só então remover |
| Não habilitar logs de plano de dados (Storage, Key Vault e bancos) | Impossibilidade de provar o acesso | Habilitar o diagnóstico por política |
| Tratar o log de atividade como suficiente | Ausência do plano de identidade e de dados | Correlacionar com Entra ID e logs de recursos |
| Ignorar entidades de serviço e identidades gerenciadas | Vetor e persistência não identificados | Revisar credenciais, permissões e entradas de aplicativos |
| Desconsiderar a identidade híbrida e a federação | Persistência remanescente | Tratar o Entra Connect e o AD FS como ativos críticos |
| Permissões de investigação excessivas | Risco e falta de rastreabilidade | Privilégios mínimos e PIM |
| Registrar URLs SAS e segredos em relatórios | Vazamento de credenciais | Mascarar e revogar |
| Não considerar o acesso à chave de criptografia dos discos | Imagens ilegíveis | Preservar cofres, chaves e permissões |
| Testar técnicas de ataque em produção | Incidente real | Emulação apenas em locatário de teste |
| Concluir "sem acesso a dados" sem logs | Afirmação indevida | Declarar a limitação e considerar o pior caso |
| Desconsiderar jurisdição, contratos e privacidade | Violações e atrasos | Consulta ao Jurídico e ao DPO desde o início |

## 9. Exercícios práticos

1. Em um locatário de teste, configure o envio dos logs de entrada, de auditoria e do log de atividade para um workspace, e escreva as consultas KQL dos arquivos 2 e 3.
2. Use o BadZure para criar caminhos de ataque em um locatário de laboratório e identifique, pelos logs, as alterações de privilégio e de aplicativos.
3. Use o Stratus Red Team para executar técnicas de Azure em uma assinatura de teste e escreva as detecções correspondentes (por exemplo, Run Command, criação de credenciais de aplicativos e acesso ao Key Vault).
4. Em uma VM de teste, execute o procedimento completo: bloqueio, NSG de quarentena, coleta volátil, snapshot, cópia para a assinatura forense, imagem com hash e montagem somente leitura.
5. Prepare o ambiente com o laboratório Microsoft Sentinel Training Lab e investigue os incidentes de exemplo.
6. Elabore o relatório do caso 3, com linha do tempo, mapeamento ATT&CK, ações de contenção com o estado anterior e recomendações.

Para emular técnicas de ataque, use apenas locatários e assinaturas de teste dedicados, com autorização e monitoramento de custos.

## 10. Normas e frameworks relevantes

- MITRE ATT&CK for Cloud: T1078.004, T1098.001, T1098.003, T1528, T1539, T1484.002, T1606.002, T1530, T1552, T1578, T1651, T1496
- NIST SP 800-201; NIST SP 800-61 Rev. 3; ISO/IEC 27017
- CIS Microsoft Azure Foundations Benchmark; CIS Controls v8.1, controles 5, 6, 8 e 17
- LGPD, arts. 46 e 48

## 11. Referências

- Microsoft. Incident response playbooks; Microsoft Sentinel Training Lab.
- Datadog. Stratus Red Team. Cáseres, M. BadZure. INE. AzureGoat.
- Microsoft Learn. Documentação do Microsoft Entra ID, do Azure Monitor e do Defender for Cloud.
- MITRE ATT&CK for Cloud. https://attack.mitre.org
- The DFIR Report. Relatórios públicos de incidentes.
- SANS Institute. FOR509 e SEC541.
