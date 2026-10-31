# Princípios da Cadeia de Custódia

> **Objetivo pedagógico:** compreender o que é a cadeia de custódia, por que ela determina a confiabilidade e o valor probatório da evidência digital e quais princípios devem ser aplicados em investigações corporativas, periciais e judiciais.

## 1. Conceito

Cadeia de custódia é o conjunto de procedimentos utilizados para manter e documentar a história cronológica do vestígio, rastreando sua posse e seu manuseio desde o reconhecimento até o descarte. No processo penal brasileiro, o conceito está no art. 158-A do Código de Processo Penal (CPP), inserido pela Lei nº 13.964/2019.

Em termos práticos, a cadeia de custódia responde, para cada item, às perguntas:

| Pergunta | Registro correspondente |
|---|---|
| Quem teve a posse ou o acesso? | Nome, matrícula, função e assinatura |
| Quando? | Data e hora com fuso (preferencialmente UTC) |
| Onde estava e para onde foi? | Local de origem, destino e transporte |
| Por quê? | Finalidade do acesso ou da transferência |
| Em que estado estava? | Descrição, fotos, lacre e hash |
| O que foi feito? | Ações realizadas, ferramentas e versões |

## 2. Por que a cadeia de custódia importa

- **Autenticidade:** demonstra que a evidência apresentada é a mesma que foi coletada.
- **Integridade:** evidencia que não houve alteração, substituição ou contaminação.
- **Admissibilidade e valor probatório:** a lacuna na custódia pode levar a questionamentos sobre a confiabilidade da prova; as consequências são avaliadas pela autoridade competente no caso concreto.
- **Responsabilização:** identifica quem manuseou cada item em cada momento.
- **Defensabilidade em ambiente corporativo:** sustenta decisões disciplinares, ações trabalhistas, litígios e respostas a reguladores.

## 3. Aplicação: criminal, civil e corporativa

| Contexto | Base | Observação |
|---|---|---|
| Processo penal | CPP, arts. 158-A a 158-F | Procedimentos legais obrigatórios para vestígios |
| Processo civil | CPC, arts. 369, 384, 422 e 473 | A autenticidade de reproduções digitais pode ser impugnada e verificada por perícia |
| Investigação corporativa | ISO/IEC 27037, NIST IR 8387, políticas internas | Não se submete diretamente ao CPP, mas deve seguir padrão equivalente para preservar a possibilidade de uso judicial |
| Ordem judicial ou requisição | Determinação da autoridade | Seguir as instruções da autoridade e documentar |

Regra prática: em investigações corporativas, trate toda evidência como potencialmente destinada a um processo judicial.

## 4. Princípios

| Princípio | Descrição | Como aplicar |
|---|---|---|
| Identificação única | Cada item tem identificador exclusivo e permanente | Convenção `DFL-AAAA-NNN-ENNN` |
| Continuidade | Não há lacunas de posse entre o reconhecimento e o descarte | Registro de cada transferência com data, hora e assinaturas |
| Integridade | O conteúdo não é alterado ou a alteração é detectável | Hash SHA-256, lacre numerado, imutabilidade em armazenamento digital |
| Responsabilização | Cada pessoa responde pelo que fez e pelo que assinou | Registro nominal e assinatura |
| Rastreabilidade | A história do item pode ser reconstruída por terceiro | Formulários completos, fotos e logs de acesso |
| Mínimo manuseio | Reduzir ao estritamente necessário os acessos ao original | Trabalhar em cópias de trabalho |
| Segurança | Proteção física e lógica contra acesso indevido, perda e deterioração | Cofre, controle de acesso, criptografia e backup |
| Licitude | Obtenção e uso conforme a lei e a política | Autorização, base legal e escopo definidos |
| Contemporaneidade | O registro é feito no momento da ação | Não preencher formulários depois "de memória" |
| Proporcionalidade | Custódia compatível com a sensibilidade e o valor da evidência | Níveis de proteção por classificação |

## 5. O que o investigador deve evitar

| Conduta | Risco |
|---|---|
| Remover vestígios de local isolado antes da liberação pelo perito responsável | Pode configurar fraude processual (Código Penal, art. 347) em processos penais |
| Obter evidência em violação a norma constitucional ou legal | Prova ilícita (CPP, art. 157) |
| Alterar, substituir ou criar registros após o fato | Perda de credibilidade e responsabilidade civil, penal e funcional |
| Compartilhar a evidência em canais não controlados | Quebra de sigilo e de integridade |

## 6. Ciclo de vida da custódia

```mermaid
flowchart LR
    A["Reconhecimento"] --> B["Isolamento"]
    B --> C["Fixação"]
    C --> D["Coleta"]
    D --> E["Acondicionamento"]
    E --> F["Transporte"]
    F --> G["Recebimento"]
    G --> H["Processamento"]
    H --> I["Armazenamento"]
    I --> J["Descarte"]
    I -.-> H
```

A seta tracejada indica que o item pode retornar ao processamento (contraperícia, nova análise), sempre com novo registro de custódia.

## 7. Evidência física e evidência digital

| Aspecto | Evidência física (dispositivo, mídia) | Evidência digital (imagem, log, arquivo) |
|---|---|---|
| Identificação | Etiqueta, lacre numerado | Identificador do item e nome de arquivo padronizado |
| Integridade | Lacre inviolável, embalagem | Hash criptográfico, armazenamento imutável |
| Registro de acesso | Livro ou formulário de saída e entrada | Logs de acesso do repositório e formulário de custódia digital |
| Cópia | Duplicação forense gera novo item | A imagem é item próprio, com hash e vínculo ao original |
| Armazenamento | Cofre, central de custódia | Repositório com controle de acesso, criptografia e backup |

## 8. Exemplos práticos

### 8.1 Exemplo de identificação de itens de um caso

| Identificador | Descrição | Origem |
|---|---|---|
| DFL-2026-001-E001 | Notebook corporativo, patrimônio 123456 | Estação do colaborador |
| DFL-2026-001-E001-IMG01 | Imagem forense do SSD do E001 (E01) | Aquisição com bloqueio de escrita |
| DFL-2026-001-E001-MEM01 | Captura de memória do E001 | Coleta ao vivo |
| DFL-2026-001-E002 | Pen drive USB, lacre nº 000124 | Gaveta do colaborador |
| DFL-2026-001-L001 | Exportação do Unified Audit Log | Microsoft 365 |

### 8.2 Exemplo de lacuna e correção

| Situação | Correção |
|---|---|
| Um pen drive ficou sobre a mesa do analista por duas horas sem registro | Registrar a ocorrência, descrever a situação, verificar a integridade (lacre e hash quando aplicável), informar o líder e avaliar o impacto no relatório |

## 9. Casos de uso corporativos

- Investigação de ameaça interna com possibilidade de ação trabalhista.
- Resposta a incidente com necessidade de entregar evidências a seguradora, auditor ou autoridade.
- Apoio a perícia judicial como assistente técnico.

## 10. Normas e frameworks relevantes

- ISO/IEC 27037:2012 (ABNT NBR ISO/IEC 27037:2013): preservação e documentação da evidência
- NIST IR 8387: Digital Evidence Preservation (2022)
- ISO/IEC 27002:2022, controles 5.28 (coleta de evidências) e 5.33 (proteção de registros)
- CPP, arts. 157, 158-A a 158-F; Código Penal, art. 347; CPC, arts. 369, 384, 422 e 473
- Portaria SENASP/MJ nº 82/2014 (diretrizes de cadeia de custódia)

## 11. Referências

- Brasil. Decreto-Lei nº 3.689/1941 (CPP), com a redação da Lei nº 13.964/2019.
- Brasil. Lei nº 13.105/2015 (CPC).
- Brasil. Decreto-Lei nº 2.848/1940 (Código Penal).
- Brasil. Ministério da Justiça. SENASP. Portaria nº 82, de 16 de julho de 2014.
- ABNT NBR ISO/IEC 27037:2013.
- Nelson, A. et al. NIST IR 8387: Digital Evidence Preservation: Considerations for Evidence Handlers. NIST, 2022.
- Casey, E. Digital Evidence and Computer Crime. 3. ed. Academic Press, 2011.
- Sammons, J. The Basics of Digital Forensics. 2. ed. Syngress, 2014.
