# Casos de Uso e Erros Comuns em Memória

> **Objetivo pedagógico:** consolidar o aprendizado de forense de memória com cenários corporativos realistas, os erros mais frequentes, suas consequências e as medidas de prevenção.

Os casos são fictícios e destinados ao treinamento.

## 1. Caso 1: beacon injetado em `svchost.exe`

**Pergunta:** o EDR não alertou, mas há tráfego periódico suspeito. Há implante em memória?

| Fonte | Achado |
|---|---|
| `pstree` e `cmdline` | `svchost.exe` (PID 3120) com pai `explorer.exe` e sem argumento `-k` |
| `malfind` | Região RWX com cabeçalho MZ, sem arquivo mapeado |
| `netscan` | Conexões periódicas do PID 3120 ao IP externo na porta 443 |
| Rede (proxy e DNS) | Intervalos regulares de 60 segundos com variação pequena (beaconing) |
| Extração | Região despejada com hash; configuração do beacon obtida em laboratório |
| Conclusão | Process hollowing e implante de C2 (T1055.012 e T1071); confiança alta |

**Lição:** o EDR pode falhar; a memória revela o que não chegou ao disco, mas deve ser corroborada com a rede.

## 2. Caso 2: execução sem arquivo com PowerShell

**Pergunta:** não há arquivo malicioso em disco. O que foi executado?

| Fonte | Achado |
|---|---|
| `pstree` | `winword.exe` → `cmd.exe` → `powershell.exe` |
| `cmdline` | `powershell.exe -nop -w hidden -enc ...` |
| Strings (UTF-16) | Script decodificado com download e execução em memória |
| `netscan` | Conexão HTTP a IP externo, a partir do `powershell.exe` |
| Registro em memória | Nenhuma persistência encontrada |
| Conclusão | Documento com macro gerando execução sem arquivo (T1204, T1059.001); confiança alta; o disco não conteria evidência |

**Lição:** em ataques sem arquivo, a memória pode ser a única fonte.

## 3. Caso 3: dump do LSASS e decisão de contenção

**Pergunta:** credenciais foram expostas?

| Fonte | Achado |
|---|---|
| `cmdline` | `rundll32.exe C:\Windows\System32\comsvcs.dll, MiniDump <PID> C:\Windows\Temp\x.dmp full` |
| `handles` | Handle ao `lsass.exe` e ao arquivo temporário |
| Registro | Credential Guard desabilitado |
| Decisão | Não extrair as senhas; considerar comprometidas as credenciais com sessão no host |
| Ação | Redefinição das credenciais e revisão dos logons posteriores nos controladores de domínio |

**Lição:** confirmar a exposição basta para a contenção; a extração dos segredos é desnecessária e arriscada.

## 4. Caso 4: processo oculto por manipulação de listas (DKOM)

| Fonte | Achado |
|---|---|
| `pslist` | Não mostra `svc_helper.exe` |
| `psscan` | Mostra `svc_helper.exe` (PID 5012) com horário de criação 3 horas antes |
| `modules` e `modscan` | Driver `helper.sys` presente apenas na varredura (`modscan`) |
| `ssdt` e `callbacks` | Callback de kernel apontando para o driver |
| Disco | Driver encontrado em `C:\Windows\System32\drivers\helper.sys`, sem assinatura |
| Conclusão | Rootkit de kernel que oculta processo e módulo (T1014); confiança alta |

**Lição:** compare visões diferentes da mesma informação (listas e varreduras).

## 5. Caso 5: servidor Linux com módulo de kernel oculto

| Fonte | Achado |
|---|---|
| `linux.lsmod` | Lista sem o módulo `sysmon_ko` |
| Varredura de módulos e `linux.check_syscall` | Módulo presente e syscall `getdents` desviada |
| `linux.pslist` | Processo de mineração oculto no `ps` do host |
| Disco | `/lib/modules/.../extra/sysmon_ko.ko` sem pacote associado |
| Conclusão | Rootkit LKM ocultando processos e arquivos; confiança alta; as ferramentas do próprio sistema não revelavam |

**Lição:** não confie nas ferramentas do sistema comprometido; use a memória e imagens.

## 6. Caso 6: recuperação de chave de ransomware

| Etapa | Ação |
|---|---|
| 1 | Sistema ainda ligado após a execução do ransomware; captura de memória imediata |
| 2 | Identificação do processo do ransomware e extração de sua memória |
| 3 | Avaliação por pesquisa da família (existência de ferramentas públicas de recuperação de chaves, como o Wanakiwi para o WannaCry em sistemas antigos) |
| 4 | Se não houver ferramenta, preservar a memória e o processo para análise de malware e para futuras ferramentas |
| Resultado | A memória capturada antes do reinício preserva a possibilidade de recuperação |

**Lição:** não reinicie sistemas afetados por ransomware antes de capturar a memória.

## 7. Caso 7: falso positivo do malfind

| Observação | Interpretação |
|---|---|
| `malfind` aponta regiões RWX em `chrome.exe` e `java.exe` | Compilação JIT e motores de JavaScript e JVM |
| Sem cabeçalho MZ e sem padrões de shellcode | Provável falso positivo |
| Comparação com a linha de base | Padrão idêntico em estações sem incidente |
| Conclusão | Registrar o falso positivo e a justificativa; focar nos processos que não deveriam gerar código dinâmico |

**Lição:** permissões RWX não bastam como prova; verifique o contexto.

## 8. Erros comuns, consequências e prevenção

| Erro | Consequência provável | Prevenção |
|---|---|---|
| Desligar ou reiniciar antes de capturar a memória | Perda de evidência volátil | Capturar primeiro e documentar a decisão |
| Capturar para o disco do próprio sistema | Sobrescrita de evidências | Mídia externa dedicada |
| Não calcular o hash nem testar a abertura da imagem | Impossibilidade de provar a integridade e a validade | Hash e `windows.info.Info` |
| Usar símbolos incorretos | Resultados vazios ou errados | Confirmar banner e versão, e documentar a origem |
| Confiar apenas em `pslist` | Processos ocultos não detectados | Comparar com `psscan` e outras visões |
| Tratar todo RWX como malware | Falsos positivos | Contexto, MZ, shellcode e linha de base |
| Executar amostras extraídas fora de ambiente isolado | Risco de infecção | Laboratório isolado |
| Extrair credenciais sem autorização ou expô-las no relatório | Risco legal e de segurança | Autorização, minimização e contenção |
| Ignorar proteções do sistema (VBS e compressão de memória) | Conclusões incompletas | Registrar e declarar as limitações |
| Não corroborar com disco, logs e rede | Conclusões frágeis | Fontes independentes |
| Ignorar o smearing | Inconsistências atribuídas a malware | Declarar e confirmar com outras fontes |

## 9. Exercícios práticos

1. Instale o Volatility 3 em ambiente isolado e analise uma imagem pública de treinamento (por exemplo, desafios MemLabs ou imagens de exemplo da Volatility Foundation), registrando as versões.
2. Construa o inventário de processos e identifique anomalias contra a linha de base.
3. Compare `pslist` e `psscan` e `modules` e `modscan` e explique as divergências.
4. Extraia e calcule o hash de um executável injetado e redija o registro de achado.
5. Em uma VM de laboratório, capture a memória, execute um script PowerShell codificado e identifique o comando e a conexão.
6. Redija o relatório de uma captura, indicando limitações, confiança e mapeamento ATT&CK.

## 10. Normas e frameworks relevantes

- MITRE ATT&CK: T1055, T1059.001, T1003.001, T1014, T1204, T1071
- ISO/IEC 27037:2012; ISO/IEC 27042:2015; NIST SP 800-86
- CIS Controls v8.1, controles 8 e 17

## 11. Referências

- Ligh, M. et al. The Art of Memory Forensics. Wiley, 2014.
- MITRE ATT&CK. https://attack.mitre.org
- The DFIR Report. Relatórios públicos de intrusões.
- MemLabs: desafios públicos de forense de memória (repositório da comunidade).
- Volatility Foundation. Imagens de exemplo e documentação.
- SANS Institute. FOR508 e FOR526.
