# Casos de Uso e Erros Comuns em Hash

> **Objetivo pedagógico:** consolidar o aprendizado sobre hash e integridade com cenários corporativos, os erros mais frequentes, suas consequências e as medidas de prevenção.

Os casos são fictícios e destinados ao treinamento.

## 1. Caso 1: hash diferente após a cópia de uma imagem

**Contexto:** após copiar uma imagem E01 de 800 GB para o servidor de análise, o hash calculado difere do registrado.

| Etapa | Decisão |
|---|---|
| Isolar | Não analisar a cópia divergente |
| Verificar | Recalcular o hash na origem e no destino e executar `ewfverify` |
| Hipóteses | Falha de rede, cabo ou disco de destino; transferência interrompida |
| Ação | Retransmitir com verificação; se a origem estiver íntegra, descartar a cópia defeituosa |
| Registro | Ocorrência, causa e resultado no Formulário B |

**Lição:** o hash do original, preservado e verificado, é o que permite descartar a cópia defeituosa sem prejudicar a prova.

## 2. Caso 2: contestação do uso de MD5 em juízo

**Contexto:** a parte contrária alega que o MD5 usado em uma imagem antiga é "quebrado" e que a prova poderia ter sido substituída.

| Argumento | Resposta técnica |
|---|---|
| "MD5 é inseguro" | Colisões exigem que o atacante controle a criação dos dois arquivos; substituir uma evidência existente exige ataque de segunda pré-imagem, sem método prático conhecido |
| "Podem ter trocado o arquivo" | Cadeia de custódia, lacre, logs de acesso e armazenamento imutável sustentam a integridade |
| "Falta confiabilidade" | Calcular agora o SHA-256 do arquivo íntegro e compará-lo com a cópia armazenada, documentando a verificação |

**Lição:** adote SHA-256 como padrão e mantenha registros complementares; a integridade se prova pelo conjunto de controles, e não por um único hash.

## 3. Caso 3: documento vazado com alterações

**Contexto:** documento confidencial aparece em um site externo com formatação diferente.

| Etapa | Decisão |
|---|---|
| Hash criptográfico | Diferente do original, como esperado |
| Hash difuso | ssdeep e TLSH indicam alta similaridade |
| Metadados | Comparar autor, datas e propriedades |
| Conclusão | Cópia derivada com alterações; relatório com método, escores e grau de confiança |

**Lição:** o hash criptográfico só encontra cópias idênticas; use similaridade para variantes e declare a incerteza.

## 4. Caso 4: IOC por hash não detecta a variante do malware

**Contexto:** a lista de hashes de um alerta não encontra nada, mas há suspeita de infecção.

| Etapa | Decisão |
|---|---|
| Diagnóstico | O atacante recompilou o binário; o hash mudou |
| Técnica complementar | ssdeep, imphash, regras YARA e busca por comportamento (conexões, persistência) |
| Resultado | Detecção da variante por similaridade e por indicadores de comportamento |
| Ação | Atualizar a base de IOCs e as detecções |

**Lição:** hashes têm baixa durabilidade como IOC; combine com indicadores mais duráveis.

## 5. Caso 5: hash de diretório que "muda" a cada cópia

**Contexto:** o analista calcula o hash de uma pasta compactada em dois momentos e obtém valores diferentes, mesmo sem alteração de conteúdo.

| Etapa | Decisão |
|---|---|
| Causa | O arquivo compactado inclui datas, ordem e metadados que variam a cada criação |
| Correção | Gerar manifesto por arquivo (hash de cada arquivo) com ordem determinística, em vez de hash do compactado, ou preservar o arquivo compactado original sem recriá-lo |
| Prevenção | Calcular o hash do arquivo compactado imediatamente após a criação e preservá-lo |

**Lição:** hash de arquivo compactado muda quando ele é recriado; use manifestos por arquivo.

## 6. Caso 6: arquivo de texto com hash diferente por quebra de linha

**Contexto:** um relatório em texto tem hash diferente depois de ser enviado por e-mail e salvo em outro sistema.

| Etapa | Decisão |
|---|---|
| Causa | Conversão automática de quebras de linha (LF e CRLF) ou de codificação |
| Verificação | Comparar com `diff` e com visualizador hexadecimal |
| Correção | Transferir em modo binário ou em contêiner compactado; calcular o hash antes e depois |
| Prevenção | Para evidências, evitar ferramentas que alterem o conteúdo (por exemplo, controle de versão com conversão automática de linhas) |

**Lição:** o hash é sensível a cada byte, incluindo quebras de linha.

## 7. Caso 7: exportação de logs de nuvem sem hash

**Contexto:** logs de M365 foram exportados e enviados por e-mail ao Jurídico sem registro de hash.

| Etapa | Decisão |
|---|---|
| Problema | Impossível demonstrar que o arquivo recebido é o original exportado |
| Correção | Recalcular o hash do arquivo preservado na origem, documentar a exportação (comando, horário, conta) e reenviar com manifesto assinado |
| Prevenção | Calcular o hash no momento da exportação e arquivar em repositório imutável |

**Lição:** hash e registro da exportação devem ser feitos na origem, no momento da coleta.

## 8. Erros comuns, consequências e prevenção

| Erro | Consequência provável | Prevenção |
|---|---|---|
| Não calcular o hash da fonte e da imagem | Impossibilidade de provar equivalência | Hash em todas as aquisições |
| Usar apenas MD5 ou SHA-1 | Fragilidade argumentativa e técnica | SHA-256 como padrão, com segundo algoritmo quando necessário |
| Registrar o valor sem o algoritmo | Verificações ambíguas | Sempre `ALGORITMO: valor` |
| Guardar o hash no mesmo local e sem proteção | Hash alterável junto com o arquivo | Manifestos separados, assinados e imutáveis |
| Calcular hash do arquivo errado ou da versão errada | Falsa conclusão de integridade | Conferir nome, caminho, tamanho e data antes de registrar |
| Comparar visualmente apenas o início do hash | Erros de comparação | Comparação automatizada completa |
| Não verificar após transferências | Corrupção não detectada | Hash na origem e no destino |
| Usar checksum (CRC) como prova | Ausência de segurança criptográfica | Hash criptográfico |
| Enviar arquivos da evidência a serviços públicos para checar o hash | Vazamento e quebra de sigilo | Consultar apenas pelo valor do hash |
| Nunca reverificar o armazenamento | Degradação não detectada | Verificação periódica agendada |
| Tratar divergência como "erro de ferramenta" sem investigar | Perda de credibilidade e possível adulteração não detectada | Procedimento formal de divergência |

## 9. Exercícios práticos

1. Calcule SHA-256 e MD5 de um arquivo de texto, altere um caractere e compare os resultados.
2. Crie uma pasta com dez arquivos, gere o manifesto, altere um arquivo, acrescente outro e identifique as diferenças pela verificação.
3. Simule a divergência de hash em uma cópia (por exemplo, truncando um arquivo) e redija o registro de ocorrência.
4. Gere hashes difusos de duas versões de um documento e interprete o escore.
5. Elabore o texto de uma resposta técnica a um questionamento sobre o uso de MD5.

## 10. Normas e frameworks relevantes

- ISO/IEC 27037:2012; NIST IR 8387; NIST SP 800-86
- NIST FIPS 180-4
- MITRE ATT&CK (IOCs e agrupamento de famílias)
- ISO/IEC 27002:2022, controles 5.33 e 8.24

## 11. Referências

- ABNT NBR ISO/IEC 27037:2013.
- NIST IR 8387. 2022.
- Wang, X.; Yu, H. How to Break MD5 and Other Hash Functions. EUROCRYPT 2005.
- Kornblum, J. Identifying almost identical files using context triggered piecewise hashing. 2006.
- Bianco, D. The Pyramid of Pain. 2013.
- Casey, E. Digital Evidence and Computer Crime. 3. ed. Academic Press, 2011.
