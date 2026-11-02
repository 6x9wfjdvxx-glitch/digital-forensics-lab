# 10 Forense de Disco

## Objetivo

Adquirir, validar e analisar discos e mídias (HDD, SSD, NVMe, removíveis, RAID e discos virtuais), compreendendo esquemas de partição, sistemas de arquivos, criptografia, recuperação de dados e anti-forense, de modo a obter conclusões íntegras, reproduzíveis e com limitações declaradas.

## Trilha de estudo recomendada

```mermaid
flowchart LR
    A["1. Armazenamento e partições"] --> B["2. Sistemas de arquivos"]
    B --> C["3. Aquisição e casos especiais"]
    C --> D["4. Criptografia de disco"]
    D --> E["5. Recuperação e carving"]
    E --> F["6. Anti-forense, SSD e TRIM"]
    F --> G["7. Suítes, modelos e checklist"]
    G --> H["8. Casos e erros comuns"]
```

## Conteúdo da pasta

| Ordem | Arquivo | Objetivo |
|---|---|---|
| 1 | [fundamentos-de-armazenamento-e-esquemas-de-particao.md](fundamentos-de-armazenamento-e-esquemas-de-particao.md) | Tecnologias, setores, MBR, GPT, lacunas e partições apagadas |
| 2 | [sistemas-de-arquivos-comparados-e-artefatos.md](sistemas-de-arquivos-comparados-e-artefatos.md) | FAT32, exFAT, NTFS, ext4, APFS, HFS+ e ferramentas por sistema |
| 3 | [aquisicao-validacao-e-casos-especiais-de-discos.md](aquisicao-validacao-e-casos-especiais-de-discos.md) | ddrescue, SMART, HPA e DCO, SSD, NVMe, RAID e discos virtuais |
| 4 | [criptografia-de-disco-e-volumes-protegidos.md](criptografia-de-disco-e-volumes-protegidos.md) | BitLocker, FileVault, LUKS, VeraCrypt, EFS e limites legais |
| 5 | [recuperacao-carving-e-espaco-nao-alocado.md](recuperacao-carving-e-espaco-nao-alocado.md) | Recuperação por metadados e carving, slack e validação |
| 6 | [anti-forense-ssd-trim-e-limpeza-segura.md](anti-forense-ssd-trim-e-limpeza-segura.md) | Apagamento, TRIM, sanitização e detecção de limpeza |
| 7 | [suites-forenses-ferramentas-modelos-e-checklist-de-disco.md](suites-forenses-ferramentas-modelos-e-checklist-de-disco.md) | Autopsy, buscas, validação cruzada, modelos e checklist |
| 8 | [casos-de-uso-e-erros-comuns-em-disco.md](casos-de-uso-e-erros-comuns-em-disco.md) | Sete cenários, erros comuns e exercícios |

## Princípios

- Preservar a imagem original e trabalhar em cópias montadas em somente leitura
- Registrar o tamanho do setor, os deslocamentos, as ferramentas e os hashes
- Investigar lacunas, áreas ocultas (HPA e DCO) e partições apagadas
- Considerar SSD, TRIM e criptografia ao estimar o que pode ser recuperado
- Obter chaves por vias autorizadas e tratá-las como segredos
- Validar achados críticos com uma segunda ferramenta e corroborar com logs, memória e backups
- Relatar fatos e grau de confiança, sem presumir intenção

## Relação com outras pastas

- 02-cadeia-de-custodia e 04-hash-e-integridade: custódia, lacre e verificação de imagens
- 03-coleta-de-evidencias: procedimento geral de aquisição
- 05-timeline-analysis: linha do tempo a partir de MFT, USN e artefatos
- 07-windows-forensics e 08-linux-forensics: artefatos de sistema que complementam a análise de disco
- 09-memory-forensics: chaves de criptografia e dados voláteis relacionados

## Referências

- Carrier, B. File System Forensic Analysis. Addison-Wesley (2005)
- Casey, E. Digital Evidence and Computer Crime. 3. ed. (2011)
- Hansen, K.; Toolan, F. Decoding the APFS file system. Digital Investigation (2017)
- Garfinkel, S. Carving contiguous and fragmented files with fast object validation (2007)
- NIST SP 800-86 (2006); NIST SP 800-88 Rev. 1 (2014); NIST SP 800-111 (2007)
- NIST CFTT e NIST CFReDS; SWGDE Best Practices for Computer Forensic Acquisitions
- ISO/IEC 27037:2012; ISO/IEC 27042:2015
- UEFI Specification (GPT); Apple File System Reference
- Documentação do The Sleuth Kit, Autopsy, libyal, ddrescue, cryptsetup, bulk_extractor e PhotoRec
- SANS Institute. FOR500, FOR498 e FOR518
