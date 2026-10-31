# Casos de Uso e Erros Comuns em Timeline

> **Objetivo pedagógico:** consolidar o aprendizado de análise de linha do tempo com cenários corporativos, erros frequentes, suas consequências e as medidas de prevenção.

Os casos são fictícios e destinados ao treinamento.

## 1. Caso 1: cópia de arquivos para pen drive antes do desligamento

**Pergunta:** o colaborador copiou o repositório de projetos para mídia removível?

| Etapa | Evidência |
|---|---|
| Dispositivo | Registro (USBSTOR) e `setupapi.dev.log`: primeira conexão em 2026-10-26T17:42Z |
| Atividade | LNK e Jump Lists: abertura de arquivos a partir da unidade removível |
| Operações | `$UsnJrnl`: criação em massa de arquivos no volume removível entre 17:44Z e 17:51Z |
| Logs centrais | DLP e EDR: alertas de gravação em mídia removível |
| Contexto | Logon do usuário em sessão ativa das 17:20Z às 18:05Z |

**Conclusão:** cópia em lote compatível com o repositório, em sessão do usuário, com corroboração por quatro fontes. Limitação: conteúdo exato dos arquivos não confirmado sem a mídia.

**Lição:** o horário de conexão do dispositivo e o das operações de arquivo devem ser interpretados juntos.

## 2. Caso 2: ransomware e tempo de permanência

**Pergunta:** quanto tempo o atacante permaneceu antes da criptografia?

| Fase | Horário (UTC) | Fonte |
|---|---|---|
| Acesso inicial por VPN com credencial comprometida | 2026-10-20T22:14Z | Logs de VPN e Entra ID |
| Movimentação lateral com RDP | 2026-10-21T01:40Z | EVTX 4624 (tipo 10) em servidores |
| Instalação de ferramenta de acesso remoto | 2026-10-21T02:05Z | Evento 7045 e Amcache |
| Exfiltração de dados | 2026-10-24T03:00Z a 05:30Z | Proxy e firewall |
| Criptografia | 2026-10-26T04:12Z | `$UsnJrnl`, EDR |

**Conclusão:** tempo de permanência de cerca de seis dias, com exfiltração antes da criptografia (dupla extorsão provável). Implicações: comunicação regulatória por vazamento de dados.

**Lição:** a linha do tempo define o escopo do incidente e as obrigações de comunicação.

## 3. Caso 3: DLL antiga que não era antiga

**Pergunta:** a biblioteca presente em `System32` foi instalada com o sistema?

| Evidência | Resultado |
|---|---|
| `$SI` Criação | 2019-03-12 09:00:00, com fração de segundo zerada |
| `$FN` Criação | 2026-10-28 13:21:48 |
| `$UsnJrnl` | Registro de criação em 2026-10-28 13:21:48 |
| Prefetch e Amcache | Carregamento e registro em 2026-10-28 13:22Z |

**Conclusão:** indício forte de timestomping. A DLL foi criada em 2026-10-28.

**Lição:** compare sempre `$SI` e `$FN` e confirme com `$UsnJrnl` e artefatos de execução.

## 4. Caso 4: desvio de relógio entre proxy e EDR

**Problema:** o analista concluiu que a conexão ao domínio malicioso ocorreu antes da execução do binário.

| Causa | Efeito |
|---|---|
| O proxy estava com o relógio atrasado em 3 minutos | A conexão aparecia antes da execução |
| Correção | Calibrar com eventos-âncora (por exemplo, o mesmo download visto no EDR) |
| Resultado | A conexão ocorreu 32 segundos após a execução |

**Lição:** relógios diferentes invertem a causalidade; estime e documente o desvio antes de concluir.

## 5. Caso 5: fuso horário e conclusão errada

**Problema:** logs do firewall estão em hora local e os do Entra ID, em UTC. O analista associou um logon às 13:40Z a uma conexão do firewall às 13:40 (hora local), que na verdade era 16:40Z.

| Correção | Resultado |
|---|---|
| Normalizar o firewall para UTC (local UTC−3) | A conexão correta ocorreu às 13:40Z (10:40 local) |
| Reavaliar a correlação | Associação confirmada com a conexão ocorrida às 10:40 local |

**Lição:** documente o fuso de cada fonte e converta antes de correlacionar.

## 6. Caso 6: snapshot de VM revertido

**Problema:** a máquina virtual apresenta eventos que "somem" e horários que retrocedem.

| Evidência | Interpretação |
|---|---|
| Logs do hipervisor | Reversão de snapshot em 2026-10-27T08:15Z |
| Registros do guest | Sem eventos entre 2026-10-26T20:00Z e 08:15Z do dia 27 |
| Logs externos (SIEM) | Eventos do período existem nos sistemas centrais |

**Conclusão:** lacuna explicada pela reversão do snapshot; os eventos do período foram recuperados dos logs externos.

**Lição:** use fontes independentes e verifique a camada de virtualização.

## 7. Erros comuns, consequências e prevenção

| Erro | Consequência provável | Prevenção |
|---|---|---|
| Não normalizar para UTC | Correlações erradas e linha do tempo inconsistente | Converter todas as fontes e registrar os fusos |
| Ignorar o desvio de relógio | Inversão de causalidade | Eventos-âncora e coluna de ajuste |
| Interpretar o horário de `LastWrite` como horário de execução | Falsa cronologia | Conhecer o significado de cada carimbo |
| Tratar o carimbo de acesso como leitura certa | Conclusões indevidas | Verificar a política de atualização de acesso |
| Confiar em uma única fonte | Erros não detectados | Corroboração por duas fontes independentes |
| Suprimir ruído sem registrar | Perda de rastreabilidade e contestação | Registrar e justificar os filtros |
| Sobrescrever o horário original | Impossibilidade de auditar as correções | Manter o valor original e a correção separados |
| Concluir sem considerar alternativas | Viés de confirmação | Análise de hipóteses concorrentes |
| Afirmar manipulação sem corroboração | Acusação infundada | Descrever o indício e a confiança |
| Não preservar os arquivos brutos | Reprodução impossível | Hash e armazenamento dos dados de origem |
| Esquecer horário de verão em datas históricas | Deslocamentos de uma hora | Usar a base IANA de fusos |

## 8. Exercícios práticos

1. Converta cinco valores (FILETIME, Unix, WebKit, Cocoa e hora local) para UTC e confira com um script.
2. A partir de dois CSV de fontes diferentes (um em hora local e outro em UTC), gere uma timeline unificada com coluna de ajuste de desvio.
3. Crie arquivos de teste, altere os carimbos com ferramenta de laboratório e identifique os indícios em `$MFT`.
4. Use o Plaso em uma imagem pública de treinamento e exporte uma janela de dois dias.
5. Redija a narrativa por fases e o registro de eventos-chave para o caso 2.

## 9. Normas e frameworks relevantes

- ISO/IEC 27042:2015; NIST SP 800-86
- MITRE ATT&CK
- ISO/IEC 27002:2022, controles 8.15 e 8.17
- CIS Controls v8.1, controle 8

## 10. Referências

- Carrier, B. File System Forensic Analysis. Addison-Wesley, 2005.
- Carvey, H. Windows Forensic Analysis Toolkit. 4. ed. Syngress, 2014.
- Gudjonsson, K. Mastering the Super Timeline With log2timeline. SANS, 2010.
- Heuer, R. Psychology of Intelligence Analysis. CIA, 1999.
- MITRE ATT&CK. https://attack.mitre.org
- The DFIR Report. Casos públicos de intrusão e ransomware.
- NIST CFReDS: Computer Forensic Reference Data Sets (imagens de treinamento).
