# 07 Forense em Windows

## Objetivo

Investigar sistemas Windows por meio dos principais artefatos de execução, atividade do usuário, sistema de arquivos e logs.

## Tópicos abordados

- Registro do Windows: SAM, SYSTEM, SOFTWARE, NTUSER.DAT e UsrClass.dat
- Artefatos de execução: Prefetch, Amcache, ShimCache, UserAssist e BAM/DAM
- Atividade do usuário: LNK, Jump Lists, ShellBags e RecentDocs
- NTFS: $MFT, $UsnJrnl e $LogFile
- Logs de eventos (EVTX): autenticação, serviços e PowerShell
- Persistência, SRUM, Volume Shadow Copies e Lixeira

## Procedimento de referência

1. Coletar os artefatos-alvo por triagem (KAPE) ou por imagem completa
2. Processar com as ferramentas de parsing
3. Reconstruir execução, acesso a arquivos e uso de dispositivos USB
4. Correlacionar na linha do tempo
5. Documentar os achados com o caminho e o hash do artefato

## Ferramentas

- KAPE
- Eric Zimmerman's Tools (MFTECmd, EvtxECmd, RECmd, PECmd e LECmd)
- Timeline Explorer
- Autopsy
- Velociraptor

## Artefatos e saídas

- Relatório de artefatos de execução
- Mapa de contas e logons
- Lista de persistências

## Cuidados de integridade e legalidade

- Trabalhar sempre sobre cópias verificadas por hash, nunca sobre a evidência original
- Registrar ferramentas, versões, horários (em UTC) e responsáveis
- Manter a cadeia de custódia (pasta 02-cadeia-de-custodia) e atuar somente com autorização e base legal

## Arquivos previstos para expansão

- checklist-triagem-windows.md
- mapa-de-artefatos-windows.md
- eventos-evtx-prioritarios.md

## Referências

- Carvey, H. Windows Forensic Analysis Toolkit (4ª ed., 2014)
- SANS FOR500: Windows Forensic Analysis
- Pôsteres SANS DFIR (Windows Forensic Analysis)
- Microsoft Learn: Windows security auditing events
- MITRE ATT&CK (Enterprise, Windows)
