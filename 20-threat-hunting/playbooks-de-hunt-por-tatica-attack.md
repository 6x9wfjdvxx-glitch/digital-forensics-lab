# Playbooks de Hunt por Tática ATT&CK

> **Objetivo pedagógico:** dispor de fichas de caça (hunt cards) defensivas e adaptáveis, organizadas por tática do MITRE ATT&CK, com hipótese, dados, consulta de exemplo, falsos positivos prováveis e critério de escalonamento, para acelerar o planejamento de caças e a criação de detecções.

> As consultas são exemplos ilustrativos: ajuste os nomes de tabelas, de campos e os limiares ao seu ambiente, valide-os em dados reais e documente as versões.

## 1. Como usar as fichas

Cada ficha contém: **hipótese**, **técnica ATT&CK**, **dados**, **consulta de exemplo**, **falsos positivos** e **escalonamento**. Antes de executar, verifique a telemetria (arquivo 3) e preencha o plano (arquivo 2). Ao final, converta o resultado em detecção ou em lacuna registrada (arquivo 6).

## 2. Execução

### 2.1 Aplicativos de escritório criando interpretadores

| Item | Conteúdo |
|---|---|
| Hipótese | Documentos maliciosos fazem aplicativos do Office executarem interpretadores de comandos |
| ATT&CK | T1204.002, T1059 |
| Dados | EDR ou Sysmon 1 (processo, pai e linha de comando) |
| Falsos positivos | Macros legítimas de automação em áreas específicas |
| Escalonamento | Linha de comando codificada ou com download, ou o mesmo padrão em vários hosts |

```kusto
DeviceProcessEvents
| where Timestamp > ago(30d)
| where InitiatingProcessFileName in~ ("winword.exe", "excel.exe", "powerpnt.exe", "outlook.exe")
| where FileName in~ ("cmd.exe", "powershell.exe", "wscript.exe", "cscript.exe", "mshta.exe", "rundll32.exe", "regsvr32.exe")
| project Timestamp, DeviceName, AccountName, InitiatingProcessFileName, FileName, ProcessCommandLine
| order by Timestamp desc
```

### 2.2 PowerShell com comandos codificados ou de download

| Item | Conteúdo |
|---|---|
| Hipótese | Adversários usam PowerShell codificado ou com download para executar cargas |
| ATT&CK | T1059.001, T1027, T1105 |
| Dados | EVTX 4104 e 4688, EDR |
| Falsos positivos | Scripts administrativos e de implantação |
| Escalonamento | Processo pai incomum, conexão de saída logo após a execução ou decodificação que revela download |

```spl
index=wineventlog EventCode=4688 (CommandLine="*-enc*" OR CommandLine="*-EncodedCommand*" OR CommandLine="*DownloadString*" OR CommandLine="*IEX*")
| stats count values(CommandLine) as comandos by Computer, SubjectUserName, ParentProcessName
| sort - count
```

## 3. Persistência

### 3.1 Serviços e tarefas agendadas novos

| Item | Conteúdo |
|---|---|
| Hipótese | Adversários criam serviços e tarefas para persistência |
| ATT&CK | T1543.003, T1053.005 |
| Dados | EVTX 4697, 7045 e 4698; Sysmon; EDR |
| Falsos positivos | Instalação de software e atualizações; tarefas de administração |
| Escalonamento | Executável em caminho de usuário ou temporário, conta incomum, host crítico ou execução imediata após a criação |

```kusto
// Serviços instalados com executáveis em caminhos incomuns
SecurityEvent
| where TimeGenerated > ago(30d) and EventID == 4697
| where ServiceFileName has_any ("\\Users\\", "\\ProgramData\\", "\\Temp\\", "\\AppData\\")
| project TimeGenerated, Computer, SubjectUserName, ServiceName, ServiceFileName

// Tarefas agendadas criadas, com o conteúdo da tarefa
SecurityEvent
| where TimeGenerated > ago(30d) and EventID == 4698
| project TimeGenerated, Computer, SubjectUserName, TaskName, TaskContent
```

### 3.2 Assinaturas permanentes de WMI

| Item | Conteúdo |
|---|---|
| Hipótese | Persistência sem arquivo por assinaturas de WMI |
| ATT&CK | T1546.003 |
| Dados | Sysmon 19, 20 e 21; EVTX Microsoft-Windows-WMI-Activity/Operational (5861) |
| Falsos positivos | Ferramentas de gestão e de monitoramento legítimas |
| Escalonamento | Consumidores de linha de comando ou de script, criados por contas não administrativas |

### 3.3 Linux: persistência

| Item | Conteúdo |
|---|---|
| Hipótese | Persistência por cron, systemd, `ld.so.preload`, chaves SSH ou SUID |
| ATT&CK | T1053.003, T1543.002, T1574.006, T1098.004, T1548.001 |
| Dados | auditd, osquery, coleta de arquivos |
| Falsos positivos | Administração e pacotes legítimos |
| Escalonamento | Arquivos recentes fora de pacotes, chaves de origem desconhecida ou bibliotecas pré-carregadas |

```bash
# Novos arquivos SUID e conteúdo de ld.so.preload
find / -xdev -type f -perm -4000 -mtime -14 -printf "%TY-%Tm-%Td %p\n" 2>/dev/null
cat /etc/ld.so.preload 2>/dev/null
# Unidades do systemd habilitadas e tarefas cron
systemctl list-unit-files --state=enabled --no-pager
ls -la /etc/cron.* /var/spool/cron 2>/dev/null
```

```sql
-- osquery: chaves SSH autorizadas por usuário
SELECT u.username, ak.key_file, ak.algorithm, ak.comment
FROM users u JOIN authorized_keys ak USING (uid);
```

## 4. Escalada de privilégios e evasão de defesas

### 4.1 Limpeza de logs e adulteração de ferramentas de segurança

| Item | Conteúdo |
|---|---|
| Hipótese | Adversários limpam logs ou desativam proteções |
| ATT&CK | T1070.001, T1562.001 |
| Dados | EVTX 1102 e 104; eventos de serviço; EDR (adulteração) |
| Falsos positivos | Manutenção autorizada |
| Escalonamento | Qualquer limpeza de log de segurança sem mudança aprovada; desativação de antivírus fora de manutenção |

```kusto
SecurityEvent
| where TimeGenerated > ago(30d) and EventID == 1102
| project TimeGenerated, Computer, SubjectUserName, SubjectDomainName
```

### 4.2 Comandos que impedem a recuperação

| Item | Conteúdo |
|---|---|
| Hipótese | Preparação de ransomware: exclusão de cópias de sombra e catálogos de backup |
| ATT&CK | T1490 |
| Dados | EDR, Sysmon 1, 4688 |
| Falsos positivos | Rotinas de manutenção de armazenamento (raras) |
| Escalonamento | Qualquer ocorrência fora de manutenção; tratar como incidente prioritário (pasta 16) |

```kusto
DeviceProcessEvents
| where Timestamp > ago(30d)
| where ProcessCommandLine has_any ("delete shadows", "shadowcopy delete", "delete catalog", "recoveryenabled no")
| project Timestamp, DeviceName, AccountName, InitiatingProcessFileName, ProcessCommandLine
```

## 5. Acesso a credenciais

### 5.1 Acesso ao LSASS

| Item | Conteúdo |
|---|---|
| Hipótese | Extração de credenciais da memória do LSASS |
| ATT&CK | T1003.001 |
| Dados | Sysmon 10 (acesso a processo) e EDR |
| Falsos positivos | Antivírus, EDR e ferramentas de gestão |
| Escalonamento | Processo de origem fora da lista de permissão, com máscaras de acesso amplas |

```spl
index=sysmon EventCode=10 TargetImage="*\\lsass.exe" NOT SourceImage IN ("*\\wininit.exe","*\\csrss.exe","*\\MsMpEng.exe","*\\svchost.exe")
| stats count values(GrantedAccess) as acessos by SourceImage, Computer, User
| sort - count
```

### 5.2 Kerberoasting

| Item | Conteúdo |
|---|---|
| Hipótese | Solicitação de tíquetes de serviço em volume para quebra offline |
| ATT&CK | T1558.003 |
| Dados | Evento 4769 nos controladores de domínio (tipo de criptografia e nome do serviço) |
| Falsos positivos | Sistemas legados que usam RC4; aplicações que consultam muitos serviços |
| Escalonamento | Muitas contas de serviço solicitadas por um único usuário em curto período, com RC4 |

```kusto
SecurityEvent
| where TimeGenerated > ago(7d) and EventID == 4769
| where TicketEncryptionType == "0x17" and ServiceName !endswith "$"
| summarize Servicos = dcount(ServiceName), Total = count() by TargetUserName, IpAddress, bin(TimeGenerated, 1h)
| where Servicos > 5
| order by Servicos desc
```

### 5.3 DCSync

| Item | Conteúdo |
|---|---|
| Hipótese | Replicação de credenciais por conta ou host que não é controlador de domínio |
| ATT&CK | T1003.006 |
| Dados | Evento 4662 com os GUIDs de replicação de diretório |
| Falsos positivos | Contas de sincronização legítimas (por exemplo, de identidade híbrida) |
| Escalonamento | Qualquer origem fora da lista de controladores e de contas de sincronização |

```kusto
SecurityEvent
| where TimeGenerated > ago(14d) and EventID == 4662
| where Properties has "1131f6aa-9c07-11d1-f79f-00c04fc2dcd2" or Properties has "1131f6ad-9c07-11d1-f79f-00c04fc2dcd2"
| where SubjectUserName !endswith "$"
| project TimeGenerated, Computer, SubjectUserName, SubjectDomainName
```

## 6. Movimentação lateral

| Ficha | Hipótese | Dados | Indícios |
|---|---|---|---|
| Compartilhamentos administrativos | Cópia de ferramentas por SMB para `ADMIN$` e `C$` | Zeek `smb_mapping.log`, EVTX 5140 e 5145 | Estação autenticando em muitos servidores por SMB; criação de serviço depois |
| RDP interno | Uso de RDP entre estações e servidores | EVTX 4624 tipo 10, 1149 e logs de rede | Contas privilegiadas e origens incomuns |
| Contas de serviço em logon interativo | Abuso de credenciais | 4624 tipos 2 e 10 por contas de serviço | Contas de serviço fora do papel |
| Execução remota por WMI e WinRM | Execução em outros hosts | Sysmon 1 (processo pai `wmiprvse.exe` ou `wsmprovhost.exe`), 4688 | Cadeias de comandos pós-conexão |

```kusto
// Contas de serviço com logon interativo ou RDP
SecurityEvent
| where TimeGenerated > ago(30d) and EventID == 4624 and LogonType in (2, 10)
| where TargetUserName startswith "svc_"
| summarize Eventos = count(), Hosts = dcount(Computer) by TargetUserName, LogonType
| order by Eventos desc
```

## 7. Comando e controle e exfiltração

| Ficha | Hipótese | Dados | Indícios |
|---|---|---|---|
| Beaconing | Conexões periódicas a um destino | Zeek, proxy, NetFlow | Intervalos regulares e destino raro (pastas 11 e 13) |
| Túnel DNS | Consultas com rótulos longos e alto volume por domínio | DNS | Entropia e volume (pasta 11) |
| Ferramentas de acesso remoto | Instalação de ferramentas legítimas para persistência | EDR, proxy | Executáveis fora do inventário aprovado e conexões a domínios de gestão remota |
| Exfiltração por volume | Upload anômalo a destinos externos | NetFlow, proxy, EDR | Assimetria de bytes e primeira ocorrência de destino |
| Ferramentas de sincronização de nuvem | Uso de Rclone e similares | EDR (linha de comando) | Arquivos de configuração e destinos de nuvem |

```kusto
// Volume de saída por host (NetFlow ou proxy normalizado): os 20 maiores nas últimas 24 horas
CommonSecurityLog
| where TimeGenerated > ago(1d) and DeviceAction != "Deny"
| summarize BytesEnviados = sum(SentBytes) by SourceIP, DestinationIP
| top 20 by BytesEnviados desc
```

## 8. Identidade e nuvem

| Ficha | Hipótese | Dados | Indícios |
|---|---|---|---|
| Novos consentimentos de aplicativos | Aplicativos maliciosos com permissões sensíveis | Auditoria do Entra ID (`Consent to application`) | Permissões `Mail.Read` e acesso offline; aplicativos recém-criados |
| Novas credenciais de entidades de serviço | Persistência por segredos | Auditoria do Entra ID | Segredos adicionados fora do processo |
| Chaves de acesso de nuvem criadas | Persistência na nuvem | CloudTrail (`CreateAccessKey`) e equivalentes | Criação por identidades incomuns |
| Instâncias em regiões incomuns | Abuso de recursos | CloudTrail e Activity Log | Tipos de GPU e regiões não usadas |
| Entradas com sessão em IPs diferentes | Roubo de tokens | Logs de entrada (interativas e não interativas) | Mesma sessão e mais de um IP |
| Regras de encaminhamento externo | Coleta de e-mail | Auditoria do Exchange | `New-InboxRule` e `Set-Mailbox` com encaminhamento |

```kusto
// Entra ID: consentimentos de aplicativos nos últimos 30 dias
AuditLogs
| where TimeGenerated > ago(30d) and OperationName in ("Consent to application", "Add delegated permission grant")
| project TimeGenerated, OperationName, InitiatedBy, TargetResources, Result
```

## 9. Prioridade e personalização

| Orientação | Descrição |
|---|---|
| Comece pelas técnicas mais frequentes em incidentes e com melhor telemetria | Execução, persistência, credenciais e movimentação lateral |
| Adapte listas de permissão e limiares | Cada ambiente tem administração própria |
| Combine fichas em cadeias | Por exemplo, acesso ao LSASS seguido de logons de rede e criação de serviço |
| Registre cada execução | Plano, consulta, resultado e decisão |
| Converta em detecção | Após reduzir falsos positivos (arquivo 6) |

## 10. Exemplo prático: execução de uma ficha

| Passo | Resultado |
|---|---|
| Ficha | 3.1 Serviços novos com executáveis em caminhos incomuns |
| Dados | 4697 em 98% dos servidores |
| Resultado | 7 serviços; 5 de instaladores legítimos (validados com a área); 2 apontando para `C:\ProgramData\svc\update.exe` em dois servidores |
| Pivô | O mesmo hash em uma estação; conexões a um domínio recente; conta de serviço usada em ambos |
| Decisão | Escalonamento à resposta a incidentes (pasta 16); detecção criada para serviços com executáveis em `ProgramData` e `Temp` |

## 11. Casos de uso corporativos

- Biblioteca de caças reutilizáveis por tática, com responsáveis e histórico de execuções.
- Validação periódica de cobertura de detecção por meio de caças.
- Treinamento de novos caçadores com fichas e dados de exercício.

## 12. Normas e frameworks relevantes

- MITRE ATT&CK: T1059, T1204, T1543, T1053, T1546.003, T1070, T1562, T1490, T1003, T1558.003, T1021, T1071, T1041, T1219, T1098
- OTRF. Threat Hunter Playbook; SigmaHQ (regras de referência)
- NIST CSF 2.0; ISO/IEC 27002:2022, controle 8.16; CIS Controls v8.1, controles 8, 13 e 17

## 13. Referências

- OTRF. Threat Hunter Playbook e Security-Datasets. https://github.com/OTRF
- SigmaHQ. Sigma: Specification and Rules.
- Microsoft. Documentação do Microsoft Defender XDR (caça avançada) e do Sysmon.
- Splunk. Documentação do SPL.
- Pease, A. Threat Hunting with Elastic Stack. Packt, 2021.
- MITRE ATT&CK. https://attack.mitre.org
