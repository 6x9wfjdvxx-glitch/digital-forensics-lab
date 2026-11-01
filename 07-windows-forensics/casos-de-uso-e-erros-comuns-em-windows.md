# Casos de Uso e Erros Comuns em Windows

> **Objetivo pedagógico:** consolidar o aprendizado de forense de Windows com cenários corporativos realistas, os erros mais frequentes, suas consequências e as medidas de prevenção.

Os casos são fictícios e destinados ao treinamento.

## 1. Caso 1: phishing com execução de malware e persistência

**Pergunta:** o usuário executou o anexo e o atacante conseguiu persistir?

| Hora (UTC) | Fonte | Achado |
|---|---|---|
| 13:20:07 | Proxy e navegador | Download de `fatura.zip` (Zone.Identifier com ReferrerUrl do webmail) |
| 13:21:48 | `$MFT` e `$UsnJrnl` | Criação de `invoice.exe` em `Downloads` |
| 13:22:10 | Prefetch, BAM e UserAssist | Execução de `INVOICE.EXE` pelo usuário U |
| 13:22:12 | EVTX 4698 | Tarefa agendada `UpdateCheck` criada |
| 13:22:42 | SRUM e proxy | Conexão externa ao domínio recém-registrado |
| 13:40:30 | Entra ID | Logon do usuário U de IP externo |

**Conclusão:** execução, persistência e uso de credenciais comprovados por múltiplas fontes; confiança alta. Técnicas: T1204, T1053.005, T1071 e T1078.
**Lição:** a execução se prova por mais de um artefato; a persistência exige verificar tarefas, serviços e registro.

## 2. Caso 2: exfiltração por USB

**Pergunta:** colaborador copiou o repositório para pen drive?

| Fonte | Achado |
|---|---|
| USBSTOR e `setupapi.dev.log` | Primeira conexão do serial X em 2026-10-26T17:42Z |
| MountPoints2 | Volume acessado pelo usuário U |
| ShellBags, LNK e Jump Lists | Pastas e arquivos do repositório abertos a partir da unidade removível |
| `$UsnJrnl` | 412 criações em rajada entre 17:44Z e 17:51Z na unidade removível |
| DLP e EDR | Alertas de gravação em mídia removível |

**Conclusão:** cópia em lote compatível com o repositório; confiança alta. Limitação: o conteúdo dos arquivos não foi confirmado sem a mídia.
**Lição:** combine registro de dispositivo, acesso a arquivos e operações do sistema de arquivos.

## 3. Caso 3: RDP e movimentação lateral até ransomware

| Fase | Evidência |
|---|---|
| Acesso | VPN com credencial comprometida; 4625 em série e 4624 tipo 10 em servidor exposto |
| Reconhecimento | Execução de ferramentas de enumeração (Prefetch e 4688) |
| Credenciais | Sysmon 10 acessando LSASS e arquivo `.dmp` em pasta temporária |
| Lateralidade | 4624 tipo 3 e 5145 em `ADMIN$`, 7045 `PSEXESVC` em vários servidores |
| Exfiltração | SRUM e proxy mostram alto volume de saída do servidor de arquivos |
| Impacto | `vssadmin delete shadows`, criptografia, notas de resgate |

**Conclusão:** cadeia de ataque reconstruída com alto grau de confiança; tempo de permanência de dias; exfiltração antes da criptografia.
**Lição:** a linha do tempo define o escopo e as obrigações de comunicação (LGPD, ANPD).

## 4. Caso 4: arquivo excluído e recuperação

**Pergunta:** que arquivo foi excluído antes do desligamento do colaborador?

| Fonte | Achado |
|---|---|
| Lixeira (`$I`) | Planilha de preços enviada à Lixeira às 16:05Z e esvaziada às 16:20Z |
| `$UsnJrnl` | `FILE_DELETE` e esvaziamento registrados; nome e referência do arquivo |
| `$MFT` | Registro não em uso com carimbos; conteúdo não residente |
| VSS | Ponto de restauração do dia anterior contém o arquivo |
| Resultado | Arquivo recuperado da cópia de sombra e comparado por hash |

**Lição:** esvaziar a Lixeira não elimina os metadados nem as cópias de sombra.

## 5. Caso 5: dump de credenciais

| Fonte | Achado |
|---|---|
| Sysmon 10 | Acesso ao `lsass.exe` por `rundll32.exe` com acesso amplo |
| 4688 | `rundll32.exe C:\Windows\System32\comsvcs.dll, MiniDump <PID> C:\Windows\Temp\x.dmp full` |
| `$UsnJrnl` | Criação e exclusão de `x.dmp` |
| Defender | Alerta de comportamento de roubo de credenciais |

**Conclusão:** dump do LSASS (T1003.001) com alta confiança. Ação: tratar como comprometidas todas as credenciais que estiveram na memória.
**Lição:** preserve os eventos antes que o log rotacione; a exclusão do dump não elimina os vestígios.

## 6. Caso 6: anti-forense: limpeza de logs e cópias de sombra

| Fonte | Achado |
|---|---|
| 1102 | Limpeza do log de Segurança às 04:02Z |
| 104 | Limpeza do log do sistema |
| 4688 ou Prefetch | `wevtutil cl Security` e `vssadmin delete shadows` |
| SIEM | Os eventos anteriores à limpeza foram preservados no servidor central |
| `$MFT` e carving | Fragmentos de EVTX recuperados do espaço não alocado |

**Lição:** logs centralizados e coleta precoce reduzem o impacto da limpeza local.

## 7. Erros comuns, consequências e prevenção

| Erro | Consequência provável | Prevenção |
|---|---|---|
| Tratar presença (ShimCache) como execução | Falsa conclusão | Exigir artefato de execução e corroboração |
| Interpretar `LastWrite` do registro como horário do evento | Cronologia equivocada | Entender o que cada carimbo representa |
| Ignorar os logs de transação dos hives | Dados desatualizados ou ausentes | Coletar `.LOG1` e `.LOG2` e reaplicar |
| Concluir pela ausência de atividade quando a auditoria estava desabilitada | Falso negativo | Verificar `auditpol` e a configuração |
| Copiar hives ou logs em uso por cópia simples | Arquivos corrompidos ou incompletos | KAPE, VSS ou ferramenta de baixo nível |
| Desligar o sistema antes da memória | Perda de chaves, processos e conexões | Ordem de volatilidade |
| Não normalizar horários e fusos | Correlações erradas | UTC e documentação de fusos |
| Não verificar `$SI` e `$FN` | Não detectar timestomping | Comparar carimbos e outras fontes |
| Analisar apenas a imagem atual e ignorar VSS | Perda de estados anteriores | Processar as cópias de sombra |
| Depender de uma ferramenta sem validação | Erros não detectados | Validar com uma segunda ferramenta |
| Executar ferramentas do próprio sistema comprometido | Binários adulterados | Mídia confiável |
| Apresentar achados sem grau de confiança | Superestimação | Escala de confiança e limitações |

## 8. Exercícios práticos

1. Em uma VM de teste, execute um programa, conecte um pen drive e crie uma tarefa agendada; depois colete com o KAPE e identifique cada ação em pelo menos dois artefatos.
2. Gere eventos 4624 tipos 2, 3 e 10 em ambiente de laboratório e crie uma consulta que os classifique.
3. Exclua arquivos, esvazie a Lixeira e recupere metadados e conteúdo pela MFT, pelo `$UsnJrnl` e pelas VSS.
4. Altere os carimbos de um arquivo com uma ferramenta de laboratório e identifique os indícios em `$SI` e `$FN`.
5. Elabore o inventário de persistências e o mapa de contas e logons de uma imagem pública de treinamento (NIST CFReDS).

## 9. Normas e frameworks relevantes

- MITRE ATT&CK (táticas e técnicas citadas em cada caso)
- ISO/IEC 27037:2012; ISO/IEC 27042:2015; NIST SP 800-86
- CIS Controls v8.1, controles 8 e 17
- ISO/IEC 27002:2022, controles 8.15 e 8.16

## 10. Referências

- Carvey, H. Windows Forensic Analysis Toolkit. 4. ed. Syngress, 2014.
- Carrier, B. File System Forensic Analysis. Addison-Wesley, 2005.
- MITRE ATT&CK. https://attack.mitre.org
- The DFIR Report. Relatórios públicos de intrusões.
- NIST CFReDS: Computer Forensic Reference Data Sets.
- SANS Institute. FOR500 e FOR508.
