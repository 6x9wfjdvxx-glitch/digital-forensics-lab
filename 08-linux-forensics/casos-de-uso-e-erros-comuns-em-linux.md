# Casos de Uso e Erros Comuns em Linux

> **Objetivo pedagógico:** consolidar o aprendizado de forense de Linux com cenários corporativos realistas, os erros mais frequentes, suas consequências e as medidas de prevenção.

Os casos são fictícios e destinados ao treinamento.

## 1. Caso 1: força bruta de SSH, persistência e minerador

**Pergunta:** como o servidor foi comprometido e o que o atacante fez?

| Hora (UTC) | Fonte | Achado |
|---|---|---|
| 02:11 a 02:14 | auth.log | 380 `Failed password` de um IP externo |
| 02:14:20 | auth.log e wtmp | `Accepted password for deploy` da mesma origem |
| 02:15:10 | auth.log | `sudo` com `/bin/bash` |
| 02:16:30 | auditd | `curl` baixando binário para `/tmp/.x` e `chmod +x` |
| 02:17:00 | Cron | Nova linha no crontab do root baixando script a cada 5 minutos |
| 02:18:00 | auditd | `systemctl enable` de serviço `syshelper` |
| Após 02:20 | Rede e métricas | Conexões a pool de mineração; CPU elevada |

**Conclusão:** acesso por força bruta com credencial fraca, elevação por `sudo`, persistência redundante e mineração (T1110, T1078, T1548.003, T1053.003, T1543.002 e T1496); confiança alta.
**Lição:** restrinja o acesso por senha ao SSH, use chaves e monitore falhas em série.

## 2. Caso 2: web shell em servidor web

**Pergunta:** como o atacante executa comandos no servidor?

| Fonte | Achado |
|---|---|
| Sistema de arquivos | Arquivo `uploads/img.php` criado em 2026-10-27T21:02Z, sem relação com o código-fonte |
| Logs do Nginx | Requisição POST de upload às 21:02Z, seguida de POSTs ao mesmo arquivo com parâmetros codificados |
| auditd e processos | `www-data` executando `/bin/sh`, `whoami`, `id` e `wget` |
| Conexões | Conexão de saída a IP externo |
| Conclusão | Exploração de falha de upload (T1190) e web shell (T1505.003); confiança alta |

**Lição:** compare o webroot com o repositório de código e monitore processos filhos do servidor web.

## 3. Caso 3: ameaça interna com cópia de dados e histórico apagado

**Pergunta:** o administrador copiou dados antes de sair?

| Fonte | Achado |
|---|---|
| auth.log | Logon do usuário `adm01` às 18:40Z de fora do horário e sudo para root |
| `.bash_history` | Substituído; `ctime` às 19:10Z; poucas linhas anteriores |
| auditd | `EXECVE` de `tar`, `scp` para IP externo e depois `history -c` |
| Rede e firewall | 18 GB enviados via SSH às 18:52Z |
| Resultado | Cópia de dados confirmada por auditd e fluxos de rede; tentativa de ocultação |

**Lição:** o auditd e os fluxos de rede reconstroem o que o histórico apagado deixou de registrar.

## 4. Caso 4: contêiner comprometido com acesso ao host

**Pergunta:** o atacante saiu do contêiner?

| Fonte | Achado |
|---|---|
| `docker inspect` | Contêiner `--privileged` com `/var/run/docker.sock` montado |
| `docker diff` | Binários adicionados em `/tmp` e arquivos em `/host` |
| Host | Novo contêiner criado a partir do próprio contêiner e novo usuário no host |
| Auditoria da API | Chamadas de criação de contêineres com montagem de `/` |
| Conclusão | Escape para o host por socket do Docker (T1611) e implantação de contêineres (T1610); confiança alta |

**Lição:** não monte o socket do Docker nem execute contêineres privilegiados sem necessidade.

## 5. Caso 5: rootkit com LD_PRELOAD

**Pergunta:** por que o `ps` e o `netstat` não mostram o processo suspeito?

| Fonte | Achado |
|---|---|
| `/etc/ld.so.preload` | Referência a `/lib/libsystem.so`, que não pertence a pacote algum |
| `debsums` e `rpm -Va` | Sem divergências nos binários (a interceptação está na biblioteca) |
| Memória | Biblioteca carregada em processos; conexões visíveis só na captura |
| `/proc` comparado com `ps` | Processo existente em `/proc` e ausente em `ps` |
| Conclusão | Interceptação por biblioteca (T1574.006) e ocultação de processos; confiança alta, confirmada pela memória e pelo disco |

**Lição:** não confie nas ferramentas do sistema comprometido; use memória, imagens e binários confiáveis.

## 6. Caso 6: binário excluído em execução

**Pergunta:** o malware já foi removido?

| Fonte | Achado |
|---|---|
| `ls -l /proc/*/exe` | Processo 4321 com `exe` marcado como `(deleted)` |
| `/proc/4321/` | `cmdline` com argumentos de conexão; `fd` com socket ESTABLISHED |
| Ação | Cópia de `/proc/4321/exe` para a mídia de evidências, com hash; captura de memória |
| Resultado | O binário foi recuperado mesmo após a exclusão no disco |

**Lição:** a exclusão do arquivo não encerra o processo; a coleta ao vivo recupera o que o disco perdeu.

## 7. Erros comuns, consequências e prevenção

| Erro | Consequência provável | Prevenção |
|---|---|---|
| Desligar o servidor antes de capturar a memória | Perda de processos, conexões e chaves | Ordem de volatilidade e decisão documentada |
| Executar ferramentas do próprio sistema comprometido | Resultados falsos por rootkits | Binários confiáveis, memória e análise offline |
| Montar a imagem com leitura e escrita ou reproduzir o journal | Alteração da evidência | `ro,noload,noexec,nodev` e dispositivo de loop somente leitura |
| Executar `e2fsck` na imagem ou no disco | Alteração do sistema de arquivos | Nunca reparar a evidência |
| Considerar `ctime` como data de criação | Cronologia errada | Entender os carimbos e usar crtime quando existir |
| Confiar no `.bash_history` como registro completo | Falsa conclusão | Corroborar com auditd, memória e logs |
| Ignorar fuso e ausência de ano no syslog | Correlação errada | Normalizar para UTC e verificar o ano |
| Não coletar o journal volátil | Perda de logs | Coletar `/run/log/journal` ao vivo |
| Esquecer contêineres e orquestradores | Perda de evidências efêmeras | Procedimento de preservação de contêineres |
| Usar `ldd` em binário suspeito | Execução do código | `readelf -d` e `objdump -p` |
| Concluir pela ausência de atividade sem verificar a auditoria | Falso negativo | Verificar auditd, journald e retenção |
| Compilar o LiME no sistema comprometido | Alteração e risco | Compilar em sistema equivalente e preparar o módulo antes |

## 8. Exercícios práticos

1. Em uma VM de teste, gere falhas e um logon de SSH e reconstrua a linha do tempo com `auth.log`, `wtmp` e journald.
2. Crie uma entrada de cron e um serviço systemd de teste e identifique-os com consultas de persistência.
3. Habilite `HISTTIMEFORMAT`, execute comandos, apague o histórico e reconstrua com auditd.
4. Exclua um arquivo em ext4 e tente recuperá-lo com `fls -d`, `icat`, journal e carving; documente os resultados.
5. Inicie um contêiner, altere arquivos e execute o procedimento de preservação (pause, logs, diff, export), com hash.
6. Analise uma imagem pública de treinamento (NIST CFReDS) e elabore o inventário de persistências e o mapa de acessos SSH.

## 9. Normas e frameworks relevantes

- MITRE ATT&CK (Linux e Containers)
- ISO/IEC 27037:2012; ISO/IEC 27042:2015; NIST SP 800-86
- CIS Benchmarks (Linux, Docker, Kubernetes); NIST SP 800-190
- CIS Controls v8.1, controles 8 e 17

## 10. Referências

- Nikkel, B. Practical Linux Forensics. No Starch Press, 2021.
- Polstra, P. Linux Forensics. 2015.
- MITRE ATT&CK. https://attack.mitre.org
- The DFIR Report. Relatórios públicos de intrusões.
- NIST CFReDS: Computer Forensic Reference Data Sets.
- SANS Institute. FOR577: Linux Incident Response and Threat Hunting.
