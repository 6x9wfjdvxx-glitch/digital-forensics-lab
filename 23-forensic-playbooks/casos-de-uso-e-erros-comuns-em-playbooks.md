# Casos de Uso e Erros Comuns em Playbooks

> **Objetivo pedagógico:** consolidar o aprendizado sobre playbooks forenses com cenários realistas de uso e de falha, os erros mais frequentes na elaboração e na execução, suas consequências e as medidas de prevenção.

Os casos são fictícios e destinados ao treinamento.

## 1. Caso 1: o playbook de preservação salva logs que expirariam

| Fato | Detalhe |
|---|---|
| Situação | Denúncia de acesso indevido a uma conta de nuvem, 80 dias após o primeiro indício |
| Ação | O plantão executou o PB-01 e identificou que o histórico de eventos de 90 dias expiraria em 10 dias e que a telemetria do EDR tinha 30 dias de retenção |
| Resultado | Os logs foram exportados e protegidos no mesmo dia; sem o playbook, o início da atividade teria sido perdido |

**Lição:** a tabela de retenções embutida no playbook transforma uma decisão difícil em um passo simples.

## 2. Caso 2: playbook desatualizado orienta o desligamento errado

| Fato | Detalhe |
|---|---|
| Situação | O playbook antigo recomendava "desligar imediatamente" estações comprometidas |
| Consequência | Uma estação com BitLocker foi desligada sem a chave de recuperação à mão; a aquisição do disco atrasou 3 dias; a memória foi perdida |
| Revisão | O PB-02 foi reescrito com a decisão sobre criptografia de disco, a obtenção de chaves e a preferência por isolar antes de desligar |

**Lição:** playbooks precisam ser revisados com a evolução das tecnologias; a ausência de data de revisão é um sinal de risco.

## 3. Caso 3: automação remove e-mails antes da preservação

| Fato | Detalhe |
|---|---|
| Situação | Uma automação de resposta a phishing removia as mensagens das caixas assim que um usuário as reportava |
| Consequência | Em um caso de BEC, as mensagens originais foram removidas antes da preservação, e o rastreamento de mensagens não continha o conteúdo |
| Correção | A automação passou a preservar (exportar a mensagem e os metadados) antes de remover, e a remoção ficou sujeita à aprovação nos casos de gravidade alta |

**Lição:** automatize o que informa; peça aprovação e preserve antes do que altera.

## 4. Caso 4: ausência de portão legal em uma investigação interna

| Fato | Detalhe |
|---|---|
| Situação | Um analista, a pedido de um gestor, copiou a caixa de e-mail e o histórico de navegação de um colaborador sem autorização do Jurídico e do RH |
| Consequência | A prova foi questionada, houve reclamação trabalhista e risco de sanções por violação de privacidade |
| Correção | O PB-14 passou a exigir, no passo 1, a autorização formal do Jurídico, do RH e do DPO, com escopo escrito |

**Lição:** os portões legais protegem as pessoas, a prova e a organização; devem ser os primeiros passos.

## 5. Caso 5: exercício de mesa revela lacunas de acesso

| Fato | Detalhe |
|---|---|
| Situação | Em um exercício de ransomware, o time tentou abrir o playbook e a lista de contatos, hospedados nos sistemas "afetados" |
| Achados | Sem cópia offline; contatos de fornecedores desatualizados; ninguém sabia quem podia aprovar a decisão de isolar o ERP |
| Correções | Cópia offline do catálogo e dos contatos; RACI atualizado, com substitutos; canal fora de banda definido |

**Lição:** teste o acesso ao playbook em condições de crise, e não apenas o conteúdo.

## 6. Caso 6: playbook enxuto reduz o tempo de contenção de BEC

| Fato | Detalhe |
|---|---|
| Situação | Fraude de pagamento por e-mail; o Financeiro foi informado após 6 horas no incidente anterior |
| Mudança | O PB-32 passou a incluir, como **passo 5**, o aviso imediato ao Financeiro e ao banco, em paralelo à análise |
| Resultado | No incidente seguinte, o banco foi acionado em 40 minutos e interceptou o pagamento |

**Lição:** coloque as ações que reduzem perdas no início, em paralelo à análise.

## 7. Caso 7: playbook longo demais não é seguido

| Fato | Detalhe |
|---|---|
| Situação | Um playbook de 28 páginas, com todos os detalhes técnicos, era ignorado pelo plantão |
| Diagnóstico | Misturava estratégia, decisões e comandos; nenhum analista lia durante um incidente |
| Correção | Divisão em um playbook tático de 2 páginas, com links para runbooks técnicos; checklists para os passos críticos |

**Lição:** playbooks táticos curtos, com detalhes em runbooks, são mais usados.

## 8. Erros comuns, consequências e prevenção

| Erro | Consequência provável | Prevenção |
|---|---|---|
| Playbook sem dono, sem data de revisão e sem versão | Desatualização e uso de instruções erradas | Metadados obrigatórios e catálogo com revisão periódica |
| Passos vagos ("avalie a situação") | Decisões inconsistentes | Critérios objetivos e ramificações claras |
| Ordem errada (conter antes de preservar) | Perda de evidências | Ordem de volatilidade e preservação antes de ações que alteram |
| Falta de portões legais e de privacidade | Provas inválidas e violações da LGPD | Portões explícitos nos primeiros passos |
| Não registrar o estado anterior antes de alterar | Impossibilidade de reverter ou de provar | Passo de exportação da configuração |
| Mistura de níveis (estratégia e comandos no mesmo texto) | Documento longo e não usado | Playbook tático curto e runbooks técnicos |
| Playbook acessível somente nos sistemas afetados | Inutilizável na crise | Cópia offline e acesso fora de banda |
| Não testar (leitura, mesa e técnico) | Falhas descobertas no incidente real | Programa de testes com ações corretivas |
| Automação sem preservação, sem limites e sem aprovação | Danos em larga escala e perda de evidências | Classificação das ações e salvaguardas |
| Contatos e RACI desatualizados | Atrasos nas decisões | Verificação trimestral e substitutos |
| Ignorar as lições aprendidas | Repetição dos mesmos erros | Revisão pós-uso obrigatória |
| Playbooks escritos sem a participação de quem executa | Passos inviáveis | Elaboração conjunta e testes |
| Comandos sem validação de versão e de permissão | Falhas durante o uso | Runbooks testados e versionados |
| Falta de treinamento | Playbooks não utilizados | Treinamento de novos membros e exercícios periódicos |
| Playbook que prevê acesso excessivo (privilégios amplos) | Risco e falta de rastreabilidade | Privilégios mínimos e contas nominais |

## 9. Exercícios práticos

1. Escolha um cenário não coberto (por exemplo, perda de laptop com dados pessoais) e escreva um playbook completo com o modelo do arquivo 1, incluindo portões legais, evidências e escalonamento.
2. Faça uma **leitura guiada** do PB-02 com um colega e registre as ambiguidades e as lacunas; proponha melhorias.
3. Realize um **exercício de mesa** de 60 minutos com um dos cenários sugeridos (arquivo 7), usando o relatório de teste (modelo B).
4. Execute um **exercício técnico** dos playbooks PB-12 e PB-13 em uma VM de laboratório, medindo o tempo e a completude das evidências.
5. Escreva a matriz RACI do PB-30 e verifique se há substitutos para cada função.
6. Classifique as ações de um playbook existente em "informativas" e "alteradoras", e proponha onde a automação seria permitida e onde exigiria aprovação.
7. Revise o catálogo da sua organização (ou um fictício): identifique playbooks sem dono, sem revisão ou sem teste, e priorize correções.
8. Faça um teste de acessibilidade: abra o catálogo e os contatos sem acesso aos sistemas principais.

Use somente ambientes de laboratório e dados fictícios nos exercícios técnicos.

## 10. Normas e frameworks relevantes

- NIST SP 800-61 Rev. 3; NIST SP 800-84; NIST CSF 2.0
- ISO/IEC 27035-1, 27035-2 e 27035-3; ISO/IEC 27037; ISO 22301
- CISA Tabletop Exercise Packages; FIRST CSIRT Services Framework
- LGPD, arts. 6º, 46, 48 e 50

## 11. Referências

- CISA. Cybersecurity Incident & Vulnerability Response Playbooks (2021) e CTEP.
- NIST SP 800-84 (2006); NIST SP 800-61 Rev. 3 (2025).
- Microsoft, AWS e Google Cloud. Guias e playbooks públicos de resposta a incidentes.
- Pastas 01 a 22 deste repositório (fundamentos técnicos dos playbooks).
