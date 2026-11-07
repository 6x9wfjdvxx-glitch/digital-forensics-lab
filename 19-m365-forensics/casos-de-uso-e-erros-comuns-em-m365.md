# Casos de Uso e Erros Comuns em M365

> **Objetivo pedagógico:** consolidar o aprendizado de forense no Microsoft 365 com cenários corporativos realistas, os erros mais frequentes, suas consequências e as medidas de prevenção.

Os casos são fictícios e destinados ao treinamento.

## 1. Caso 1: BEC com regra de caixa, aplicativo OAuth e coleta de arquivos

**Pergunta:** o que a conta comprometida fez nos serviços do Microsoft 365?

| Fonte | Achado |
|---|---|
| Entra ID | Entrada com MFA de IP de hospedagem e agente incomum; Identity Protection: "atacante no meio" |
| UAL (Exchange) | `New-InboxRule` com nome "." movendo mensagens "fatura"; `MailItemsAccessed` (Sync) por aplicativo desconhecido |
| UAL (Entra) | `Consent to application` com `Mail.Read` e `offline_access` |
| UAL (SharePoint) | 640 `FileDownloaded` do site Financeiro em 12 minutos |
| Message trace | 9 mensagens enviadas a fornecedores com dados bancários novos |
| Resposta | Preservar; revogar sessões; redefinir credenciais; remover regra e consentimento; avisar fornecedores e o banco; avaliar os dados baixados |

**Lição:** a investigação exige correlacionar identidade, e-mail, arquivos e aplicativos; cada fonte mostra um pedaço da cadeia.

## 2. Caso 2: colaborador em desligamento baixa arquivos em massa

| Fonte | Achado |
|---|---|
| SharePoint e OneDrive | Aumento de 12 vezes nos acessos; 3.900 `FileSyncDownloadedFull` e `FileDownloaded` de dispositivo não gerenciado |
| Compartilhamento | 14 `AnonymousLinkCreated` para pastas de propostas; links usados de IP residencial |
| Proxy | 4,8 GB enviados a um serviço de armazenamento pessoal |
| Contexto | Desligamento comunicado no dia anterior |
| Resposta | Retenção legal, preservação da auditoria, remoção dos links, bloqueio da sincronização e análise do endpoint, com comunicação ao Jurídico e ao RH |

**Lição:** combine a auditoria de arquivos com o proxy e o endpoint; aja com base legal e escopo claros.

## 3. Caso 3: fluxo de Power Automate encaminhando e-mails

| Fonte | Achado |
|---|---|
| Auditoria | Criação de um fluxo com gatilho em mensagens com "pagamento" e encaminhamento a um endereço externo, durante o comprometimento |
| Persistência | O fluxo continuou ativo após a troca de senha, por usar uma conexão existente |
| Impacto | 212 mensagens encaminhadas em 9 dias |
| Resposta | Exportar a definição e o histórico, desativar o fluxo, revogar as conexões, restringir o conector e revisar fluxos de outras contas |

**Lição:** a automação é um mecanismo de persistência que sobrevive à redefinição de credenciais; inclua o Power Platform na revisão pós-incidente.

## 4. Caso 4: phishing por Teams a partir de locatário externo

| Fonte | Achado |
|---|---|
| UAL e Teams | Contas externas de locatário recém-criado enviam links a 14 usuários da área financeira |
| Defender e Entra | 5 cliques (`UrlClickEvents`) e 2 entradas bem-sucedidas de IP de hospedagem |
| Pós-comprometimento | Regras de caixa e `MailItemsAccessed` nas duas contas |
| Resposta | Bloquear o domínio externo na federação, revogar sessões, remover regras, orientar usuários e restringir o acesso externo a domínios permitidos |

**Lição:** o Teams é um canal de phishing; controle o acesso externo e monitore mensagens de locatários desconhecidos.

## 5. Caso 5: aplicativo OAuth lendo caixas de correio em massa

| Fonte | Achado |
|---|---|
| Entra ID | Aplicativo de terceiros com `Mail.Read` consentido por 7 usuários, após campanha de phishing |
| UAL e Graph | `MailItemsAccessed` e solicitações ao Graph a partir de IP de hospedagem para as 7 caixas, em ciclos regulares |
| Alcance | Acessos a mensagens de 4 meses |
| Resposta | Revogar consentimentos, remover o aplicativo, avaliar as mensagens acessadas, restringir o consentimento de usuários e exigir aprovação de administrador |

**Lição:** o aplicativo mantém o acesso mesmo após a troca de senha; revise consentimentos em todo o locatário.

## 6. Caso 6: administrador de eDiscovery comprometido

| Fonte | Achado |
|---|---|
| Entra ID | Entrada anômala de uma conta com função de Gerente de eDiscovery |
| UAL | `SearchCreated` e `SearchExported` sobre as caixas de executivos, fora de qualquer caso aprovado |
| Impacto | Exportação de milhares de e-mails de 8 executivos |
| Resposta | Preservar a auditoria, revogar a sessão, remover a função, avaliar o conteúdo exportado, notificar conforme a legislação e restringir funções de eDiscovery com PIM e alertas |

**Lição:** funções de eDiscovery são de alto privilégio; monitore as pesquisas e as exportações e restrinja o escopo.

## 7. Caso 7: ransomware em OneDrive

| Fonte | Achado |
|---|---|
| UAL | Milhares de `FileModified` e `FileRenamed` com nova extensão, a partir do cliente de sincronização de um notebook comprometido |
| Propagação | Arquivos criptografados sincronizados para o OneDrive e para bibliotecas compartilhadas |
| Resposta | Isolar o notebook, revogar sessões, restaurar o OneDrive a um ponto no tempo anterior à criptografia, restaurar a biblioteca e preservar o estado atual antes de restaurar |
| Prevenção | Controles de sincronização por dispositivo gerenciado e alertas de alterações em massa |

**Lição:** a restauração a um ponto no tempo é decisiva, mas depende do tempo de detecção; preserve o estado e registre a ação.

## 8. Erros comuns, consequências e prevenção

| Erro | Consequência provável | Prevenção |
|---|---|---|
| Depender da retenção nativa de auditoria sem exportá-la | Perda de evidências antigas | Exportação contínua e retenção prolongada |
| Não verificar o licenciamento e a retenção no início | Expectativas irreais sobre a evidência | Inventário de prontidão |
| Pesquisar a auditoria com limite máximo sem dividir a janela | Registros perdidos sem perceber | Dividir o período, paginar e conferir contagens |
| Tratar a ausência de registro como ausência de acesso | Conclusões erradas | Entender latências, agregações e eventos não auditados |
| Interpretar o IP de origem como o do atacante | Atribuição errada | Verificar o aplicativo, o agente e se pertence a serviço da Microsoft |
| Aplicar a retenção legal depois de pesquisar ou de a evidência ser excluída | Perda de dados | Aplicar a retenção legal primeiro |
| Redefinir senhas sem remover aplicativos, fluxos, regras e conectores | Persistência | Revisão completa de persistência |
| Pesquisar e exportar conteúdo sem escopo, sem base legal e sem revisão de privilégio | Violações legais e éticas | Autorização, escopo, minimização e revisão jurídica |
| Conceder funções amplas de eDiscovery e de auditoria | Risco de abuso e de acesso indevido | Privilégio mínimo, PIM e monitoramento |
| Remover mensagens e regras sem preservar | Perda de evidências | Exportar e registrar antes de alterar |
| Ignorar o Teams, o Power Platform e o Copilot | Vetores e dados não investigados | Escopo amplo dos serviços |
| Não validar a consulta de eDiscovery | Resultados incompletos ou excessivos | Testar com estatísticas e amostras |
| Exportar sem hash e sem cadeia de custódia | Questionamentos de integridade | Hashes e documentação da exportação |
| Declarar "sem acesso a dados" sem logs suficientes | Afirmação indevida | Declarar a limitação e considerar o pior caso |

## 9. Exercícios práticos

1. Em um locatário de teste, verifique com PowerShell a habilitação da auditoria unificada e da auditoria de caixa, e a política de encaminhamento externo.
2. Gere atividades de teste (regra de caixa, compartilhamento anônimo, downloads e criação de um fluxo) e localize os eventos correspondentes na auditoria, com exportação e hash.
3. Escreva consultas KQL (`OfficeActivity` e `CloudAppEvents`) para detectar: regras de caixa, downloads em massa e links anônimos.
4. Crie um caso de eDiscovery de teste, aplique uma retenção legal, execute e valide uma pesquisa e exporte com hashes e termo de extração.
5. Faça uma restauração de teste de uma biblioteca do SharePoint e do OneDrive a um ponto no tempo e documente as ações e os eventos gerados.
6. Elabore o relatório do caso 1, com linha do tempo unificada, mapeamento ATT&CK, avaliação de impacto, ações de contenção com o estado anterior e recomendações.

Use apenas um locatário de teste dedicado (por exemplo, um ambiente de desenvolvimento ou de avaliação) e o simulador de ataques do Defender for Office 365 para treinar usuários e detecções. Os laboratórios de treinamento do Microsoft Sentinel também oferecem dados de exemplo.

## 10. Normas e frameworks relevantes

- MITRE ATT&CK for Cloud: T1078.004, T1114.002, T1114.003, T1213, T1528, T1566.003, T1567, T1020, T1098, T1485, T1486
- NIST SP 800-61 Rev. 3; NIST SP 800-201; ISO/IEC 27050; EDRM
- CIS Microsoft 365 Foundations Benchmark; CIS Controls v8.1, controles 3, 6, 8, 9 e 17
- LGPD, arts. 6º, 7º, 46 e 48

## 11. Referências

- Microsoft. Incident response playbooks; Microsoft Sentinel Training Lab.
- Microsoft Learn. Purview Audit, eDiscovery, Defender for Office 365 e Defender for Cloud Apps.
- Invictus Incident Response. Microsoft-Extractor-Suite.
- MITRE ATT&CK for Cloud. https://attack.mitre.org
- The DFIR Report. Relatórios públicos de incidentes.
- SANS Institute. FOR509 e SEC541.
