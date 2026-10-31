# Formulários e Registros de Custódia

> **Objetivo pedagógico:** fornecer formulários prontos para uso, demonstrar o preenchimento correto de cada campo e reduzir o risco de lacunas no registro da cadeia de custódia.

## 1. Convenções

| Item | Convenção |
|---|---|
| Identificador do caso | `DFL-AAAA-NNN` |
| Identificador de evidência física | `DFL-AAAA-NNN-ENNN` |
| Identificador de imagem | `DFL-AAAA-NNN-ENNN-IMGNN` |
| Cópia de trabalho | `DFL-AAAA-NNN-ENNN-IMGNN-WN` |
| Captura de memória | `DFL-AAAA-NNN-ENNN-MEMNN` |
| Exportação de log | `DFL-AAAA-NNN-LNNN` |
| Data e hora | ISO 8601 em UTC, por exemplo `2026-10-30T14:05:12Z` |
| Hash | SHA-256, em hexadecimal minúsculo |
| Lacre | Número único de série impresso, sem reutilização |

Regras: preencher com caneta ou digitalmente no momento da ação; não deixar campos em branco (usar "N/A" com justificativa); não rasurar (corrigir com risco simples, data e rubrica).

## 2. Formulário A: Ficha de Identificação da Evidência

| Campo | Preenchimento |
|---|---|
| Identificador da evidência | |
| Caso | |
| Tipo (dispositivo, mídia, imagem, captura de memória, log, documento) | |
| Descrição | |
| Fabricante, modelo e número de série | |
| Patrimônio ou identificação corporativa | |
| Local e condição em que foi encontrado | |
| Estado (ligado, desligado, bloqueado, em hibernação) | |
| Data e hora do reconhecimento (UTC) | |
| Relógio do sistema e diferença para UTC | |
| Responsável pelo reconhecimento | |
| Fotografias (identificadores dos arquivos) | |
| Hash (quando aplicável) | |
| Número do lacre | |
| Classificação de confidencialidade | |
| Observações | |

## 3. Formulário B: Registro de Movimentação (Cadeia de Custódia)

Uma linha por evento de posse, acesso, transferência ou rompimento de lacre.

| Nº | Data e hora (UTC) | Identificador da evidência | Ação (coleta, transporte, recebimento, acesso, análise, devolução, descarte) | De (nome e função) | Para (nome e função) | Finalidade | Lacre (antes e depois) | Hash verificado (sim ou não) | Assinatura de quem entrega | Assinatura de quem recebe |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | | | | | | | | | | |
| 2 | | | | | | | | | | |

## 4. Formulário C: Registro de Aquisição Digital

| Campo | Preenchimento |
|---|---|
| Identificador da imagem ou captura | |
| Evidência de origem | |
| Data e hora de início e fim (UTC) | |
| Analista | |
| Ferramenta e versão | |
| Parâmetros e comando | |
| Método (bloqueador de hardware, software, remoto) | |
| Modelo e série do bloqueador de escrita | |
| Formato da imagem (E01, RAW, AFF4) | |
| Tamanho (bytes) | |
| Hash SHA-256 da fonte | |
| Hash SHA-256 da imagem | |
| Resultado da verificação | Igual / Divergente |
| Erros ou setores com falha de leitura | |
| Destino de armazenamento | |
| Cópia de trabalho criada (identificador) | |
| Observações | |

## 5. Formulário D: Registro de Rompimento de Lacre

| Campo | Preenchimento |
|---|---|
| Identificador da evidência | |
| Lacre rompido (número) | |
| Novo lacre (número) | |
| Data e hora (UTC) e local | |
| Responsável pelo rompimento (nome e matrícula) | |
| Autorização e motivo | |
| Finalidade | |
| Fotos antes e depois | |
| Lacre rompido acondicionado no novo recipiente | Sim / Não |
| Assinatura | |

## 6. Formulário E: Termo de Transferência e Recebimento

```
TERMO DE TRANSFERÊNCIA E RECEBIMENTO DE EVIDÊNCIA

Caso: DFL-AAAA-NNN
Evidência(s): ______________________________
Origem: ______________________________    Destino: ______________________________
Data e hora de saída (UTC): ______________  Data e hora de chegada (UTC): ______________
Transportador: ______________________________
Código de rastreamento: ______________________________
Natureza do exame: ______________________________
Estado do lacre na saída: ( ) íntegro  Nº ________
Estado do lacre na chegada: ( ) íntegro  ( ) rompido (descrever): ______________________
Hash conferido na chegada: ( ) sim, igual  ( ) divergente

Entrega: ______________________  Assinatura: ______________
Recebimento: ___________________  Assinatura: ______________
Observações: ______________________________
```

## 7. Formulário F: Termo de Descarte

| Campo | Preenchimento |
|---|---|
| Identificadores descartados | |
| Autorização do Jurídico (referência) | |
| Verificação de legal hold e prazos | Sem pendências / Pendências |
| Autorização da autoridade, quando aplicável | |
| Método (destruição física, apagamento seguro, destruição criptográfica) | |
| Data e hora (UTC) | |
| Responsável pelo descarte | |
| Testemunha | |
| Certificado ou evidência do descarte | |
| Assinaturas | |

## 8. Exemplo preenchido: Registro de Movimentação (fictício)

| Nº | Data e hora (UTC) | Evidência | Ação | De | Para | Finalidade | Lacre | Hash verificado |
|---|---|---|---|---|---|---|---|---|
| 1 | 2026-10-30T14:55Z | DFL-2026-001-E001 | Acondicionamento | Analista A | Analista A | Embalar e lacrar | Aplicado nº 000123 | Não se aplica |
| 2 | 2026-10-30T15:20Z | DFL-2026-001-E001 | Transporte | Analista A | Custodiante B | Entrega ao laboratório | Nº 000123 íntegro | Não se aplica |
| 3 | 2026-10-30T15:50Z | DFL-2026-001-E001 | Recebimento e armazenamento | Analista A | Custodiante B | Guarda em cofre | Nº 000123 íntegro | Não se aplica |
| 4 | 2026-10-31T09:10Z | DFL-2026-001-E001-IMG01 | Acesso para análise | Custodiante B | Analista C | Criar cópia de trabalho W1 | Não se aplica | Sim, igual |

## 9. Exemplo preenchido: Registro de Aquisição Digital (fictício)

| Campo | Preenchimento |
|---|---|
| Identificador | DFL-2026-001-E001-IMG01 |
| Origem | DFL-2026-001-E001 (SSD NVMe 512 GB) |
| Início e fim (UTC) | 2026-10-30T14:10Z a 14:42Z |
| Ferramenta e versão | Registrar o nome e a versão exatos usados |
| Método | Bloqueador de escrita de hardware (modelo e série registrados) |
| Formato | E01 |
| Hash SHA-256 da fonte | Valor calculado na aquisição |
| Hash SHA-256 da imagem | Valor calculado na verificação |
| Resultado | Igual |
| Cópia de trabalho | DFL-2026-001-E001-IMG01-W1 |

Observação: os valores de hash e de versão devem ser os reais do equipamento e da ferramenta; não os substitua por valores genéricos.

## 10. Exemplos de preenchimento inadequado

| Erro | Correção |
|---|---|
| "Notebook do João" | Identificador, patrimônio, número de série e descrição objetiva |
| "Entregue na sexta" | Data e hora em UTC com assinatura |
| Campos em branco | "N/A" com justificativa |
| Hash sem a indicação do algoritmo | `SHA-256: <valor>` |
| Assinatura de terceiro por conveniência | Apenas quem entregou ou recebeu assina |

## 11. Casos de uso corporativos

- Custódia de laptops de colaboradores em investigações internas.
- Registro de acesso a imagens forenses por analistas e peritos externos.
- Auditoria de formulários por Compliance, com amostragem de casos.

## 12. Normas e frameworks relevantes

- ISO/IEC 27037:2012 (documentação da cadeia de custódia)
- NIST IR 8387
- CPP, arts. 158-B, VII, 158-D e 158-F
- ISO/IEC 27002:2022, controles 5.28, 5.33 e 7.10
- SWGDE Best Practices for Computer Forensic Acquisitions

## 13. Referências

- ABNT NBR ISO/IEC 27037:2013.
- NIST IR 8387. 2022.
- Brasil. CPP, arts. 158-A a 158-F.
- ISO 8601: Date and time format.
- SWGDE. Best Practices for Computer Forensic Acquisitions.
- Sammons, J. The Basics of Digital Forensics. 2. ed. Syngress, 2014.
