# 14 Forense Mobile

## Objetivo

Adquirir e analisar dispositivos móveis preservando a evidência e reconhecendo as limitações técnicas e legais.

## Tópicos abordados

- Tipos de aquisição: lógica, sistema de arquivos, física e backup
- Android: partições, bancos SQLite, aplicativos e artefatos
- iOS: backups, keychain, artefatos e limitações de criptografia
- Mensageiros, localização, mídia e uso de aplicativos
- Isolamento de rede (modo avião e bolsa Faraday) e preservação
- Spyware e verificação de comprometimento

## Procedimento de referência

1. Isolar o dispositivo da rede e registrar seu estado
2. Documentar modelo, IMEI, versão do sistema e bloqueios
3. Escolher o método de aquisição compatível e legal
4. Gerar o hash e preservar a extração
5. Analisar os artefatos e relatar com as ressalvas das limitações técnicas

## Ferramentas

- Cellebrite UFED (comercial)
- Magnet AXIOM (comercial)
- Autopsy
- ALEAPP e iLEAPP
- ADB
- Mobile Verification Toolkit (MVT)

## Artefatos e saídas

- Relatório de extração
- Linha do tempo de comunicações e localização
- Relatório de verificação de spyware

## Cuidados de integridade e legalidade

- Trabalhar sempre sobre cópias verificadas por hash, nunca sobre a evidência original
- Registrar ferramentas, versões, horários (em UTC) e responsáveis
- Manter a cadeia de custódia (pasta 02-cadeia-de-custodia) e atuar somente com autorização e base legal

## Arquivos previstos para expansão

- checklist-aquisicao-mobile.md
- guia-artefatos-android-ios.md
- guia-mvt.md

## Referências

- NIST SP 800-101 Rev. 1: Guidelines on Mobile Device Forensics (2014)
- SANS FOR585: Smartphone Forensic Analysis In-Depth
- Hoog, A. Android Forensics (2011)
- Lei nº 12.965/2014 (Marco Civil da Internet)
- Lei nº 13.709/2018 (LGPD)
