# 04 Hash e Integridade

## Objetivo

Padronizar o uso de funções de hash e de mecanismos complementares (manifestos, assinatura, carimbo do tempo, verificação periódica) para comprovar a integridade das evidências durante todo o seu ciclo de vida, da aquisição ao arquivamento.

## Trilha de estudo recomendada

```mermaid
flowchart LR
    A["1. Fundamentos de hash"] --> B["2. Aquisição e verificação"]
    B --> C["3. Manifestos e assinatura"]
    C --> D["4. Listas e NSRL"]
    D --> E["5. Hash difuso"]
    E --> F["6. Armazenamento e nuvem"]
    F --> G["7. Checklist"]
    G --> H["8. Casos e erros comuns"]
```

## Conteúdo da pasta

| Ordem | Arquivo | Objetivo |
|---|---|---|
| 1 | [fundamentos-de-hash-e-funcoes-criptograficas.md](fundamentos-de-hash-e-funcoes-criptograficas.md) | Propriedades, algoritmos, quebras históricas e como argumentar |
| 2 | [hash-em-aquisicao-copia-e-verificacao.md](hash-em-aquisicao-copia-e-verificacao.md) | Hash na aquisição, cópia, transferência e divergências |
| 3 | [manifestos-de-hash-assinatura-e-carimbo-do-tempo.md](manifestos-de-hash-assinatura-e-carimbo-do-tempo.md) | Manifestos, hashdeep, GPG, ICP-Brasil e RFC 3161 |
| 4 | [listas-de-hash-nsrl-e-filtragem.md](listas-de-hash-nsrl-e-filtragem.md) | NSRL, filtragem, IOCs por hash e limites |
| 5 | [hash-difuso-e-similaridade.md](hash-difuso-e-similaridade.md) | ssdeep, sdhash, TLSH, imphash e hashes perceptuais |
| 6 | [integridade-em-armazenamento-transferencia-e-nuvem.md](integridade-em-armazenamento-transferencia-e-nuvem.md) | Fixity, imutabilidade, transferência e nuvem |
| 7 | [checklist-operacional-de-hash-e-integridade.md](checklist-operacional-de-hash-e-integridade.md) | Lista de verificação do ciclo completo |
| 8 | [casos-de-uso-e-erros-comuns-em-hash.md](casos-de-uso-e-erros-comuns-em-hash.md) | Sete cenários, erros comuns e exercícios |

## Princípios

- SHA-256 como algoritmo padrão, com segundo algoritmo em casos de maior risco
- Registrar sempre o algoritmo junto com o valor, a data (UTC), o responsável e a ferramenta
- Calcular hash na origem e no destino em toda cópia ou transferência
- Proteger manifestos e hashes com assinatura, imutabilidade e, quando cabível, carimbo do tempo
- Verificar periodicamente o armazenamento e tratar toda divergência como incidente de integridade
- Usar hash difuso como indício, e não como prova de identidade

## Relação com outras pastas

- 01-fundamentos: princípios de integridade e documentação
- 02-cadeia-de-custodia: formulários e verificação de hash em cada transferência
- 03-coleta-de-evidencias: cálculo de hash na coleta e na aquisição
- Pastas de malware, memória, disco e deepfake: uso de hash e de similaridade na análise

## Referências

- NIST FIPS 180-4: Secure Hash Standard (2015) e FIPS 202: SHA-3 Standard (2015)
- NIST SP 800-131A Rev. 2: Transitioning the Use of Cryptographic Algorithms (2019)
- NIST IR 8387: Digital Evidence Preservation (2022)
- ISO/IEC 27037:2012 (ABNT NBR ISO/IEC 27037:2013)
- RFC 3161: Time-Stamp Protocol; RFC 2104: HMAC
- NIST National Software Reference Library (NSRL)
- Kornblum, J. (2006); Roussev, V. (2010); Oliver, J.; Cheng, C.; Chen, Y. (2013)
- NDSA: Levels of Digital Preservation
- Wang, X.; Yu, H. (2005); Stevens, M. et al. (2017); Leurent, G.; Peyrin, T. (2020)
