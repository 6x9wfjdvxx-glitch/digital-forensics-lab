# Fontes de Dados e Artefatos para Timeline

> **Objetivo pedagógico:** conhecer as fontes que alimentam uma linha do tempo, entender o que cada uma realmente registra, avaliar sua confiabilidade e escolher quais coletar conforme a pergunta investigativa.

## 1. Critérios para escolher fontes

| Critério | Pergunta |
|---|---|
| Relevância | A fonte responde a alguma pergunta investigativa? |
| Cobertura temporal | Abrange o período de interesse? |
| Confiabilidade | Pode ter sido alterada ou apagada com facilidade? |
| Resolução | Qual a precisão do carimbo (segundos, milissegundos)? |
| Independência | Está em um sistema diferente das demais fontes? |
| Volume | O volume é gerenciável e o custo de processamento é justificável? |

## 2. Sistema de arquivos

| Fonte | O que registra | Observações |
|---|---|---|
| `$MFT` (NTFS) | Metadados e 8 carimbos por arquivo; arquivos excluídos ainda não sobrescritos | Base de toda timeline em Windows |
| `$UsnJrnl:$J` | Registro de operações (criação, renomeação, exclusão, alteração) com motivo e horário | Útil para atividade recente; tem tamanho limitado e rotaciona |
| `$LogFile` | Transações recentes do NTFS | Janela curta; úteis para reconstrução fina |
| `$I30` | Índices de diretório, inclusive entradas em slack | Pode revelar nomes de arquivos excluídos |
| Journal do ext4 | Operações recentes do sistema de arquivos | Depende do modo e da configuração |
| APFS | Metadados e snapshots | Snapshots preservam estados anteriores |
| Lixeira | Data e caminho original da exclusão | Arquivos `$I` e `$R` no Windows |

## 3. Windows: execução, usuário e sistema

| Fonte | O que registra | Cuidados |
|---|---|---|
| Prefetch | Execução de aplicativos, contagem e até 8 horários recentes (versões modernas) | Pode estar desabilitado em servidores e SSDs configurados assim |
| Amcache.hve | Metadados de execução e instalação, com hash de binários | O horário de gravação da chave não equivale sempre ao da execução |
| ShimCache (AppCompatCache) | Existência e data de modificação de arquivos executáveis | Em versões modernas, não prova execução |
| UserAssist | Programas executados pelo usuário via interface, contagem e último horário | Codificado em ROT13 |
| BAM e DAM | Último horário de execução por usuário e programa | Windows 10 e posteriores |
| SRUM | Uso de recursos por aplicativo, rede e energia, em intervalos | Mostra quando e quanto um programa foi usado |
| Jump Lists, LNK e ShellBags | Acesso a arquivos e pastas por usuário | Evidenciam acesso, inclusive a mídias removíveis |
| Registro (chaves e `LastWrite`) | Persistência, dispositivos USB, redes, serviços | O horário é o da última gravação da chave |
| Event Logs (EVTX) | Autenticação, serviços, tarefas agendadas, PowerShell, criação de processos | Depende da política de auditoria |
| Volume Shadow Copies | Estados anteriores do sistema | Úteis para comparar antes e depois |
| Navegadores | Histórico, downloads, cache, cookies | Horários em WebKit ou PRTime |

Eventos frequentes do Windows:

| Evento | Significado |
|---|---|
| Security 4624 e 4625 | Logon bem-sucedido e falho (observe o tipo de logon) |
| Security 4688 | Criação de processo (linha de comando exige auditoria específica) |
| Security 4698 | Criação de tarefa agendada |
| Security 4720 e 4732 | Criação de conta e inclusão em grupo |
| System 7045 | Instalação de serviço |
| Security 1102 e System 104 | Limpeza dos logs |
| Microsoft-Windows-PowerShell/Operational 4104 | Bloco de script PowerShell |

## 4. Linux e macOS

| Fonte | O que registra |
|---|---|
| `/var/log/auth.log` ou `secure` | Autenticações, `sudo` e `ssh` |
| journald (`journalctl`) | Logs de serviços e do sistema, com horário monotônico e de relógio |
| `wtmp`, `btmp` e `lastlog` | Sessões, tentativas falhas e último login |
| Histórico do shell | Comandos, com horário apenas se `HISTTIMEFORMAT` estiver configurado |
| Cron e systemd timers | Persistência e execuções agendadas |
| Listas de pacotes (dpkg, apt, rpm) | Instalações e atualizações |
| macOS: FSEvents | Alterações de arquivos |
| macOS: Unified Logging e KnowledgeC | Atividade do sistema e dos aplicativos |
| macOS: Quarantine Events | Origem e horário de downloads |

## 5. Rede, identidade e nuvem

| Fonte | O que registra | Observações |
|---|---|---|
| Proxy e filtro web | Acessos HTTP e HTTPS por usuário | Podem estar em horário local ou epoch |
| DNS | Consultas e respostas | Útil para C2 e exfiltração |
| Firewall e NetFlow | Conexões, volumes e portas | Resolução e retenção variáveis |
| VPN e acesso remoto | Sessões e origem | Ligue ao usuário e ao dispositivo |
| Active Directory e Entra ID | Autenticações, mudanças de papéis e de conta | Logs de entrada em UTC |
| M365 Unified Audit Log | Atividades em e-mail, arquivos e administração | Horário em UTC; retenção conforme licenciamento |
| AWS CloudTrail, Azure Activity Log e GCP Audit Logs | Chamadas de API e mudanças de configuração | Horários em UTC |
| EDR | Criação de processos, conexões, arquivos e alertas | Fonte rica; verificar a retenção |
| E-mail | Cabeçalhos, rotas e horários de envio e recebimento | Horário do remetente e do servidor |

## 6. Memória e outras fontes

| Fonte | Valor |
|---|---|
| Memória | Horário de criação de processos, conexões ativas, módulos carregados |
| Hibernação e paginação | Fragmentos de estados anteriores |
| Aplicativos de mensagens | Horários de mensagens e de acessos |
| Mobile (SQLite) | Chamadas, mensagens, localização e uso de aplicativos |
| Dispositivos IoT e câmeras | Eventos e registros com relógios próprios |

## 7. Classificação da confiança

| Nível | Tipo de fonte | Uso |
|---|---|---|
| Alto | Logs centralizados e em sistemas independentes (SIEM, nuvem, proxy), com relógios sincronizados | Âncora da linha do tempo |
| Médio | Artefatos do sistema de arquivos e do registro, que o usuário privilegiado pode alterar com esforço | Reconstrução principal, com corroboração |
| Baixo | Dados locais facilmente editáveis (histórico de shell sem timestamp, arquivos de texto, carimbos editáveis) | Indício que exige confirmação |

## 8. Exemplo prático: pergunta e fontes

**Pergunta:** o colaborador copiou o repositório de projetos para um pen drive antes do desligamento?

| Fonte | Evidência esperada |
|---|---|
| Registro (USBSTOR e MountedDevices) e `setupapi.dev.log` | Primeira e última conexão do dispositivo |
| LNK e Jump Lists | Arquivos abertos a partir da unidade removível |
| `$UsnJrnl` e `$MFT` | Operações de criação e cópia de muitos arquivos no período |
| DLP e EDR | Eventos de gravação em mídia removível |
| Logs de autenticação | Sessão do usuário no período |
| Logs de proxy | Possíveis envios paralelos à nuvem pessoal |

## 9. Casos de uso corporativos

- Seleção das fontes mínimas para uma investigação de acesso indevido.
- Priorização de logs de retenção curta no início do incidente.
- Mapeamento das fontes disponíveis e das lacunas de registro (gaps de logging) após um incidente.

## 10. Normas e frameworks relevantes

- NIST SP 800-92 (gestão de logs) e NIST SP 800-86
- ISO/IEC 27002:2022, controles 8.15 (registro de eventos) e 8.17 (sincronização de relógios)
- CIS Controls v8.1, controle 8 (gestão de logs de auditoria)
- MITRE ATT&CK: Data Sources

## 11. Referências

- Carvey, H. Windows Forensic Analysis Toolkit. 4. ed. Syngress, 2014.
- Carrier, B. File System Forensic Analysis. Addison-Wesley, 2005.
- Altheide, C.; Carvey, H. Digital Forensics with Open Source Tools. Syngress, 2011.
- Kent, K.; Souppaya, M. NIST SP 800-92: Guide to Computer Security Log Management. 2006.
- SANS Institute. FOR500 e FOR508.
- Microsoft Learn. Documentação dos eventos de auditoria de segurança do Windows.
