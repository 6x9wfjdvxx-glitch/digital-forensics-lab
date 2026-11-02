# Casos de Uso e Erros Comuns em Disco

> **Objetivo pedagógico:** consolidar o aprendizado de forense de disco com cenários corporativos realistas, os erros mais frequentes, suas consequências e as medidas de prevenção.

Os casos são fictícios e destinados ao treinamento.

## 1. Caso 1: partição apagada em notebook de executivo

**Pergunta:** o executivo manteve outro sistema operacional no equipamento?

| Fonte | Achado |
|---|---|
| `mmls` | 4 partições GPT do Windows e 120 GiB não alocados no final |
| `testdisk /list` | Assinatura de uma partição ext4 de 120 GiB na área não alocada |
| `dumpe2fs` (em cópia) | Criação em 2026-03-14 e última montagem em 2026-09-02 |
| Registro do Windows | Tabela de partições alterada em 2026-09-03 (VSS e logs) |
| Resultado | Sistema Linux de dual boot removido; conteúdo parcialmente sobrescrito pela nova partição |

**Lição:** o espaço não alocado conta a história do disco; investigue lacunas.

## 2. Caso 2: notebook com BitLocker e chave no Active Directory

**Pergunta:** como analisar o disco sem alterar a imagem?

| Etapa | Decisão |
|---|---|
| Identificação | Assinatura `-FVE-FS-` na imagem E01 |
| Autorização | Jurídico e DPO aprovam o uso da chave corporativa |
| Obtenção | A TI recupera a senha de recuperação no Active Directory pelo identificador exibido na tela de recuperação |
| Desbloqueio | `bdemount` sobre a cópia de trabalho e montagem em somente leitura |
| Registro | Trilha de acesso à chave; rotação da chave ao final do caso |

**Lição:** a chave de recuperação corporativa é a via mais rápida e auditável.

## 3. Caso 3: disco rígido com falhas progressivas

| Etapa | Resultado |
|---|---|
| Avaliação | `smartctl` com setores pendentes e realocados crescentes |
| Aquisição | ddrescue em duas fases; 99,998% lido; 84 setores não recuperados |
| Hash | Calculado sobre a imagem; fonte não verificável integralmente |
| Análise | Arquivos afetados pelos setores ilegíveis identificados e marcados |
| Relatório | Limitação declarada e arquivo de mapa preservado |

**Lição:** priorize a imagem antes que o disco se deteriore, e documente o que não foi lido.

## 4. Caso 4: SSD de colaborador após exclusão em massa

**Pergunta:** os arquivos excluídos podem ser recuperados?

| Fonte | Achado |
|---|---|
| `$UsnJrnl` | Exclusão de 12.400 arquivos entre 16:00Z e 16:12Z |
| `$MFT` | Registros livres com nomes e carimbos |
| Espaço não alocado | Em sua maioria zeros; carving sem resultados relevantes |
| Característica | SSD NVMe com TRIM habilitado |
| Corroboração | Cópias dos arquivos encontradas em backup de nuvem corporativa |
| Conclusão | Metadados comprovam a exclusão; conteúdo irrecuperável no disco por efeito de TRIM; conteúdo obtido do backup |

**Lição:** em SSD, procure o conteúdo em backups e logs, e use os metadados como prova da atividade.

## 5. Caso 5: pendrive com indícios de VeraCrypt

**Pergunta:** o colaborador guardou dados em contêiner criptografado?

| Fonte | Achado |
|---|---|
| Imagem do pendrive | Arquivo de 4 GiB sem assinatura, com alta entropia |
| Artefatos do sistema | Execução do VeraCrypt em Prefetch e Amcache; LNK para o arquivo no pendrive |
| Registro | Montagens recentes registradas (MRU) |
| Acesso ao conteúdo | Sem a senha, inviável |
| Relatório | Indícios de uso de contêiner criptografado, sem afirmar o conteúdo; recomendação de buscar a senha por via autorizada |

**Lição:** descreva indícios e limites, sem presumir o conteúdo.

## 6. Caso 6: limpeza de espaço livre antes da devolução

| Fonte | Achado |
|---|---|
| Amcache e Prefetch | Execução de ferramenta de limpeza às 17:55Z |
| `$UsnJrnl` | Criação e exclusão de milhares de arquivos temporários |
| Espaço livre | 38 GiB preenchidos por padrão repetido |
| Backups e logs | Cópias e registros que reconstituem a atividade |
| Conclusão | Limpeza deliberada de espaço livre comprovada por três fontes; recuperação por outras fontes |

**Lição:** a limpeza deixa vestígios próprios; relate fatos e use fontes alternativas.

## 7. Caso 7: servidor com RAID e disco virtual

| Etapa | Decisão |
|---|---|
| Registro | Controladora, nível RAID 5, tamanho de stripe e ordem dos discos documentados |
| Aquisição | Imagem do volume lógico apresentado pela controladora e, quando possível, dos discos membros |
| Disco virtual | VMDK de uma VM crítica copiado com os snapshots; hash calculado |
| Análise | Montagem somente leitura e comparação do snapshot anterior com o estado atual |
| Resultado | Comparação delimitou a janela de comprometimento |

**Lição:** preserve os snapshots de VMs: eles guardam estados anteriores do sistema.

## 8. Erros comuns, consequências e prevenção

| Erro | Consequência provável | Prevenção |
|---|---|---|
| Analisar a imagem original ou o disco de origem | Alteração da evidência | Cópias de trabalho verificadas e montagem somente leitura |
| Usar o tamanho de setor errado | Deslocamentos incorretos e dados ilegíveis | Verificar o tamanho de setor e informar às ferramentas |
| Executar `fsck` ou `e2fsck` na evidência | Alteração do sistema de arquivos | Nunca reparar a evidência |
| Gravar a imagem no mesmo disco de origem | Sobrescrita de dados | Destino em mídia separada |
| Confiar no hash do ddrescue sem declarar setores não lidos | Afirmação incorreta de cópia completa | Registrar o mapa e a limitação |
| Ignorar HPA e DCO | Perda de áreas ocultas | Verificar com `hdparm` na fonte |
| Esperar recuperação em SSD como em HDD | Conclusões incorretas | Considerar TRIM e declarar limitações |
| Desligar sistema com disco criptografado desbloqueado | Perda do acesso aos dados | Coleta ao vivo e captura de memória |
| Expor chaves de recuperação em relatórios | Risco de segurança | Tratar como segredos e restringir o acesso |
| Aceitar arquivos carvados sem validação | Falsos positivos e arquivos corrompidos | Validar o cabeçalho, a abertura e o contexto |
| Não corroborar com logs e backups | Conclusões frágeis | Fontes independentes |
| Executar arquivos recuperados fora de ambiente isolado | Risco de infecção | Laboratório isolado |
| Afirmar dolo a partir da limpeza de disco | Parcialidade | Relatar fatos e confiança |

## 9. Exercícios práticos

1. Crie uma imagem de teste com duas partições, apague uma e identifique-a com `mmls` e `testdisk /list`.
2. Formate um pendrive de teste em exFAT, copie e exclua arquivos, e recupere-os por metadados e por carving; compare os resultados.
3. Crie um volume LUKS e um volume com BitLocker em máquinas virtuais, e desbloqueie-os em análise com a chave de recuperação.
4. Simule uma imagem com setores ilegíveis (por exemplo, por truncamento) e registre o procedimento e as limitações.
5. Execute o script de detecção de blocos de zeros em uma imagem e interprete os resultados.
6. Analise uma imagem pública de treinamento (por exemplo, os cenários Data Leakage Case e Hacking Case do NIST CFReDS, ou o cenário M57-Patents) com o Autopsy e elabore o inventário de partições e o registro de recuperação.

## 10. Normas e frameworks relevantes

- ISO/IEC 27037:2012; ISO/IEC 27042:2015; NIST SP 800-86; NIST SP 800-88 Rev. 1
- NIST CFTT; NIST SP 800-111
- MITRE ATT&CK: T1070.004, T1485, T1561, T1564, T1486
- CIS Controls v8.1, controles 3 e 11

## 11. Referências

- Carrier, B. File System Forensic Analysis. Addison-Wesley, 2005.
- Casey, E. Digital Evidence and Computer Crime. 3. ed. Academic Press, 2011.
- NIST CFReDS: Computer Forensic Reference Data Sets (cenários de treinamento).
- Digital Corpora. Cenário M57-Patents e imagens de disco para pesquisa.
- Kissel, R. et al. NIST SP 800-88 Rev. 1. 2014.
- SANS Institute. FOR500 e FOR498.
