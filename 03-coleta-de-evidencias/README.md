# 03 Coleta de Evidências

## Objetivo

Estabelecer os métodos e cuidados para identificar, coletar e adquirir evidências digitais preservando sua integridade e respeitando os limites legais.

## Tópicos abordados

- Coleta ao vivo (live) versus coleta com o sistema desligado (dead)
- Triagem rápida e priorização de fontes (triage)
- Aquisição lógica, física e remota
- Ordem de volatilidade
- Autoridade legal, consentimento e privacidade
- Coleta em ambientes corporativos e de nuvem (introdução)

## Procedimento de referência

1. Confirmar a autorização e o escopo
2. Fotografar e documentar o ambiente e o estado dos dispositivos
3. Coletar primeiro os dados voláteis: memória, conexões e processos
4. Criar a imagem forense com bloqueador de escrita quando aplicável
5. Calcular o hash, lacrar e registrar a cadeia de custódia

## Ferramentas

- FTK Imager
- KAPE
- Velociraptor
- dc3dd e dcfldd
- ewfacquire (libewf)
- Bloqueadores de escrita de hardware

## Artefatos e saídas

- Plano de coleta
- Registro de aquisição (ferramenta, versão, horário e hash)
- Relatório de triagem

## Cuidados de integridade e legalidade

- Trabalhar sempre sobre cópias verificadas por hash, nunca sobre a evidência original
- Registrar ferramentas, versões, horários (em UTC) e responsáveis
- Manter a cadeia de custódia (pasta 02-cadeia-de-custodia) e atuar somente com autorização e base legal

## Arquivos previstos para expansão

- checklist-coleta-live.md
- checklist-aquisicao-de-disco.md
- modelo-de-registro-de-aquisicao.md

## Referências

- RFC 3227: Guidelines for Evidence Collection and Archiving (2002)
- ISO/IEC 27037:2012
- NIST SP 800-86 (2006)
- SANS FOR498: Digital Acquisition and Rapid Triage
- Lei nº 13.709/2018 (LGPD), arts. 6º e 7º
