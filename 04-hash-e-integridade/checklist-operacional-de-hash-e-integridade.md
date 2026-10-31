# Checklist Operacional de Hash e Integridade

> **Objetivo pedagógico:** oferecer uma lista de verificação executável para aplicar hash e comprovar integridade em todo o ciclo do caso, do primeiro item coletado ao arquivamento, reduzindo omissões e facilitando a auditoria.

**Caso:** DFL-AAAA-NNN
**Responsável:** ____________________
**Data e hora de início (UTC):** ____________________

## 1. Política e preparação

- [ ] Algoritmo padrão definido (SHA-256) e segundo algoritmo definido para casos de maior risco
- [ ] Ferramentas de hash validadas e versões registradas
- [ ] Modelo de registro de hashes disponível (algoritmo, valor, data, responsável)
- [ ] Local protegido definido para manifestos e hashes
- [ ] Chaves de assinatura e acesso à autoridade de carimbo do tempo disponíveis, quando aplicável

## 2. Aquisição

- [ ] Hash da fonte calculado, quando o método permite
- [ ] Hash da imagem calculado e verificado após a criação
- [ ] Hashes da fonte e da imagem comparados e iguais
- [ ] Relatório de verificação da ferramenta arquivado
- [ ] Valores registrados no Registro de Aquisição (Formulário C)
- [ ] Hashes armazenados fora do objeto e protegidos

## 3. Cópias e transferências

- [ ] Hash conferido antes de copiar a imagem
- [ ] Cópia de trabalho criada e seu hash comparado com o da imagem
- [ ] Hash enviado por canal distinto do arquivo
- [ ] Hash conferido no destino
- [ ] Original mantido na origem até a conferência
- [ ] Verificação registrada no Formulário B

## 4. Análise

- [ ] Trabalho exclusivamente em cópias verificadas
- [ ] Hashes de arquivos extraídos e de exportações registrados
- [ ] Listas de hashes (NSRL, IOCs) com versão registrada
- [ ] Hashes difusos usados apenas como indício e documentados
- [ ] Consultas externas limitadas a hashes, sem envio de arquivos da evidência

## 5. Manifestos e assinatura

- [ ] Manifesto SHA-256 gerado para o pacote de evidências
- [ ] Manifesto verificado contra o conjunto
- [ ] Manifesto assinado
- [ ] Carimbo do tempo aplicado, quando aplicável
- [ ] Manifesto armazenado em local imutável e versionado
- [ ] Versões anteriores preservadas

## 6. Armazenamento e verificação periódica

- [ ] Repositório com controle de acesso, criptografia e imutabilidade
- [ ] Pelo menos duas cópias independentes
- [ ] Verificação periódica agendada (no mínimo semestral)
- [ ] Alertas configurados para divergência
- [ ] Teste de restauração de backup realizado
- [ ] Resultado de cada verificação registrado

## 7. Divergência de hash

- [ ] Item isolado e não utilizado para análise
- [ ] Ocorrência registrada com hash esperado e obtido
- [ ] Cálculo repetido com a mesma e com outra ferramenta
- [ ] Causa investigada (leitura, cabo, transferência, adulteração)
- [ ] Restauração a partir de cópia verificada
- [ ] Líder e Jurídico comunicados, se houver suspeita de adulteração
- [ ] Ocorrência e limitações declaradas no relatório

## 8. Relato

- [ ] Hashes das evidências relevantes incluídos no relatório, com algoritmo
- [ ] Manifesto e assinatura anexados ou referenciados
- [ ] Ferramentas e versões listadas
- [ ] Limitações e divergências resolvidas descritas

## 9. Resultado da verificação

| Resultado | Condição |
|---|---|
| Conforme | Todos os itens aplicáveis marcados |
| Conforme com ressalvas | Pendências sem impacto na integridade, com plano de ação |
| Não conforme | Hash ausente ou divergente sem tratamento, manifesto sem proteção ou verificação periódica não realizada; comunicar o líder e o Jurídico |

**Assinatura do responsável:** ____________________
**Assinatura do revisor:** ____________________

## 10. Normas e frameworks relevantes

- ISO/IEC 27037:2012; NIST IR 8387; NIST SP 800-86
- NIST FIPS 180-4 e FIPS 202
- NDSA Levels of Digital Preservation
- ISO/IEC 27002:2022, controles 5.33, 8.13 e 8.24

## 11. Referências

- ABNT NBR ISO/IEC 27037:2013.
- NIST IR 8387. 2022.
- NIST FIPS 180-4. 2015.
- NDSA. Levels of Digital Preservation.
