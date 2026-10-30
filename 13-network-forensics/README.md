# 13 Forense de Rede

## Objetivo

Analisar tráfego e metadados de rede para identificar comunicação maliciosa, exfiltração e movimentação lateral.

## Tópicos abordados

- Captura de pacotes (PCAP) e metadados de fluxo (NetFlow e IPFIX)
- Protocolos: DNS, HTTP e HTTPS, SMB, RDP e SSH
- Detecção de C2, beaconing, exfiltração e movimentação lateral
- Tráfego criptografado (TLS): metadados, JA3 e JA4, e certificados
- Zeek e Suricata como geradores de evidências
- Preservação e integridade das capturas

## Procedimento de referência

1. Definir os pontos de captura e a janela de tempo
2. Capturar ou coletar PCAPs e fluxos com hash
3. Gerar logs estruturados (Zeek) e alertas (Suricata)
4. Analisar anomalias: DNS, beaconing e volume de saída
5. Reconstruir as sessões e correlacionar com as evidências de host

## Ferramentas

- Wireshark e tshark
- tcpdump
- Zeek
- Suricata
- Arkime
- NetworkMiner

## Artefatos e saídas

- PCAPs com hash
- Relatório de comunicações suspeitas
- Lista de IOCs de rede

## Cuidados de integridade e legalidade

- Trabalhar sempre sobre cópias verificadas por hash, nunca sobre a evidência original
- Registrar ferramentas, versões, horários (em UTC) e responsáveis
- Manter a cadeia de custódia (pasta 02-cadeia-de-custodia) e atuar somente com autorização e base legal

## Arquivos previstos para expansão

- guia-wireshark-e-tshark.md
- roteiro-zeek-logs.md
- checklist-deteccao-de-c2.md

## Referências

- Davidoff, S.; Ham, J. Network Forensics: Tracking Hackers through Cyberspace (2012)
- SANS FOR572: Advanced Network Forensics
- RFC 7011: IPFIX Protocol Specification
- NIST SP 800-86 (2006)
- MITRE ATT&CK: Command and Control
