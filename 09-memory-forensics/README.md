# 09 Forense de Memória

## Objetivo

Capturar e analisar a memória volátil para identificar processos, conexões, injeções de código e artefatos que não existem em disco.

## Tópicos abordados

- Importância e volatilidade da memória
- Aquisição de memória em Windows, Linux, macOS e máquinas virtuais
- Análise de processos, DLLs, handles e conexões
- Detecção de injeção de código, rootkits e malware sem arquivo (fileless)
- Extração de credenciais, chaves e artefatos em memória
- Símbolos e perfis no Volatility 3

## Procedimento de referência

1. Capturar a memória o mais cedo possível, antes de desligar ou reiniciar
2. Registrar o hash, a ferramenta e o horário
3. Identificar o sistema operacional e carregar os símbolos
4. Listar processos, conexões e módulos e buscar anomalias
5. Extrair os artefatos suspeitos para análise adicional

## Ferramentas

- Volatility 3
- WinPmem
- DumpIt
- Magnet RAM Capture
- LiME
- AVML
- MemProcFS

## Artefatos e saídas

- Imagem de memória com hash
- Relatório de processos e conexões
- Lista de IOCs extraídos

## Cuidados de integridade e legalidade

- Trabalhar sempre sobre cópias verificadas por hash, nunca sobre a evidência original
- Registrar ferramentas, versões, horários (em UTC) e responsáveis
- Manter a cadeia de custódia (pasta 02-cadeia-de-custodia) e atuar somente com autorização e base legal

## Arquivos previstos para expansão

- guia-aquisicao-de-memoria.md
- roteiro-volatility3.md
- checklist-deteccao-de-injecao.md

## Referências

- Ligh, M. et al. The Art of Memory Forensics (2014)
- Documentação da Volatility Foundation
- SANS FOR526: Memory Forensics In-Depth
- MITRE ATT&CK T1055: Process Injection
- NIST SP 800-86 (2006)
