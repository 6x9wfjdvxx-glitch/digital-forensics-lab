# 03 Coleta de Evidências

## Objetivo

Estabelecer os métodos, os cuidados e os registros para identificar, priorizar, coletar e adquirir evidências digitais preservando a integridade, respeitando a ordem de volatilidade e observando os limites legais e de privacidade.

## Trilha de estudo recomendada

```mermaid
flowchart LR
    A["1. Estratégia e triagem"] --> B["2. Dados voláteis"]
    B --> C["3. Discos e mídias"]
    C --> D["4. Coleta remota"]
    D --> E["5. Aspectos legais"]
    E --> F["6. Modelos"]
    F --> G["7. Checklist"]
    G --> H["8. Casos e erros comuns"]
```

## Conteúdo da pasta

| Ordem | Arquivo | Objetivo |
|---|---|---|
| 1 | [estrategia-de-coleta-e-triagem.md](estrategia-de-coleta-e-triagem.md) | Planejamento, priorização por valor, volatilidade e esforço, e triagem |
| 2 | [coleta-de-dados-volateis.md](coleta-de-dados-volateis.md) | Coleta ao vivo: memória, rede, processos e logs |
| 3 | [aquisicao-de-discos-e-midias.md](aquisicao-de-discos-e-midias.md) | Imagens forenses, bloqueio de escrita, criptografia, SSD, RAID e VMs |
| 4 | [coleta-remota-e-triagem-em-escala.md](coleta-remota-e-triagem-em-escala.md) | EDR, Velociraptor e KAPE em muitos endpoints |
| 5 | [aspectos-legais-e-privacidade-da-coleta.md](aspectos-legais-e-privacidade-da-coleta.md) | Autorização, LGPD, BYOD, privilégio e jurisdição |
| 6 | [modelos-de-plano-e-registro-de-coleta.md](modelos-de-plano-e-registro-de-coleta.md) | Plano, triagem, diário de coleta e relatório de coleta |
| 7 | [checklist-operacional-de-coleta.md](checklist-operacional-de-coleta.md) | Lista de verificação da fase de coleta |
| 8 | [casos-de-uso-e-erros-comuns-na-coleta.md](casos-de-uso-e-erros-comuns-na-coleta.md) | Seis cenários, erros comuns e exercícios |

## Princípios

- Coletar sob autorização, com base legal e dentro do escopo
- Priorizar por valor provável, volatilidade e esforço
- Respeitar a ordem de volatilidade e documentar cada ação em UTC
- Usar ferramentas confiáveis, validadas e executadas a partir de mídia externa
- Preservar o original, usar bloqueio de escrita e verificar sempre o hash
- Coletar o necessário e declarar as limitações

## Relação com outras pastas

- 01-fundamentos: princípios, ordem de volatilidade e abertura de caso
- 02-cadeia-de-custodia: formulários, lacre, transporte e armazenamento
- 04-hash-e-integridade: aprofunda o cálculo e a verificação de hashes
- Pastas de memória, disco, logs, rede, mobile e nuvem: análise do que foi coletado

## Referências

- NIST SP 800-86: Guide to Integrating Forensic Techniques into Incident Response (2006)
- ISO/IEC 27037:2012 (ABNT NBR ISO/IEC 27037:2013)
- RFC 3227: Guidelines for Evidence Collection and Archiving (2002)
- SWGDE: Best Practices for Computer Forensic Acquisitions
- ENFSI: Best Practice Manual for the Forensic Examination of Digital Technology (ENFSI-BPM-FIT-01)
- NIST CFTT: Computer Forensic Tool Testing Program
- Ligh, M. et al. The Art of Memory Forensics (2014)
- Carrier, B. File System Forensic Analysis (2005)
- Lei nº 13.709/2018 (LGPD); Lei nº 12.965/2014 (Marco Civil da Internet)
