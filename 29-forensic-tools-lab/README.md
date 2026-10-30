# 29 Laboratório de Ferramentas Forenses

## Objetivo

Projetar, montar e validar um laboratório de forense digital seguro, isolado e documentado.

## Tópicos abordados

- Arquitetura do laboratório: hosts, VMs, redes isoladas e armazenamento de evidências
- Estações: SIFT Workstation, FLARE VM, REMnux e Kali (testes)
- Ferramentas de aquisição e análise: Autopsy, KAPE, Velociraptor e Volatility
- Conjuntos de dados de prática e imagens públicas de treinamento
- Validação e documentação de ferramentas (CFTT)
- Segurança do laboratório, licenças e controle de acesso

## Procedimento de referência

1. Projetar e isolar a rede do laboratório
2. Instalar e versionar as estações e as ferramentas
3. Validar as ferramentas com dados de teste e registrar as versões
4. Configurar snapshots e rotinas de restauração
5. Documentar os procedimentos e os controles de acesso

## Ferramentas

- VirtualBox, VMware e Hyper-V
- SIFT Workstation
- FLARE VM
- REMnux
- Autopsy
- Velociraptor
- KAPE

## Artefatos e saídas

- Desenho do laboratório
- Inventário de ferramentas e versões
- Relatório de validação de ferramentas

## Cuidados de integridade e legalidade

- Trabalhar sempre sobre cópias verificadas por hash, nunca sobre a evidência original
- Registrar ferramentas, versões, horários (em UTC) e responsáveis
- Manter a cadeia de custódia (pasta 02-cadeia-de-custodia) e atuar somente com autorização e base legal

## Arquivos previstos para expansão

- guia-de-instalacao-do-laboratorio.md
- inventario-de-ferramentas.md
- procedimento-de-validacao.md

## Referências

- NIST Computer Forensic Tool Testing (CFTT) Program
- NIST CFReDS: Computer Forensic Reference Data Sets
- Digital Corpora (conjuntos de dados para pesquisa forense)
- ISO/IEC 17025:2017: Requisitos para laboratórios de ensaio e calibração
- SANS SIFT Workstation, FLARE VM (Mandiant) e REMnux
