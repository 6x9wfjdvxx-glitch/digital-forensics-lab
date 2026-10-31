# 02 Cadeia de Custódia

## Objetivo

Definir como registrar, proteger e comprovar a história completa de posse, movimentação e manuseio das evidências, preservando sua autenticidade, sua integridade e sua admissibilidade, do reconhecimento ao descarte.

## Trilha de estudo recomendada

```mermaid
flowchart LR
    A["1. Princípios"] --> B["2. Etapas legais"]
    B --> C["3. Formulários"]
    C --> D["4. Lacre e transporte"]
    D --> E["5. Armazenamento e descarte"]
    E --> F["6. Checklist"]
    F --> G["7. Casos e erros comuns"]
```

## Conteúdo da pasta

| Ordem | Arquivo | Objetivo |
|---|---|---|
| 1 | [principios-da-cadeia-de-custodia.md](principios-da-cadeia-de-custodia.md) | Conceito, importância e princípios da custódia |
| 2 | [etapas-legais-e-equivalencia-digital.md](etapas-legais-e-equivalencia-digital.md) | As dez etapas do CPP aplicadas ao ambiente digital |
| 3 | [formularios-e-registros-de-custodia.md](formularios-e-registros-de-custodia.md) | Formulários A a F e exemplos de preenchimento |
| 4 | [lacre-embalagem-e-transporte.md](lacre-embalagem-e-transporte.md) | Embalagem, lacre, bolsa Faraday e transporte |
| 5 | [armazenamento-controle-de-acesso-e-descarte.md](armazenamento-controle-de-acesso-e-descarte.md) | Armazenamento físico e digital, acesso, retenção e descarte |
| 6 | [checklist-operacional-de-custodia.md](checklist-operacional-de-custodia.md) | Lista de verificação do ciclo completo |
| 7 | [casos-de-uso-e-erros-comuns.md](casos-de-uso-e-erros-comuns.md) | Cenários, erros comuns e exercícios |

## Convenção de identificação

| Item | Formato |
|---|---|
| Caso | DFL-AAAA-NNN |
| Evidência física | DFL-AAAA-NNN-ENNN |
| Imagem forense | DFL-AAAA-NNN-ENNN-IMGNN |
| Cópia de trabalho | DFL-AAAA-NNN-ENNN-IMGNN-WN |
| Captura de memória | DFL-AAAA-NNN-ENNN-MEMNN |
| Exportação de log | DFL-AAAA-NNN-LNNN |

## Princípios

- Identificação única de cada item
- Continuidade da posse, sem lacunas
- Integridade comprovada por lacre e hash
- Registro no momento da ação, com horários em UTC
- Mínimo manuseio, com trabalho em cópias
- Armazenamento seguro, com acesso por mínimo privilégio

## Relação com outras pastas

- 01-fundamentos: princípios, fases e modelo de abertura de caso
- Pastas de coleta, hash e linha do tempo: aplicam a custódia às aquisições e às análises
- Pastas de relatórios e playbooks: anexam os formulários e os hashes aos entregáveis

## Referências

- Código de Processo Penal, arts. 158-A a 158-F (Lei nº 13.964/2019)
- Código de Processo Civil, arts. 369, 384, 422 e 473
- Portaria SENASP/MJ nº 82/2014
- ABNT NBR ISO/IEC 27037:2013
- NIST IR 8387: Digital Evidence Preservation (2022)
- NIST SP 800-88 Rev. 1: Guidelines for Media Sanitization (2014)
- ISO/IEC 27002:2022, controles 5.28, 5.33, 7.10 e 7.14
