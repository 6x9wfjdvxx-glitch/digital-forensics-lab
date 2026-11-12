# Prática 2: Windows, Logs, Artefatos e Memória

> **Objetivo pedagógico:** praticar a análise de logs e de artefatos do Windows e a triagem de memória: gerar eventos benignos em uma VM de teste e localizá-los nos logs; usar ferramentas de análise de logs (Hayabusa e Chainsaw, com regras Sigma) em amostras públicas de treinamento; coletar e interpretar artefatos (MFT, Prefetch, Amcache e registro) com as ferramentas de Eric Zimmerman; e conduzir a triagem de uma imagem de memória com o Volatility 3.

> **Segurança:** execute os passos de geração de eventos **somente em uma VM de teste** do laboratório, com snapshot, sem acesso à rede de produção. Use amostras públicas de treinamento de fontes confiáveis. Nenhum passo exige software malicioso.

## 1. Preparação

| Item | Descrição |
|---|---|
| VM Windows de teste | Snapshot "limpo"; conta de administrador local do laboratório; sem acesso à rede de produção |
| VM de análise Windows | Ferramentas de Eric Zimmerman instaladas (arquivo 2) |
| Caso | `DFL-LAB-002` com a estrutura de diretórios do arquivo 1 |
| Registro | Anote versões das ferramentas, comandos e resultados |

## 2. Gerar eventos benignos na VM de teste

```powershell
# Executar como administrador na VM de TESTE; ative primeiro a auditoria necessária
auditpol /set /subcategory:"Other Object Access Events" /success:enable /failure:enable

# Eventos benignos de laboratório
schtasks /create /tn "TarefaLabDFL" /tr "notepad.exe" /sc once /st 23:59
net user usuario_lab_dfl "Lab#Senha2026!" /add
Start-Process notepad.exe
Start-Sleep -Seconds 5
Get-Process notepad | Stop-Process

# Limpeza ao final da geração (para manter a VM limpa)
schtasks /delete /tn "TarefaLabDFL" /f
net user usuario_lab_dfl /delete
```

Anote o horário (UTC e local) da execução. Os eventos esperados: criação de tarefa agendada (4698), criação de conta (4720), exclusão de conta (4726), início e término de processos, se a auditoria de processos estiver habilitada.

```powershell
# Localizar os eventos no log de segurança
Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4698,4720,4726} -MaxEvents 20 |
  Select-Object TimeCreated, Id, Message | Format-List
```

## 3. Exportar os logs para análise

```powershell
# Exportar os logs de eventos para a pasta de evidências do laboratório
New-Item -ItemType Directory -Force -Path C:\lab\DFL-LAB-002\evtx | Out-Null
wevtutil epl Security C:\lab\DFL-LAB-002\evtx\Security.evtx
wevtutil epl System C:\lab\DFL-LAB-002\evtx\System.evtx
wevtutil epl "Microsoft-Windows-PowerShell/Operational" C:\lab\DFL-LAB-002\evtx\PowerShell.evtx
Get-FileHash C:\lab\DFL-LAB-002\evtx\*.evtx -Algorithm SHA256 | Export-Csv C:\lab\DFL-LAB-002\evtx\hashes.csv -NoTypeInformation
```

## 4. Análise dos logs com EvtxECmd

```powershell
# Converter os EVTX para CSV (ferramentas de Eric Zimmerman; ajuste os caminhos)
.\EvtxECmd.exe -d C:\lab\DFL-LAB-002\evtx --csv C:\lab\DFL-LAB-002\saidas --csvf eventos.csv
```

```bash
# Consulta em DuckDB sobre o CSV (ajuste os nomes das colunas ao arquivo gerado)
duckdb -c "SELECT TimeCreated, EventId, Computer, PayloadData1, PayloadData2 FROM read_csv_auto('eventos.csv') WHERE EventId IN (4698, 4720, 4726) ORDER BY TimeCreated;"
```

**Exercício:** identifique, na saída, o usuário que criou a conta, o nome da tarefa agendada e o horário em UTC; correlacione com o horário que você anotou.

## 5. Análise de logs com Hayabusa e Chainsaw (amostras públicas)

Baixe conjuntos públicos de logs de treinamento de projetos reconhecidos (por exemplo, repositórios de amostras de EVTX dos projetos Hayabusa e EVTX-ATTACK-SAMPLES). Esses conjuntos contêm **registros de eventos**, e não executáveis maliciosos; ainda assim, trate-os em VM de análise e confira as licenças.

```bash
# Hayabusa: linha do tempo de detecções a partir de uma pasta de EVTX (confira as opções na documentação da versão instalada)
./hayabusa csv-timeline -d ./evtx_amostras -o hayabusa_timeline.csv

# Chainsaw: caça com regras Sigma (ajuste os caminhos de regras e de mapeamentos)
./chainsaw hunt ./evtx_amostras -s ./sigma/rules --mapping ./mappings/sigma-event-logs-all.yml --csv --output chainsaw_saida
```

| Tarefa | Descrição |
|---|---|
| 1 | Liste as detecções por severidade e por técnica ATT&CK |
| 2 | Escolha 3 detecções e verifique os eventos brutos que as originaram |
| 3 | Classifique cada uma como verdadeiro positivo, falso positivo ou indeterminado, justificando |
| 4 | Escreva as hipóteses alternativas legítimas para cada detecção |

## 6. Artefatos do sistema: MFT, Prefetch, Amcache e registro

Em uma VM de teste, após alguns dias de uso benigno (instalar e abrir programas, criar e apagar arquivos), colete artefatos e analise:

```powershell
# Prefetch (execução de programas): exporte a pasta para análise e processe com PECmd
.\PECmd.exe -d C:\Windows\Prefetch --csv C:\lab\DFL-LAB-002\saidas --csvf prefetch.csv

# Amcache (aplicativos executados e instalados): exporte o arquivo a partir de uma cópia (por exemplo, com a ferramenta de coleta) e processe
.\AmcacheParser.exe -f C:\lab\DFL-LAB-002\coleta\Amcache.hve --csv C:\lab\DFL-LAB-002\saidas

# MFT (arquivos e horários): processe uma cópia da $MFT obtida por coleta forense
.\MFTECmd.exe -f C:\lab\DFL-LAB-002\coleta\$MFT --csv C:\lab\DFL-LAB-002\saidas --csvf mft.csv
```

Observação: arquivos como a `$MFT`, o `Amcache.hve` e as colmeias do registro estão em uso pelo sistema; a coleta exige ferramentas que leem o volume (por exemplo, o KAPE ou o FTK Imager) ou a análise de uma imagem offline. Documente o método de coleta e o hash.

| Artefato | Pergunta a responder |
|---|---|
| Prefetch | Que programas foram executados, quantas vezes e quando? |
| Amcache | Que programas foram instalados ou executados e com que hash? |
| MFT | Quando um arquivo foi criado, modificado e movido? Há divergências entre os horários de atributos (`$STANDARD_INFORMATION` e `$FILE_NAME`)? |
| Registro (execução automática, USB e arquivos recentes) | Que persistências e dispositivos existem? |

## 7. Memória: triagem com o Volatility 3

Duas opções de amostra: (a) capturar a memória da sua VM de teste (por exemplo, com o recurso de instantâneo da VM, que gera arquivo de memória, ou com uma ferramenta de aquisição) ou (b) usar imagens de memória públicas de treinamento (por exemplo, de desafios de forense e de projetos educacionais), conferindo a licença e o hash.

```bash
# Trabalhe sobre uma CÓPIA da memória e registre o hash
sha256sum memoria_lab.raw > memoria_lab.raw.sha256

vol -f memoria_lab.raw windows.info
vol -f memoria_lab.raw windows.pslist.PsList  > pslist.txt
vol -f memoria_lab.raw windows.psscan.PsScan  > psscan.txt
vol -f memoria_lab.raw windows.pstree.PsTree  > pstree.txt
vol -f memoria_lab.raw windows.cmdline.CmdLine > cmdline.txt
vol -f memoria_lab.raw windows.netscan.NetScan > netscan.txt
vol -f memoria_lab.raw windows.malfind.Malfind > malfind.txt
```

Nota: o Volatility 3 precisa de tabelas de símbolos. Para Windows, ele pode baixá-las automaticamente dos servidores de símbolos da Microsoft, o que exige acesso à internet; em laboratório isolado, prepare o cache de símbolos previamente. Para Linux, é necessário o arquivo de símbolos correspondente ao *kernel*.

| Exercício | Descrição |
|---|---|
| 1 | Compare `pslist` e `psscan`: há processos que aparecem em apenas uma das listas? O que isso pode significar? |
| 2 | Use `pstree` para identificar relações incomuns entre processos pai e filho |
| 3 | Examine as linhas de comando e as conexões de rede e anote itens para a caça |
| 4 | Interprete os resultados do `malfind` com cautela: regiões executáveis podem ser legítimas (por exemplo, compiladores *just-in-time*) |
| 5 | Documente os achados com a fonte, o comando e a confiança |

## 8. Registro e relatório

| Documento | Conteúdo |
|---|---|
| Registro de ferramentas | Versões do EvtxECmd, do Hayabusa, do Chainsaw, do PECmd, do AmcacheParser, do MFTECmd e do Volatility 3 |
| Linha do tempo integrada | Eventos dos logs e dos artefatos, em UTC |
| Matriz de detecções | Detecção, evidência, classificação e hipótese alternativa |
| Mini-relatório | Fatos, método, resultados, limitações |

## 9. Perguntas de verificação

| Pergunta | Resposta esperada |
|---|---|
| Por que um evento 4698 pode não aparecer em um sistema recém-instalado? | A auditoria da subcategoria correspondente pode estar desabilitada |
| Por que comparar `pslist` e `psscan` na memória? | Processos ocultos ou encerrados podem aparecer em apenas uma das listas |
| Qual o risco de interpretar o `malfind` isoladamente? | Falsos positivos de regiões executáveis legítimas |
| Por que a coleta de `$MFT` e do registro exige técnicas especiais? | Os arquivos estão em uso pelo sistema e exigem leitura no nível do volume ou imagem offline |

## 10. Casos de uso corporativos

- Treinamento de analistas de DFIR em artefatos do Windows e em análise de logs.
- Criação e teste de detecções com amostras controladas.
- Validação de fluxos de coleta (PB-10 e PB-12).

## 11. Normas e frameworks relevantes

- MITRE ATT&CK (execução, persistência e evasão de defesas); Sigma (regras de detecção); NIST SP 800-86
- ISO/IEC 27037, 27042 e 27043; CIS Controls v8.1, controle 8

## 12. Referências

- Documentação do Hayabusa, do Chainsaw, do Sigma e das ferramentas de Eric Zimmerman.
- The Volatility Foundation. Documentação do Volatility 3.
- Carvey, H. Windows Forensic Analysis Toolkit. Syngress.
- Pastas 07, 09 e 11 deste repositório; PB-10, PB-12 e PB-15 (pasta 23).
