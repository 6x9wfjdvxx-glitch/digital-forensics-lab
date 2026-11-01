# Registro do Windows e Configurações

> **Objetivo pedagógico:** analisar o Registro do Windows para identificar a configuração do sistema, as contas, os dispositivos, a atividade do usuário e a persistência, interpretando corretamente os horários de última gravação e tratando os logs de transação.

## 1. Estrutura

| Hive | Local do arquivo | Conteúdo principal |
|---|---|---|
| SYSTEM | `C:\Windows\System32\config\SYSTEM` | Serviços, dispositivos, fuso, nome do computador, ShimCache, BAM |
| SOFTWARE | `...\config\SOFTWARE` | Software instalado, versão do SO, perfis de rede, tarefas (TaskCache) |
| SAM | `...\config\SAM` | Contas locais e atributos (último logon, contagem) |
| SECURITY | `...\config\SECURITY` | Políticas e segredos de segurança |
| DEFAULT | `...\config\DEFAULT` | Perfil padrão |
| NTUSER.DAT | `C:\Users\<usuário>\NTUSER.DAT` | HKCU: atividade do usuário |
| UsrClass.dat | `...\AppData\Local\Microsoft\Windows\UsrClass.dat` | ShellBags e classes |
| Amcache.hve | `C:\Windows\appcompat\Programs\Amcache.hve` | Inventário de aplicativos |

Cada hive possui arquivos de transação (`.LOG1` e `.LOG2`). Se o sistema foi coletado ao vivo ou desligado de forma inesperada, o hive pode estar "sujo" (alterações não consolidadas): reaplique os logs de transação ao analisar (o Registry Explorer oferece essa função).

## 2. Interpretação do horário `LastWrite`

Cada chave possui um carimbo de última gravação (`LastWrite`). Ele indica a última alteração na própria chave (criação ou modificação de valores ou subchaves), e não necessariamente o evento que o analista procura (por exemplo, a execução de um programa). Valores individuais não possuem carimbo próprio.

## 3. Configuração do sistema

| Informação | Chave | Observação |
|---|---|---|
| Versão e data de instalação | `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion` (`ProductName`, `CurrentBuild`, `InstallDate`) | `InstallDate` em época Unix |
| Nome do computador | `HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName` | |
| Fuso horário | `HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation` | Define a interpretação de horários locais |
| ControlSet em uso | `HKLM\SYSTEM\Select` (`Current`, `Default`, `LastKnownGood`) | `CurrentControlSet` é um atalho para o ControlSet ativo |
| Último desligamento | `HKLM\SYSTEM\CurrentControlSet\Control\Windows` (`ShutdownTime`) | FILETIME |
| Perfis de usuário | `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList` | SID e caminho do perfil |
| Redes conhecidas | `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Profiles` e `Signatures` | Nome da rede, primeiro e último acesso |
| Software instalado | `HKLM\SOFTWARE\...\Uninstall` e `WOW6432Node` | Também em `HKCU` |

## 4. Contas locais (SAM)

O hive SAM guarda, por conta (RID), a data do último logon, da última troca de senha, do último logon com falha, a contagem de logons e o grupo. Use RegRipper ou Registry Explorer com o plugin SAM. Estes dados complementam, mas não substituem, os eventos 4624 e 4625.

## 5. Dispositivos USB

| Fonte | Local | Informação |
|---|---|---|
| USBSTOR | `HKLM\SYSTEM\CurrentControlSet\Enum\USBSTOR\<Ven_Prod>\<serial>` | Fabricante, produto e serial; propriedades com horários de instalação, conexão e remoção (confirme com ferramenta) |
| USB | `HKLM\SYSTEM\CurrentControlSet\Enum\USB\VID_xxxx&PID_xxxx` | VID e PID |
| MountedDevices | `HKLM\SYSTEM\MountedDevices` | Associação de volumes a letras e a dispositivos |
| Portable Devices | `HKLM\SOFTWARE\Microsoft\Windows Portable Devices\Devices` | Nome amigável do dispositivo |
| MountPoints2 | `NTUSER.DAT\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2` | Indica o usuário que acessou o volume |
| `setupapi.dev.log` | `C:\Windows\INF\setupapi.dev.log` | Data e hora da primeira instalação do dispositivo |

Correlacione também com os arquivos LNK e Jump Lists que apontam para a unidade removível e com os eventos de driver.

## 6. Atividade do usuário (NTUSER.DAT e UsrClass.dat)

| Artefato | Chave | Valor forense |
|---|---|---|
| RecentDocs | `...\Explorer\RecentDocs` | Arquivos recentes por extensão |
| OpenSavePidlMRU | `...\Explorer\ComDlg32\OpenSavePidlMRU` | Arquivos abertos e salvos em diálogos |
| LastVisitedPidlMRU | `...\ComDlg32\LastVisitedPidlMRU` | Aplicativo e pasta utilizados |
| TypedPaths | `...\Explorer\TypedPaths` | Caminhos digitados no Explorer |
| WordWheelQuery | `...\Explorer\WordWheelQuery` | Termos pesquisados no Explorer |
| RunMRU | `...\Explorer\RunMRU` | Comandos digitados em "Executar" |
| UserAssist | `...\Explorer\UserAssist\{GUID}\Count` | Programas executados via interface; contagem e último horário (nomes em ROT13); GUIDs `{CEBFF5CD-ACE2-4F4F-9178-9926F41749EA}` e `{F4E57C4B-2036-45F0-A9AB-443BCFE33D9F}` |
| ShellBags | `UsrClass.dat\Local Settings\Software\Microsoft\Windows\Shell\BagMRU` e `Bags` | Pastas acessadas, inclusive em mídias removíveis e redes |
| Terminal Server Client | `NTUSER.DAT\Software\Microsoft\Terminal Server Client\Default` e `Servers` | Hosts RDP acessados e nome de usuário sugerido |
| Office MRU | `...\Office\<versão>\<aplicativo>\File MRU` | Documentos recentes do Office |

## 7. Execução (SYSTEM e SOFTWARE)

| Artefato | Chave | Observação |
|---|---|---|
| ShimCache (AppCompatCache) | `HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\AppCompatCache` | Existência e data de modificação do executável; em versões modernas não prova execução; gravado no registro no desligamento |
| BAM e DAM | `HKLM\SYSTEM\CurrentControlSet\Services\bam\State\UserSettings\<SID>` | Último horário de execução por usuário |
| Amcache | `Amcache.hve` (`InventoryApplicationFile` e outros) | Metadados e hash de binários; horário de gravação não equivale ao da execução |

Veja o arquivo de artefatos de execução para a interpretação e a correlação.

## 8. Persistência e serviços

| Mecanismo | Chave |
|---|---|
| Run e RunOnce | `HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run` e `RunOnce`; equivalente em `HKCU` |
| Winlogon | `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon` (`Shell`, `Userinit`) |
| Serviços | `HKLM\SYSTEM\CurrentControlSet\Services\<nome>` (`ImagePath`, `Start`, `Type`) |
| Image File Execution Options | `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options` (valor `Debugger`) |
| AppInit_DLLs | `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows` |
| Tarefas agendadas | `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks` e `Tree` |

## 9. Análise com ferramentas

```powershell
# Registry Explorer: interface gráfica com reaplicação de logs de transação e marcadores

# RECmd com arquivo de lote (batch) para extrair chaves de interesse em CSV
RECmd.exe -d E:\coleta\hives --bn BatchExamples\Kroll_Batch.reb --csv E:\saida --csvf registro.csv

# ShimCache
AppCompatCacheParser.exe -f E:\coleta\SYSTEM --csv E:\saida

# ShellBags
SBECmd.exe -d E:\coleta\usuario --csv E:\saida
```

```bash
# RegRipper (exemplo de uso: plugin de execução em NTUSER.DAT)
rip.pl -r NTUSER.DAT -p userassist
rip.pl -r SYSTEM -p usbstor
```

Confira os parâmetros e os nomes de plugins nas versões instaladas.

## 10. Exemplo prático: conexão de pen drive e arquivos abertos

| Etapa | Evidência |
|---|---|
| 1 | `USBSTOR` aponta um dispositivo com serial X e horários de conexão |
| 2 | `setupapi.dev.log` registra a primeira instalação do serial X em 2026-10-26T17:42Z |
| 3 | `MountPoints2` do usuário U referencia o volume do dispositivo |
| 4 | `ShellBags` e `OpenSavePidlMRU` mostram a pasta e arquivos acessados na unidade removível |
| 5 | LNK e Jump Lists confirmam arquivos abertos a partir da unidade |
| Conclusão | O usuário U conectou o dispositivo e acessou arquivos nele; a cópia do repositório exige a confirmação por `$UsnJrnl` e por logs de DLP |

## 11. Casos de uso corporativos

- Verificação de dispositivos USB utilizados por um colaborador.
- Inventário de redes e de RDPs utilizados por um usuário.
- Identificação de persistência em estações comprometidas.

## 12. Normas e frameworks relevantes

- MITRE ATT&CK: T1547.001 (Run Keys), T1546.012 (IFEO), T1546.010 (AppInit DLLs), T1547.004 (Winlogon), T1543.003 (Windows Service), T1052.001 (Exfiltration over USB)
- NIST SP 800-86; ISO/IEC 27037:2012

## 13. Referências

- Carvey, H. Windows Registry Forensics. 2. ed. Syngress, 2016.
- Carvey, H. Windows Forensic Analysis Toolkit. 4. ed. Syngress, 2014.
- Zimmerman, E. Documentação do Registry Explorer, RECmd, SBECmd e AppCompatCacheParser.
- RegRipper (Harlan Carvey): documentação.
- SANS Institute. FOR500.
- Microsoft Learn. Documentação do Registro do Windows.
