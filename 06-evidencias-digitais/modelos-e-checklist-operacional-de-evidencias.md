# Modelos e Checklist Operacional de Evidências

> **Objetivo pedagógico:** fornecer a ficha de evidência, a matriz de relevância, o modelo de laudo de autenticidade e uma lista de verificação executável para tratar cada evidência digital com rastreabilidade e rigor.

## 1. Modelo A: Ficha de Evidência Digital

| Campo | Preenchimento |
|---|---|
| Identificador | DFL-AAAA-NNN-ENNN (ou LNNN, WNNN) |
| Caso | |
| Descrição | |
| Tipo (documento, e-mail, mensagem, web, log, mídia, banco de dados, nuvem, outro) | |
| Classificação (estado, origem, relação com o fato, sensibilidade) | |
| Fonte e local de origem | |
| Método de obtenção | |
| Autorização e base legal (referência) | |
| Data e hora da obtenção (UTC) | |
| Responsável pela obtenção | |
| Ferramenta e versão | |
| Hash (algoritmo e valor) | |
| Metadados relevantes | |
| Local de armazenamento | |
| Cadeia de custódia (referência aos formulários) | |
| Dados pessoais ou sensíveis | Sim / Não; tratamento aplicado |
| Limitações conhecidas | |

## 2. Modelo B: Matriz de Relevância e Peso

| ID | Evidência | Pergunta investigativa | Relevância (alta, média, baixa) | Origem | Integridade | Autenticidade | Corroboração | Confiança | Observações |
|---|---|---|---|---|---|---|---|---|---|
| E001 | | Q1 | | | | | | | |
| L001 | | Q2 | | | | | | | |

## 3. Modelo C: Laudo de Autenticidade (estrutura)

```
LAUDO DE AUTENTICIDADE DE EVIDÊNCIA DIGITAL

1. IDENTIFICAÇÃO
   Caso: DFL-AAAA-NNN          Evidência: DFL-AAAA-NNN-ENNN
   Solicitante: ____________   Responsável técnico: ____________   Data: ____/____/______

2. OBJETO E QUESITOS
   Descrição do objeto: __________________________________________
   Quesitos ou perguntas: Q1 ______  Q2 ______  Q3 ______

3. MATERIAL EXAMINADO
   Itens recebidos, número de lacre, estado, hashes de recebimento.

4. MÉTODO
   Procedimentos, ferramentas, versões e parâmetros; validação das ferramentas.

5. EXAME E RESULTADOS
   5.1 Integridade (hashes, comparação com registros da coleta)
   5.2 Origem e autoria (contas, dispositivos, assinaturas, metadados)
   5.3 Consistência temporal (relógios, fusos, correlação)
   5.4 Consistência técnica (estrutura do arquivo, indícios de edição)
   5.5 Corroboração por fontes independentes

6. INTERPRETAÇÃO E GRAU DE CONFIANÇA
   Conclusão por quesito: __________________________________________
   Confiança: ( ) Alta ( ) Média ( ) Baixa ( ) Inconclusiva
   Hipóteses alternativas consideradas: ______________________________

7. LIMITAÇÕES
   __________________________________________________________________

8. RESPOSTA AOS QUESITOS
   Q1: __________   Q2: __________   Q3: __________

9. ANEXOS
   Cadeia de custódia, relatórios de ferramentas, hashes, capturas, scripts.

Local e data: ____________________
Assinatura do responsável técnico: ____________________
Revisão por pares: ____________________
```

## 4. Exemplo preenchido: Ficha de Evidência (fictício)

| Campo | Preenchimento |
|---|---|
| Identificador | DFL-2026-001-W001 |
| Caso | DFL-2026-001 |
| Descrição | Captura da publicação ofensiva no perfil X, com comentários |
| Tipo | Web |
| Classificação | Armazenada, gerada por pessoa, direta, confidencial |
| Fonte | https://exemplo.com/perfil/publicacao-123 |
| Método | Captura em WARC, PDF e imagem; ata notarial |
| Autorização | Termo TA-2026-018; orientação do Jurídico |
| Data e hora (UTC) | 2026-10-31T10:05:00Z |
| Responsável | Analista A |
| Ferramenta | Captura técnica com versão registrada; navegador com versão registrada |
| Hash | SHA-256 do arquivo WARC e do manifesto |
| Armazenamento | Repositório imutável do caso |
| Reforço | Ata notarial nº 123, Cartório Exemplo, 2026-10-31; carimbo do tempo aplicado |
| Dados pessoais | Sim (perfil e comentários de terceiros); acesso restrito |
| Limitações | Conteúdo de mensagens privadas não acessado |

## 5. Exemplo preenchido: Matriz de Relevância (fictício)

| ID | Evidência | Pergunta | Relevância | Integridade | Autenticidade | Corroboração | Confiança |
|---|---|---|---|---|---|---|---|
| W001 | Publicação capturada | Q1: Quem publicou? | Alta | Demonstrada | Parcial (conta) | Ata notarial | Média |
| L001 | Registros de acesso da plataforma | Q1 | Alta | Demonstrada | Alta (provedor) | Correlação com IP | Alta |
| E010 | Notebook do investigado | Q2: Houve acesso à conta? | Média | Demonstrada | Alta | Logs e artefatos | Média |

## 6. Checklist operacional

**Caso:** DFL-AAAA-NNN
**Responsável:** ____________________
**Data e hora (UTC):** ____________________

### 6.1 Antes de obter a evidência

- [ ] Autorização e base legal registradas
- [ ] Perguntas investigativas e pertinência avaliadas
- [ ] Escopo e minimização definidos
- [ ] DPO e Jurídico consultados quando houver dados pessoais ou comunicações privadas
- [ ] Método de obtenção escolhido conforme o tipo (fonte primária, captura técnica, extração forense)

### 6.2 Obtenção e preservação

- [ ] Fonte original preferida a impressões e reproduções
- [ ] Contexto registrado (URL, conta, dispositivo, data e hora em UTC)
- [ ] Ferramentas e versões registradas
- [ ] Hash calculado e manifesto gerado
- [ ] Metadados preservados
- [ ] Ata notarial, assinatura ou carimbo do tempo avaliados para conteúdo crítico
- [ ] Cadeia de custódia iniciada (pasta 02)
- [ ] Preservação de logs de retenção curta solicitada, quando necessário

### 6.3 Avaliação

- [ ] Licitude, pertinência, autenticidade, integridade e confiabilidade avaliadas
- [ ] Sinais de manipulação analisados (pasta 05)
- [ ] Corroboração por fontes independentes buscada
- [ ] Hipóteses alternativas consideradas
- [ ] Grau de confiança atribuído e justificado
- [ ] Ficha de Evidência e Matriz de Relevância preenchidas

### 6.4 Apresentação

- [ ] Relatório adequado ao público
- [ ] Fato, inferência e opinião separados
- [ ] Achados exculpatórios incluídos
- [ ] Limitações declaradas
- [ ] Anexos: hashes, custódia, scripts e capturas
- [ ] Revisão por pares e revisão jurídica realizadas

### 6.5 Encerramento

- [ ] Evidências armazenadas com controle de acesso e imutabilidade
- [ ] Retenção e descarte definidos, considerando legal hold
- [ ] Lições aprendidas registradas

## 7. Resultado da verificação

| Resultado | Condição |
|---|---|
| Conforme | Todos os itens aplicáveis marcados |
| Conforme com ressalvas | Pendências sem impacto na integridade e na autenticidade, com plano de ação |
| Não conforme | Obtenção sem autorização, ausência de hash e de custódia, ou conclusão sem corroboração; comunicar o líder e o Jurídico |

**Assinatura do responsável:** ____________________
**Assinatura do revisor:** ____________________

## 8. Normas e frameworks relevantes

- ISO/IEC 27037:2012; ISO/IEC 27041:2015; ISO/IEC 27042:2015
- NIST SP 800-86; NIST IR 8387
- CPC, art. 473; CPP, arts. 157 e 158-A a 158-F
- ISO/IEC 17025:2017 (relatórios técnicos)

## 9. Referências

- ABNT NBR ISO/IEC 27037:2013.
- ISO/IEC 27042:2015.
- Brasil. CPC, art. 473; CPP, arts. 157 e 158-A a 158-F.
- Casey, E. Digital Evidence and Computer Crime. 3. ed. 2011.
