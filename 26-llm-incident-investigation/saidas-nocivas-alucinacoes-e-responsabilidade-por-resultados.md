# Saídas Nocivas, Alucinações e Responsabilidade por Resultados

> **Objetivo pedagógico:** investigar incidentes em que o dano decorre da **saída** do modelo, e não de um ataque: informação incorreta (alucinações) com consequências, conteúdo nocivo ou discriminatório, difamação, reprodução de conteúdo protegido, código inseguro introduzido em sistemas, e falhas de supervisão; reconstruir o que o sistema disse e por quê, avaliar a reprodutibilidade, reunir evidências de diligência (avaliações, guardrails e supervisão humana) e compreender o enquadramento de responsabilidade.

## 1. Tipos de incidentes de saída

| Tipo | Exemplos | Consequência típica |
|---|---|---|
| Informação incorreta apresentada com confiança | Política de cancelamento inexistente; preço errado; precedente jurídico inventado | Reclamações, obrigações contratuais, litígios |
| Conselho perigoso ou inadequado | Orientação médica, financeira ou de segurança incorreta | Dano a pessoas; responsabilidade do fornecedor |
| Conteúdo discriminatório ou ofensivo | Respostas com vieses ou ofensas a grupos | Dano à reputação e à dignidade; riscos legais |
| Difamação e imputações falsas | O modelo atribui fatos graves a pessoas reais | Responsabilidade civil e, em tese, penal |
| Reprodução de conteúdo protegido ou de dados pessoais memorizados | Trechos extensos de obras ou dados de treinamento | Direitos autorais e privacidade |
| Código inseguro ou malicioso gerado e adotado | Vulnerabilidades, segredos no código, dependências inexistentes ou maliciosas | Incidentes de segurança (cadeia de suprimentos) |
| Falha de transparência | Usuário não sabia que interagia com IA ou foi induzido a erro | Conformidade (consumidor e regulação de IA) |
| Falha de supervisão humana | Saída usada sem revisão em decisão relevante | Responsabilidade da organização |

## 2. Reconstrução do que o sistema disse e por quê

| Passo | Descrição |
|---|---|
| 1. Preservar | Conversa original, contexto recuperado, versão do prompt do sistema, versão do modelo, parâmetros e filtros (arquivos 2 e 3 da pasta 25) |
| 2. Identificar a saída e o uso | O que foi dito, para quem, e que decisão ou ação decorreu |
| 3. Determinar a causa provável | Conteúdo desatualizado ou errado na base (RAG), falha do prompt, limitação do modelo, ausência de filtro, mudança de versão ou entrada do usuário |
| 4. Verificar o contexto recuperado | A resposta estava apoiada em um documento? O documento estava correto e atual? |
| 5. Verificar mudanças recentes | Alterações de modelo, prompt, índice ou parâmetros próximas da data |
| 6. Avaliar a reprodutibilidade | Executar o mesmo cenário **muitas vezes** em ambiente controlado, com a versão preservada, e medir a frequência do comportamento |
| 7. Avaliar os controles | Que guardrails, avisos, validações e supervisões existiam e como falharam |
| 8. Avaliar a extensão | Outros usuários e conversas com o mesmo problema |

```python
# Reprodutibilidade estatística: executar o mesmo prompt N vezes em ambiente controlado e contar a frequência de um comportamento
# (use a versão preservada do modelo e do prompt do sistema; dados de teste fictícios; implemente chamar_modelo conforme o seu ambiente)
import re

def frequencia_comportamento(chamar_modelo, prompt, padrao, n=50):
    ocorrencias = 0
    for _ in range(n):
        saida = chamar_modelo(prompt)
        if re.search(padrao, saida, flags=re.IGNORECASE):
            ocorrencias += 1
    return ocorrencias / n

# Exemplo de uso (ilustrativo):
# taxa = frequencia_comportamento(minha_funcao, "Posso cancelar sem multa?", r"sem multa", n=100)
# print(f"Comportamento observado em {taxa:.0%} das execuções")
```

Resultados de reprodução são **evidência complementar**: mostram a probabilidade de o sistema produzir aquele tipo de saída, e não substituem o registro da conversa original.

## 3. Evidências de diligência e de controles

| Evidência | O que demonstra |
|---|---|
| Avaliações e testes de segurança antes da implantação (conjuntos de teste, resultados e aprovações) | Diligência técnica |
| Testes de regressão e de segurança contínuos | Manutenção da qualidade |
| Relatórios de red team autorizado | Identificação prévia de riscos |
| Guardrails e filtros (configuração e registros) | Mecanismos de mitigação |
| Avisos ao usuário (limitações, "pode conter erros") e transparência sobre IA | Informação adequada |
| Supervisão humana e escalonamento (registros) | Controle em decisões relevantes |
| Documentação de governança (avaliação de impacto, cartões de modelo e política de uso) | Gestão de riscos (pasta 24) |
| Monitoramento e canal de reclamações | Detecção e resposta |
| Histórico de incidentes e correções | Melhoria contínua |

A ausência de evidências de diligência não prova negligência, mas **dificulta a defesa**; a organização deve documentá-las de forma contínua.

## 4. Código gerado por IA e incidentes de segurança

| Risco | Descrição | Investigação |
|---|---|---|
| Vulnerabilidades inseridas | Código sugerido com falhas conhecidas | Identificar os commits e pull requests, a origem (assistente) e as verificações (revisão, análise estática) |
| Segredos no código | Chaves e credenciais incluídas no código gerado ou nos prompts | Varredura de segredos no repositório e nos registros; rotação |
| Dependências inexistentes ou maliciosas | O modelo sugere pacotes inexistentes ("alucinados") que podem ser registrados por terceiros com conteúdo malicioso | Verificar os pacotes adicionados, a origem e as datas de criação (pasta 15) |
| Código com comportamento inesperado | Funcionalidade que difere do pedido | Revisão, testes e análise do histórico |
| Perda de rastreabilidade | Ausência de marca de origem em commits | Políticas de identificação de código assistido |

```bash
# Dependências adicionadas em um período (exemplo em Git; ajuste ao gerenciador de pacotes)
git log --since="2026-10-01" --until="2026-11-05" --pretty=format:"%H|%an|%ad|%s" --date=iso -- package.json requirements.txt pyproject.toml
# Varredura de segredos em um repositório (a saída contém segredos: proteja-a)
gitleaks detect --source . --report-path segredos_repo.json
```

## 5. Enquadramento de responsabilidade (visão geral)

> **Aviso:** orientações gerais; consulte o Jurídico. O enquadramento depende do caso, do setor e da jurisdição.

| Tema | Orientação |
|---|---|
| Relações de consumo | O fornecedor de serviços responde por defeitos na prestação e por informações insuficientes ou inadequadas (Código de Defesa do Consumidor, arts. 14 e 20); informações de um chatbot de atendimento podem vincular o fornecedor (oferta e informação) |
| Responsabilidade civil | Ato ilícito e dever de indenizar (Código Civil, arts. 186 e 927), conforme o caso |
| Honra e imagem | Imputações falsas a pessoas reais podem ensejar responsabilidade civil e, em tese, penal (Código Penal, arts. 138 a 140) |
| Direitos autorais | Reprodução de obras protegidas (Lei nº 9.610/1998) |
| Proteção de dados | Saídas que expõem dados pessoais; revisão de decisões automatizadas (LGPD, arts. 6º, 20 e 46) |
| Regulação de IA | Transparência para sistemas que interagem com pessoas e obrigações de sistemas de alto risco (AI Act, art. 50 e outros); verifique o cronograma vigente |
| Responsabilidade perante terceiros e fornecedores | Cláusulas contratuais com fornecedores de modelos (limitações, indenizações e garantias) |
| Responsabilidade profissional | Profissionais que usam IA (advogados, médicos e engenheiros) respondem pela verificação das saídas |

A prova técnica central é: **o que o sistema disse, em qual versão e contexto, e quais controles existiam**.

## 6. Comunicação e mitigação

| Ação | Descrição |
|---|---|
| Corrigir a causa | Base de conhecimento, prompts, filtros, avisos e supervisão |
| Contatar os afetados | Informar, corrigir a informação e oferecer solução, com orientação jurídica |
| Registrar o incidente | Base interna e, quando aplicável, notificação a reguladores e a seguradoras |
| Avaliar decisões afetadas | Revisão de decisões baseadas na saída incorreta |
| Monitoramento reforçado | Testes de regressão para o comportamento identificado |
| Aprendizado | Adicionar o caso aos testes de segurança e aos treinamentos |

## 7. Exemplo prático: chatbot informa política de cancelamento incorreta

| Etapa | Resultado |
|---|---|
| Reclamação | Cliente afirma que o chatbot informou que poderia cancelar sem multa |
| Preservação | Conversa original, versão do prompt do sistema (12/10), contexto recuperado, registros do gateway |
| Causa | O RAG recuperou um documento de política antiga (desatualizado) e o prompt do sistema vigente não exigia citar a política vigente |
| Reprodução | Em 100 execuções controladas, o modelo repetiu a afirmação em 71%, o que mostra que não foi um evento isolado |
| Controles | Havia aviso genérico "pode conter erros", sem validação de políticas contratuais, e sem supervisão humana para cancelamentos |
| Extensão | 23 outras conversas com a mesma afirmação em 3 semanas |
| Medidas | Correção da base e do prompt; validação de políticas por regra determinística; honrar a informação ao cliente; notificar os 23 clientes; novo teste de regressão |
| Conclusão | Falha de conteúdo e de governança de versões, com saída incorreta reprodutível; evidências de diligência insuficientes; recomendação de controles |

## 8. Casos de uso corporativos

- Investigação de reclamações sobre informações dadas por chatbots e assistentes.
- Avaliação de incidentes de código gerado por IA e de dependências suspeitas.
- Construção do dossiê de diligência para sistemas de IA de alto impacto.

## 9. Normas e frameworks relevantes

- OWASP Top 10 para LLM (LLM05 e LLM09); NIST AI 600-1 (confabulação, conteúdo nocivo e vieses); NIST AI RMF 1.0
- ISO/IEC 42001:2023; ISO/IEC 23894:2023; Regulamento (UE) 2024/1689 (arts. 50 e 73)
- CDC, arts. 14 e 20; Código Civil, arts. 186 e 927; Código Penal, arts. 138 a 140; Lei nº 9.610/1998
- LGPD, arts. 6º, 20 e 46

## 10. Referências

- NIST. AI 600-1: Generative Artificial Intelligence Profile. 2024.
- OWASP. Top 10 for LLM Applications (edição vigente).
- Responsible AI Collaborative. AI Incident Database.
- Brasil. Lei nº 8.078/1990 (CDC); Lei nº 10.406/2002 (Código Civil); Lei nº 9.610/1998; Lei nº 13.709/2018.
- Pastas 22, 24 e 25 deste repositório.
