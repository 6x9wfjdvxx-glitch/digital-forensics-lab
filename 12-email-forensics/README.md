# 12 Forense de E-mail

## Objetivo

Investigar mensagens e caixas de correio para identificar origem, adulteração, phishing e comprometimento de contas.

## Tópicos abordados

- Estrutura da mensagem e cabeçalhos (RFC 5322) e rota (Received)
- Autenticação: SPF, DKIM e DMARC
- Phishing, spoofing e Business Email Compromise (BEC)
- Anexos, links e análise de conteúdo malicioso
- Formatos de caixa de correio: PST, OST, EML e MBOX
- Regras de caixa de entrada, encaminhamentos e acessos indevidos

## Procedimento de referência

1. Preservar a mensagem original com todos os cabeçalhos
2. Analisar a rota e as autenticações
3. Analisar anexos e URLs em ambiente isolado
4. Verificar regras, encaminhamentos e acessos à caixa de correio
5. Correlacionar com logs de autenticação e do gateway de e-mail

## Ferramentas

- MXToolbox (cabeçalhos)
- Microsoft Message Header Analyzer
- PhishTool
- readpst
- Autopsy
- MailXaminer (comercial)

## Artefatos e saídas

- Relatório de análise de cabeçalhos
- Lista de IOCs (domínios, URLs e hashes)
- Linha do tempo de BEC

## Cuidados de integridade e legalidade

- Trabalhar sempre sobre cópias verificadas por hash, nunca sobre a evidência original
- Registrar ferramentas, versões, horários (em UTC) e responsáveis
- Manter a cadeia de custódia (pasta 02-cadeia-de-custodia) e atuar somente com autorização e base legal

## Arquivos previstos para expansão

- guia-analise-de-cabecalhos.md
- checklist-bec.md
- playbook-phishing.md

## Referências

- RFC 5322: Internet Message Format
- RFC 7208: Sender Policy Framework (SPF)
- RFC 6376: DomainKeys Identified Mail (DKIM)
- RFC 7489: DMARC
- FBI IC3: alertas sobre Business Email Compromise
