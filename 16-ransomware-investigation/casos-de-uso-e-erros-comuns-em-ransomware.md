# Casos de Uso e Erros Comuns em Ransomware

> **Objetivo pedagógico:** consolidar o aprendizado sobre investigação e resposta a ransomware com cenários corporativos realistas, os erros mais frequentes, suas consequências e as medidas de prevenção.

Os casos são fictícios e destinados ao treinamento.

## 1. Caso 1: RDP exposto, domínio comprometido e implantação por GPO

**Pergunta:** como o ataque ocorreu e qual o escopo?

| Fonte | Achado |
|---|---|
| Firewall | Porta de RDP exposta a um servidor de aplicação |
| EVTX | Muitas falhas 4625 e depois um 4624 tipo 10 bem-sucedido, de IP de hospedagem, 8 dias antes |
| Credenciais | Sysmon 10 mostra acesso ao LSASS; DCSync no 5º dia (4662) |
| Implantação | GPO criada às 03:00Z (5136) com tarefa imediata que executa o binário |
| Impacto | 190 hosts criptografados |
| Resposta | Remoção da exposição do RDP, reconstrução do domínio, redefinição do `krbtgt` duas vezes, restauração dos sistemas a partir de backups imutáveis |

**Lição:** o RDP exposto sem MFA foi a porta de entrada; o domínio estava comprometido muito antes da criptografia.

## 2. Caso 2: VPN sem MFA e credenciais de infostealer

| Fonte | Achado |
|---|---|
| Logs da VPN | Login válido de um colaborador, a partir de IP incomum, em horário de madrugada |
| Inteligência | As credenciais do colaborador constavam em um conjunto de credenciais roubadas por infostealer, meses antes |
| Pós-acesso | Instalação de ferramenta de acesso remoto, descoberta do AD e movimentação lateral |
| Resposta | MFA obrigatório e resistente a phishing, redefinição de credenciais, monitoramento de vazamentos de credenciais |

**Lição:** credenciais válidas dispensam exploração; MFA e monitoramento de credenciais vazadas são essenciais.

## 3. Caso 3: ESXi criptografado

| Fonte | Achado |
|---|---|
| vCenter e ESXi | SSH habilitado no sábado à noite; credenciais do administrador do vCenter usadas de um host de salto comprometido |
| `shell.log` | Comandos `esxcli vm process list` e `esxcli vm process kill`, seguidos de criptografia de arquivos de VMs |
| Impacto | 74 máquinas virtuais indisponíveis |
| Recuperação | Backups das VMs em repositório imutável; reconstrução dos hosts ESXi |
| Prevenção | Rede de gestão segregada, MFA no vCenter, SSH desabilitado por padrão e monitoramento dos logs do ESXi |

**Lição:** hipervisores são alvos de alto impacto e frequentemente sem EDR; proteja a gestão e centralize seus logs.

## 4. Caso 4: extorsão dupla com exfiltração por Rclone

| Fonte | Achado |
|---|---|
| EDR | Execução de `rclone.exe` com um arquivo de configuração em diretório temporário, em um servidor de arquivos, por 5 horas |
| Proxy e fluxos | 380 GB enviados a um armazenamento em nuvem |
| Atacante | Envia uma lista de diretórios e amostras de arquivos na negociação |
| Resposta | Classificação dos dados, notificação à ANPD no prazo, comunicação aos titulares e monitoramento do site de vazamentos |
| Decisão | A direção decide não negociar; a recuperação segue pelos backups |

**Lição:** a exfiltração determina o impacto legal e de reputação, mesmo quando a recuperação técnica é possível.

## 5. Caso 5: provedor de serviços gerenciados (MSP) comprometido

| Fonte | Achado |
|---|---|
| Ferramenta de gestão remota | Console do MSP usado para distribuir o binário simultaneamente a vários clientes |
| Evidências na vítima | Execução em horário incomum por uma conta de serviço do MSP |
| Resposta | Contenção do acesso do MSP, revisão contratual e de acessos, comunicação coordenada com o provedor e os demais clientes |
| Prevenção | Contas do MSP com MFA, privilégio mínimo, segmentação e monitoramento do uso de ferramentas de gestão |

**Lição:** relações de confiança ampliam o impacto; inclua provedores no plano de resposta.

## 6. Caso 6: backups também criptografados

| Fonte | Achado |
|---|---|
| Situação | O servidor de backup estava no domínio e acessível com a mesma conta de administração |
| Atacante | Excluiu o catálogo e criptografou os repositórios 2 dias antes da implantação |
| Impacto | Sem backups utilizáveis; recuperação por reconstrução manual e por dados em sistemas de origem |
| Lições | Backups imutáveis e offline, separação de credenciais, monitoramento de exclusões e testes de restauração |

**Lição:** o backup que o atacante alcança não é backup; separe a identidade e use imutabilidade.

## 7. Caso 7: decifrador disponível

| Etapa | Resultado |
|---|---|
| Identificação | A nota e a extensão correspondem a uma família com decifrador gratuito em um repositório reconhecido |
| Validação | O decifrador foi testado em ambiente isolado, em cópias de arquivos criptografados |
| Execução | Decifragem em ondas, com verificação de integridade |
| Recuperação | 97% dos arquivos recuperados; o restante, de backups |
| Complementos | Reconstrução dos sistemas, erradicação do acesso e investigação do vetor |

**Lição:** a decifragem não encerra o incidente; o acesso do atacante e a exfiltração ainda precisam ser tratados.

## 8. Erros comuns, consequências e prevenção

| Erro | Consequência provável | Prevenção |
|---|---|---|
| Desligar ou reinstalar tudo sem preservar evidências | Perda de provas, da memória e da causa raiz | Isolar, capturar e só então reconstruir |
| Usar e-mail e diretório comprometidos para coordenar a resposta | O atacante acompanha a resposta | Canal fora de banda |
| Restaurar backups em ambiente ainda comprometido | Nova criptografia | Erradicar antes de restaurar |
| Restaurar imagens completas sem verificar persistência | Reintrodução do atacante | Reconstruir o sistema e restaurar dados, com caça prévia |
| Não redefinir o `krbtgt` e credenciais privilegiadas após comprometimento do domínio | Acesso persistente por tíquetes forjados | Plano de redefinição em duas etapas |
| Ignorar a exfiltração | Notificações incompletas e surpresas posteriores | Investigar a exfiltração e presumir o pior na ausência de evidências |
| Afirmar publicamente que nenhum dado foi acessado sem evidências | Perda de credibilidade e responsabilidade | Declarações calibradas |
| Pagar sem validar, sem triagem de sanções ou sem decisão formal | Riscos legais, financeiros e de ineficácia | Estrutura de decisão, Jurídico e especialistas |
| Contato com o atacante conduzido por funcionários sem preparo | Erros e vazamentos de informação | Profissionais experientes e ambiente isolado |
| Executar decifradores sem teste | Corrupção de dados | Teste em ambiente isolado e uso em cópias |
| Descuidar dos prazos de notificação | Sanções e perda de confiança | Matriz de notificações desde o início |
| Não investigar o acesso inicial | Reincidência | Fechar a porta de entrada e validar |
| Focar apenas na criptografia e ignorar hipervisores, nuvem e e-mail | Acessos remanescentes | Escopo amplo: identidade, nuvem e infraestrutura |
| Baixar e manipular dados vazados por conta própria | Riscos legais e de segurança | Serviços especializados e Jurídico |
| Declarar o encerramento sem caça e sem monitoramento | Reentrada do atacante | Validação e monitoramento reforçado |

## 9. Exercícios práticos

1. Realize um exercício de simulação (tabletop) com os pacotes do CISA (CTEP) e preencha o Livro de Decisões, a Matriz de Notificações e o Inventário de Sistemas Afetados.
2. Em um laboratório com logs de exercício (por exemplo, relatórios públicos do The DFIR Report), construa a linha do tempo de um ataque de ransomware, do acesso inicial à implantação.
3. Escreva consultas (EDR ou Sigma) para detectar: exclusão de cópias de sombra, acesso ao LSASS, DCSync e instalação de ferramentas de acesso remoto.
4. Elabore um plano de recuperação priorizado de 10 dias para uma empresa fictícia, com a ordem de reconstrução do domínio, dos backups e dos sistemas.
5. Rascunhe a comunicação à ANPD e a comunicação aos titulares para o caso 4, com base apenas em fatos verificados.
6. Avalie, com a lista do CISA #StopRansomware, a prontidão de um ambiente fictício e proponha as dez melhorias de maior impacto.

Use apenas ferramentas e simuladores de ransomware autorizados, em laboratório isolado, e jamais em ambientes de produção.

## 10. Normas e frameworks relevantes

- MITRE ATT&CK: T1486, T1490, T1489, T1078, T1133, T1003, T1021, T1567, T1562.001, T1484.001
- NIST SP 800-61 Rev. 3; NIST SP 800-184; NIST IR 8374
- CISA #StopRansomware Guide; ISO/IEC 27035
- LGPD, arts. 46, 48 e 52; Resolução CD/ANPD nº 15/2024

## 11. Referências

- The DFIR Report. Relatórios públicos de intrusões com ransomware.
- CISA; FBI. Avisos conjuntos #StopRansomware.
- Microsoft. Human-operated ransomware attacks: A preventable disaster.
- No More Ransom Project. Decifradores e orientações.
- NIST IR 8374. Ransomware Risk Management: A Cybersecurity Framework Profile. 2022.
- SANS Institute. FOR508 e SEC504.
