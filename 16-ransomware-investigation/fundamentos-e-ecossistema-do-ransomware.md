# Fundamentos e Ecossistema do Ransomware

> **Objetivo pedagógico:** compreender a evolução e o ecossistema do ransomware (afiliados, corretores de acesso e extorsão dupla), a anatomia de um ataque operado por humanos, o mapeamento ao MITRE ATT&CK e o enquadramento legal e de gestão de crise, para orientar a investigação, a resposta e a recuperação.

> **Escopo defensivo:** este material trata de investigação, resposta e recuperação. Não ensina a criar, aprimorar ou operar ransomware.

## 1. O que é e como evoluiu

| Fase | Característica |
|---|---|
| Ransomware de bloqueio e de criptografia em massa | Ataques oportunistas, com criptografia de arquivos do usuário e pedido de resgate |
| Ransomware operado por humanos (human-operated) | Invasores permanecem no ambiente por dias, escalam privilégios, comprometem o domínio e implantam a criptografia em larga escala |
| Extorsão dupla (a partir de cerca de 2019) | Além de criptografar, o grupo rouba dados e ameaça publicá-los |
| Extorsão tripla e ampliada | Pressão adicional por ataques de negação de serviço, contato com clientes, parceiros e imprensa |
| Extração sem criptografia | Apenas o roubo de dados e a extorsão, sem cifrar sistemas |

## 2. O ecossistema criminoso

| Papel | Função |
|---|---|
| Operadores de RaaS (Ransomware-as-a-Service) | Desenvolvem e mantêm o código, a infraestrutura de pagamento e o site de vazamentos; alugam o serviço |
| Afiliados | Conduzem as intrusões e a implantação; dividem o resgate com os operadores |
| Corretores de acesso inicial (IABs) | Vendem acessos a redes (VPN, RDP e credenciais) |
| Fornecedores de credenciais e de infostealers | Fornecem logs de credenciais roubadas |
| Lavadores e negociadores | Convertem o pagamento e conduzem as negociações |
| Sites de vazamento | Publicam dados de vítimas que não pagam |

Consequências para a investigação: o mesmo ransomware pode ser operado por afiliados com técnicas diferentes, e as famílias mudam de nome (rebranding) e compartilham código; a identificação do "grupo" não substitui a análise do que ocorreu **no seu ambiente**.

## 3. Anatomia de um ataque operado por humanos

```mermaid
flowchart LR
    A["Acesso inicial"] --> B["Execução e persistência"]
    B --> C["Escalada de privilégios e credenciais"]
    C --> D["Descoberta e movimentação lateral"]
    D --> E["Desativação de defesas e de backups"]
    E --> F["Coleta e exfiltração de dados"]
    F --> G["Implantação da criptografia"]
    G --> H["Extorsão e negociação"]
```

| Fase | O que costuma ocorrer | Técnicas ATT&CK |
|---|---|---|
| Acesso inicial | Phishing, VPN ou RDP expostos, exploração de equipamentos de borda, credenciais válidas, parceiros e provedores de TI | T1566, T1190, T1133, T1078, T1199 |
| Execução e persistência | Carregadores, ferramentas de acesso remoto, tarefas e serviços | T1059, T1053.005, T1543.003, T1219 |
| Credenciais | Dump do LSASS, Kerberoasting, DCSync e uso de contas privilegiadas | T1003, T1558.003 |
| Descoberta | Enumeração do Active Directory, de compartilhamentos e de servidores de backup | T1087, T1018, T1482, T1046 |
| Movimentação lateral | RDP, SMB, WMI, PsExec e tarefas remotas | T1021, T1047, T1569.002 |
| Evasão de defesas | Desativar antivírus e EDR, remover agentes, limpar logs | T1562.001, T1070.001 |
| Impedir a recuperação | Excluir cópias de sombra e catálogos de backup, atacar servidores de backup | T1490, T1485 |
| Coleta e exfiltração | Compactação e envio a armazenamento em nuvem ou a servidores do atacante | T1560, T1567, T1048 |
| Implantação | Distribuição por GPO, PsExec ou ferramentas de gestão; parada de serviços | T1484.001, T1489 |
| Impacto | Criptografia, nota de resgate e alteração de fundo de tela | T1486, T1491.001 |

Relatórios do setor indicam que o tempo entre o acesso inicial e a criptografia caiu para poucos dias, com casos de horas. Por isso a detecção nas fases anteriores à criptografia é decisiva.

## 4. Impactos

| Categoria | Exemplos |
|---|---|
| Operacional | Paralisação de sistemas, linhas de produção, atendimento e logística |
| Financeiro | Perdas de receita, custos de resposta e de recuperação, resgate, multas |
| Dados | Perda de dados sem backup e vazamento de dados pessoais e sigilosos |
| Legal e regulatório | Notificações, sanções e litígios |
| Reputação e confiança | Clientes, parceiros e mercado |
| Saúde e segurança | Hospitais e infraestruturas críticas: risco à vida e à segurança |

## 5. Enquadramento legal e regulatório (Brasil e referências)

> **Aviso:** este material é técnico-educacional e não substitui parecer jurídico. Valide cada caso com o Jurídico e com o DPO.

| Tema | Orientação |
|---|---|
| LGPD | O incidente que possa acarretar risco ou dano relevante aos titulares exige comunicação à ANPD e aos titulares (art. 48); medidas de segurança (art. 46); sanções (art. 52) |
| Regulamento de comunicação de incidentes | A Resolução CD/ANPD nº 15/2024 disciplina a comunicação, com prazo de 3 dias úteis a partir do conhecimento do incidente de risco relevante; confirme a redação vigente |
| Setores regulados | Instituições financeiras e de pagamento (Resoluções CMN nº 4.893/2021 e BCB nº 85/2021), seguros, saúde e infraestruturas críticas têm obrigações próprias de comunicação e de gestão; confirme a vigência |
| Direito penal | Condutas como extorsão (CP, art. 158), invasão de dispositivo informático (art. 154-A) e dano (art. 163), conforme o caso |
| Pagamento de resgate | Envolve riscos de sanções, de lavagem de dinheiro e de financiamento de atividades ilícitas; deve ser uma decisão da alta direção, com o Jurídico e consultoria especializada |
| Referências internacionais | GDPR (notificação em 72 horas, art. 33); SEC dos EUA (Formulário 8-K, item 1.05, para companhias abertas, em 4 dias úteis após a determinação de materialidade); alertas de sanções do OFAC sobre pagamentos de resgate |
| Contratos e seguros | Cláusulas de notificação a clientes e parceiros; condições da apólice de seguro cibernético (notificação imediata e uso de fornecedores indicados) |

## 6. Gestão de crise: princípios

| Princípio | Aplicação |
|---|---|
| Comando único | Um líder do incidente, com autoridade, e um canal de decisão registrado |
| Comunicação fora de banda | Presumir que e-mail, mensageria e diretório podem estar comprometidos; usar canais alternativos |
| Preservação de privilégio | Envolver o Jurídico (e, quando adequado, assessoria externa) para conduzir a investigação sob orientação jurídica |
| Registro de decisões | Decisões, justificativas, responsáveis e horários |
| Prioridade das pessoas e da segurança | Saúde, segurança e continuidade de serviços críticos |
| Evidências e recuperação em paralelo | Preservar o necessário sem atrasar excessivamente a recuperação |
| Transparência calibrada | Informações corretas, no tempo certo, ao público certo |

## 7. Fontes de orientação reconhecidas

| Fonte | Uso |
|---|---|
| CISA #StopRansomware Guide | Lista de verificação de prevenção e resposta |
| NIST IR 8374 (Ransomware Risk Management: A Cybersecurity Framework Profile) | Perfil do NIST CSF para ransomware |
| NIST SP 800-61 Rev. 3 e NIST SP 800-184 | Resposta a incidentes e recuperação de eventos |
| NIST CSF 2.0 | Funções Governar, Identificar, Proteger, Detectar, Responder e Recuperar |
| CERT.br e CTIR Gov | Coordenação e orientação no Brasil |
| No More Ransom | Decifradores gratuitos disponíveis e orientações |
| Microsoft, CrowdStrike, Mandiant e outros | Relatórios de ameaças e orientações técnicas |

## 8. Exemplo prático: leitura de um relatório de incidente à luz da anatomia

| Fase observada | Evidência | Lição |
|---|---|---|
| Acesso inicial | Login por VPN sem MFA, com credencial de um colaborador, de IP incomum, 11 dias antes | A detecção do acesso teria dado 11 dias de vantagem |
| Credenciais | Acesso ao LSASS em um servidor e DCSync no controlador de domínio no 5º dia | Domínio comprometido bem antes da criptografia |
| Backups | Servidor de backup acessado e catálogos excluídos no 9º dia | Backups no domínio não são independentes |
| Exfiltração | 380 GB enviados a um armazenamento externo no 10º dia | Houve vazamento, e não apenas indisponibilidade |
| Impacto | Criptografia distribuída por GPO no 11º dia, de madrugada | Janelas de baixa atividade são típicas |

## 9. Casos de uso corporativos

- Elaboração do plano de resposta a ransomware e de exercícios de simulação (tabletop).
- Avaliação de risco de ransomware e de prontidão para recuperação.
- Comunicação ao conselho e à alta direção sobre riscos e decisões de crise.

## 10. Normas e frameworks relevantes

- NIST IR 8374; NIST SP 800-61 Rev. 3; NIST SP 800-184; NIST CSF 2.0
- CISA #StopRansomware Guide; MITRE ATT&CK (T1486, T1490, T1489, T1485, T1567, T1048, T1562.001)
- ISO/IEC 27035 (gestão de incidentes); ISO/IEC 27002:2022, controles 5.24 a 5.28, 5.29 e 5.30 (continuidade e prontidão de TIC) e 8.13 (backup)
- CIS Controls v8.1, controles 11 (recuperação de dados) e 17 (resposta a incidentes)
- LGPD, arts. 46, 48 e 52; Resolução CD/ANPD nº 15/2024

## 11. Referências

- CISA; MS-ISAC. #StopRansomware Guide.
- Nelson, R. et al. NIST IR 8374: Ransomware Risk Management: A Cybersecurity Framework Profile. 2022.
- Cichonski, P. et al. NIST SP 800-61; Bartock, M. et al. NIST SP 800-184: Guide for Cybersecurity Event Recovery. 2016.
- No More Ransom Project. https://www.nomoreransom.org
- Brasil. Lei nº 13.709/2018; Resolução CD/ANPD nº 15/2024; Código Penal.
- Microsoft. Human-operated ransomware attacks: A preventable disaster (orientações públicas).
- The DFIR Report. Relatórios públicos de intrusões com ransomware.
