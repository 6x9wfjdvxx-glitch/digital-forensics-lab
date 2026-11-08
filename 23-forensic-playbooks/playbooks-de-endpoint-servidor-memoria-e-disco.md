# Playbooks de Endpoint, Servidor, Memória e Disco

> **Objetivo pedagógico:** executar os playbooks técnicos de sistemas: host Windows comprometido (PB-10), servidor Linux comprometido (PB-11), aquisição e triagem de memória (PB-12), aquisição de disco (PB-13), suspeita de cópia indevida de dados por colaborador (PB-14) e construção da linha do tempo (PB-15), com ordem de volatilidade, portões legais e registros.

> Comandos e ferramentas são exemplos: valide versões e parâmetros no seu ambiente e registre-os.

## PB-10: Host Windows comprometido (triagem e aquisição)

| Campo | Conteúdo |
|---|---|
| Gatilho | Alerta de EDR, indício de malware, acesso indevido ou determinação do líder |
| Objetivo | Preservar evidências em ordem de volatilidade e determinar o que ocorreu no host |
| Papéis | Executor: analista forense. Aprovador: líder. Consultado: dono do sistema |
| Pré-requisitos | Autorização; PB-00, PB-01 e PB-02 executados; mídia de coleta confiável |

**Passos**

1. Registrar a hora do sistema, o fuso e o estado (usuário logado, tela e conexões); fotografar.
2. Isolar a rede, conforme PB-02.
3. **Capturar a memória** (PB-12) antes de qualquer outra ação que altere o estado.
4. Coletar o estado volátil mínimo (processos, conexões, sessões) com ferramentas de mídia confiável; salvar em mídia externa; hash.
5. Coletar o pacote de triagem (logs de eventos, Registro, Prefetch, Amcache, MFT e USN, tarefas, serviços, histórico de navegadores).
6. **Decisão:** a aquisição completa do disco é necessária? (gravidade, escopo e criptografia) Se sim, PB-13.
7. Verificar a persistência (execução automática, serviços, tarefas, WMI) e as credenciais expostas.
8. Construir a linha do tempo (PB-15) e identificar o acesso inicial e a movimentação.
9. Extrair indicadores e transferir à caça e à detecção (PB-03 e pasta 20).
10. **Decisão:** reconstruir o host (preferível em comprometimento profundo) ou limpar; registrar a decisão.
11. Atualizar a custódia (PB-04) e o livro de decisões.

```powershell
# Estado volátil mínimo (execute de mídia confiável; registre cada comando; salve em mídia externa)
Get-Date -Format o; [System.TimeZoneInfo]::Local.Id
Get-CimInstance Win32_Process | Select-Object ProcessId,ParentProcessId,Name,CommandLine |
  Export-Csv E:\coleta\processos.csv -NoTypeInformation
Get-NetTCPConnection | Select-Object LocalAddress,LocalPort,RemoteAddress,RemotePort,State,OwningProcess |
  Export-Csv E:\coleta\conexoes.csv -NoTypeInformation
wevtutil epl Security E:\coleta\Security.evtx
wevtutil epl "Microsoft-Windows-PowerShell/Operational" E:\coleta\PowerShell.evtx

# Pacote de triagem (KAPE; licenciamento conforme o uso)
kape.exe --tsource C: --tdest E:\coleta\kape --target !SANS_Triage
```

| Evidências e saídas | Descrição |
|---|---|
| Memória, volátil, triagem e (se necessário) imagem | Com hashes e custódia |
| Linha do tempo e achados | Referência para o relatório |
| Indicadores | Para bloqueio e caça |

**Escalonamento:** indícios de domínio comprometido, de exfiltração ou de ransomware: acionar a resposta a incidentes (playbooks de ransomware e de identidade).
**Referências:** pastas 05, 07, 09, 10 e 15.

## PB-11: Servidor Linux comprometido

| Campo | Conteúdo |
|---|---|
| Gatilho | Alerta, suspeita de webshell, acesso SSH indevido ou mineração |
| Objetivo | Preservar o estado e determinar acesso inicial, persistência e impacto |
| Papéis | Executor: analista forense. Aprovador: líder. Consultado: administrador do servidor |
| Pré-requisitos | Autorização, acesso com conta de investigação e mídia ou repositório de evidências |

**Passos**

1. Registrar a hora (UTC), o fuso, o tipo de sistema (físico, VM, nuvem ou contêiner) e o estado.
2. Isolar a rede (PB-02); em nuvem, aplicar também o PB-30 para as credenciais.
3. Capturar a memória, quando viável (AVML ou LiME), com hash (PB-12).
4. Coletar o estado volátil: processos, conexões, usuários e sessões.
5. Coletar logs (`/var/log`, `journald`, `auth.log`, `audit`) e artefatos de persistência (cron, systemd, chaves SSH, `ld.so.preload`, arquivos SUID recentes).
6. Para VMs e nuvem, criar snapshots dos discos (ver PB-30 e pasta 17); para físicos, imagem de disco (PB-13).
7. Verificar o acesso inicial (logs de autenticação, serviços expostos e aplicações web) e a movimentação.
8. Extrair indicadores e procurar nos demais servidores.
9. **Decisão:** reconstruir o servidor a partir de imagem confiável; rotacionar credenciais e segredos presentes.
10. Atualizar a custódia e o livro de decisões.

```bash
# Estado volátil e logs (execute com cuidado, a partir de ferramentas confiáveis; salve em armazenamento externo)
date -u; uname -a; uptime
ps auxwwf; ss -tunap; lsof -nP -i
who; last -a | head -50
journalctl --no-pager -o short-iso-precise > /mnt/evid/journal.txt
tar -czf /mnt/evid/var_log_$(hostname).tgz /var/log
sha256sum /mnt/evid/* > /mnt/evid/hashes.sha256
```

**Referências:** pastas 08, 09, 10, 15 e 17.

## PB-12: Aquisição e triagem de memória

| Campo | Conteúdo |
|---|---|
| Gatilho | Decisão do PB-02 ou do líder de capturar a memória |
| Objetivo | Obter a memória de forma íntegra e extrair rapidamente o que orienta a investigação |
| Papéis | Executor: analista de memória |
| Pré-requisitos | Ferramenta de aquisição validada, mídia de destino com espaço suficiente e autorização |

**Passos**

1. Escolher a ferramenta conforme o sistema (por exemplo, WinPmem para Windows e AVML ou LiME para Linux) e registrar a versão.
2. Gravar a saída em mídia **externa**, e não no disco do sistema examinado.
3. Executar a aquisição; registrar o horário (UTC), o comando e eventuais erros.
4. Calcular o hash do arquivo de memória; registrar na custódia.
5. Em ambiente de análise, trabalhar sobre **cópia**.
6. Triagem inicial (Volatility 3): processos, linhas de comando, conexões e regiões injetadas.
7. Extrair indicadores (processos, IPs, domínios e arquivos) e registrar os achados.
8. Informar o líder sobre os resultados que alteram a estratégia (por exemplo, credenciais expostas).

```bash
# Hash da memória adquirida
sha256sum memoria_DFL-2026-001-E010.raw > memoria_DFL-2026-001-E010.raw.sha256

# Triagem inicial com Volatility 3 (execute sobre a cópia de trabalho)
vol -f memoria_trabalho.raw windows.pslist.PsList  > pslist.txt
vol -f memoria_trabalho.raw windows.cmdline.CmdLine > cmdline.txt
vol -f memoria_trabalho.raw windows.netscan.NetScan > netscan.txt
vol -f memoria_trabalho.raw windows.malfind.Malfind > malfind.txt
```

**Referências:** pasta 09.

## PB-13: Aquisição de disco

| Campo | Conteúdo |
|---|---|
| Gatilho | Decisão de adquirir imagem de disco (PB-10, PB-11 ou PB-14) |
| Objetivo | Produzir cópia forense íntegra, verificada e documentada |
| Papéis | Executor: analista forense |
| Pré-requisitos | Bloqueador de escrita (para discos removidos), mídia de destino, ferramenta validada e autorização |

**Passos**

1. Identificar o disco (fabricante, modelo, série e capacidade); fotografar; registrar na custódia.
2. Conectar por **bloqueador de escrita** (hardware ou software validado) ou realizar a aquisição ao vivo conforme PB-02.
3. Verificar o destino (espaço e sistema de arquivos) e preparar a mídia de destino limpa.
4. Adquirir a imagem em formato forense (por exemplo, E01) com a verificação por hash.
5. Verificar a imagem; comparar com o hash de aquisição; registrar.
6. Criar uma cópia de trabalho; preservar o original.
7. Registrar o horário, a ferramenta, a versão, os parâmetros, as divergências e os setores com erro.
8. Atualizar a custódia (PB-04).

```bash
# Aquisição em formato E01 com verificação (libewf); ajuste dispositivo e metadados
sudo ewfacquire -t /mnt/evid/DFL-2026-001-E011 -C DFL-2026-001 -D "Disco do notebook X" -e "Analista Exemplo" -N "Serie ABC" -c best -f encase6 -S 4GiB -u /dev/sdb
ewfverify /mnt/evid/DFL-2026-001-E011.E01
```

**Referências:** pastas 03, 04 e 10.

## PB-14: Suspeita de cópia indevida de dados por colaborador

| Campo | Conteúdo |
|---|---|
| Gatilho | Alerta de DLP, denúncia, desligamento com risco ou indício de vazamento |
| Objetivo | Estabelecer, com proporcionalidade, se houve cópia de dados e por quais meios |
| Papéis | Executor: analista forense. Aprovadores: Jurídico, RH e DPO. Informado: líder |
| Pré-requisitos | Autorização formal, política de uso aceitável comunicada e escopo definido |

**Passos**

1. **Portão legal:** obter a autorização do Jurídico, do RH e do DPO; definir escopo (pessoa, período, sistemas e tipos de dados). Sem autorização, parar.
2. Preservar (PB-01): logs de DLP, de proxy, de e-mail, de nuvem corporativa e de autenticação.
3. Preservar o equipamento corporativo (PB-02, PB-12 e PB-13), com conta e dados pessoais tratados com minimização.
4. Analisar os artefatos de **dispositivos removíveis** (conexões USB e arquivos acessados), de **nuvem e transferências** (sincronização, uploads e histórico de navegação), de **e-mail** (anexos e encaminhamentos) e de **acesso a arquivos** (listas de arquivos recentes e logs do servidor).
5. Correlacionar com os logs corporativos (auditoria do SharePoint e do OneDrive, proxy e DLP) e construir a linha do tempo (PB-15).
6. Avaliar hipóteses alternativas legítimas (tarefas de trabalho, backups e sincronização autorizada).
7. Classificar os dados envolvidos (confidenciais, pessoais e sigilosos) para decisões e notificações.
8. Relatar fatos, com confiança e limitações, **sem** concluir intenção ou culpa; entregar ao Jurídico e ao RH.
9. Evitar a devassa em conteúdo pessoal do colaborador (mensagens e arquivos privados), salvo autorização específica.

**Referências:** pastas 06, 07, 11, 12, 19 e 22.

## PB-15: Construção da linha do tempo (super timeline)

| Campo | Conteúdo |
|---|---|
| Gatilho | Necessidade de reconstruir a sequência de eventos |
| Objetivo | Produzir linha do tempo confiável, normalizada em UTC e corroborada |
| Papéis | Executor: analista forense |
| Pré-requisitos | Imagens ou coletas verificadas, logs exportados e ferramenta de linha do tempo |

**Passos**

1. Listar as fontes (imagens, logs, nuvem, rede e e-mail) e o fuso de cada uma.
2. Determinar o desvio de relógio de cada fonte por eventos-âncora; registrar a margem de erro.
3. Processar as fontes (por exemplo, com o Plaso) e converter para UTC.
4. Filtrar por janela de tempo e por entidades de interesse (contas, hosts e arquivos); evitar excesso de ruído.
5. Identificar os marcos (acesso inicial, execução, persistência, movimentação e exfiltração).
6. Corroborar cada marco com uma segunda fonte independente.
7. Declarar lacunas, incertezas e possibilidade de adulteração de tempo.
8. Exportar a linha do tempo e registrar consultas e filtros (anexo do relatório).

```bash
# Linha do tempo com Plaso (exemplo; ajuste fonte e parâmetros)
log2timeline.py --storage-file linha_DFL-2026-001.plaso /mnt/evid/DFL-2026-001-E011.E01
psort.py -o dynamic -w linha_DFL-2026-001.csv linha_DFL-2026-001.plaso
sha256sum linha_DFL-2026-001.plaso linha_DFL-2026-001.csv > linha_hashes.sha256
```

**Referências:** pasta 05.

## Resumo dos playbooks deste arquivo

| ID | Playbook | Quando usar |
|---|---|---|
| PB-10 | Host Windows comprometido | Estações e servidores Windows |
| PB-11 | Servidor Linux comprometido | Servidores Linux, físicos, virtuais e em nuvem |
| PB-12 | Memória | Antes de desligar ou alterar sistemas relevantes |
| PB-13 | Disco | Quando a aquisição completa se justifica |
| PB-14 | Cópia indevida por colaborador | Suspeitas de vazamento interno, com autorização |
| PB-15 | Linha do tempo | Reconstrução de eventos |

## Exemplo prático: servidor Windows com suspeita de DCSync

| Etapa | Ação |
|---|---|
| PB-10 | Isolar o servidor de aplicação, capturar memória (PB-12) e coletar o pacote de triagem |
| Achado | Acesso ao LSASS e execução de ferramenta desconhecida em `ProgramData` |
| PB-15 | Linha do tempo mostra criação do serviço 6 horas antes do DCSync no controlador de domínio |
| Escalonamento | Acionado o playbook de identidade (PB-31) e o de ransomware (PB-25), por indício de domínio comprometido |

## Casos de uso corporativos

- Resposta padronizada a hosts comprometidos por plantões de SOC e de DFIR.
- Investigações internas de cópia de dados com governança e proporcionalidade.
- Treinamento prático com laboratórios baseados nos playbooks.

## Normas e frameworks relevantes

- ISO/IEC 27037; ISO/IEC 27041, 27042 e 27043; NIST SP 800-86; NIST SP 800-61 Rev. 3
- MITRE ATT&CK (técnicas de acesso a credenciais, de persistência e de exfiltração)
- CIS Controls v8.1, controles 8, 10, 13 e 17
- LGPD, arts. 6º, 7º e 46

## Referências

- Pastas 05, 07, 08, 09, 10, 15 e 16 deste repositório.
- Documentação do KAPE, do Plaso, do libewf, do Volatility 3, do WinPmem e do AVML.
