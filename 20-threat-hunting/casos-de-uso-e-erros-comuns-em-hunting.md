# Casos de Uso e Erros Comuns em Hunting

> **Objetivo pedagógico:** consolidar o aprendizado de threat hunting com cenários corporativos realistas, os erros mais frequentes, suas consequências e as medidas de prevenção.

Os casos são fictícios e destinados ao treinamento.

## 1. Caso 1: persistência por WMI descoberta por caça

**Hipótese:** adversários usam assinaturas permanentes de WMI para persistência sem arquivo.

| Etapa | Resultado |
|---|---|
| Dados | Sysmon 19, 20 e 21 em 85% dos servidores e 70% das estações |
| Resultado | 3 hosts com consumidores de linha de comando criados por contas não administrativas |
| Pivô | O mesmo consumidor executa um script codificado que baixa uma carga; conexões a um domínio recente |
| Escalonamento | Incidente aberto; escopo ampliado a 11 hosts por caça com o mesmo padrão |
| Saídas | Detecção para novas assinaturas de WMI fora de uma lista de permissão; cobertura de Sysmon ampliada |

**Lição:** persistência sem arquivo passa despercebida por antivírus; a telemetria correta e a caça orientada por técnica a revelam.

## 2. Caso 2: exfiltração com Rclone em servidor de arquivos

| Etapa | Resultado |
|---|---|
| Hipótese | Ferramentas de sincronização em nuvem são usadas para exfiltrar dados (T1567) |
| Achado | `rclone.exe` executado por conta de serviço, configuração em diretório temporário e 380 GB enviados a armazenamento externo |
| Escalonamento | Resposta a incidentes, preservação e avaliação de dados (pastas 16 e 20) |
| Saídas | Detecção por linha de comando e por volume; coleta de DNS implantada |

**Lição:** a caça permitiu identificar a exfiltração antes da criptografia, em vez de depois.

## 3. Caso 3: Kerberoasting identificado por análise de 4769

| Etapa | Resultado |
|---|---|
| Hipótese | Contas comuns solicitam muitos tíquetes de serviço com RC4 |
| Achado | Um usuário solicitou 41 serviços distintos em 6 minutos, a partir de uma estação |
| Validação | Sem relação com atividades de administração; estação com ferramenta desconhecida |
| Resposta | Redefinição das credenciais de serviço visadas, migração para criptografia forte, isolamento da estação e caça por movimentação lateral |
| Saídas | Detecção para volume de 4769 com RC4 por conta e por janela |

**Lição:** análise estatística simples sobre eventos de domínio é eficaz quando os logs existem.

## 4. Caso 4: chave de acesso de nuvem criada fora do processo

| Etapa | Resultado |
|---|---|
| Hipótese | Chaves de acesso são criadas por identidades incomuns (persistência na nuvem) |
| Achado | `CreateAccessKey` para um usuário de serviço por uma função de suporte, às 03:10Z |
| Corroboração | A função fora assumida a partir de IP incomum; atividade de reconhecimento antes |
| Resposta | Desativar a chave, revisar a função, avaliar o impacto (pastas 17 e 18) |
| Saídas | Detecção para criação de chaves fora da janela e do grupo de administração de identidades |

**Lição:** a caça em nuvem se apoia nos logs de auditoria e no conhecimento do processo normal de gestão de identidades.

## 5. Caso 5: túnel DNS e lacuna de telemetria

| Etapa | Resultado |
|---|---|
| Hipótese | Há túneis DNS para C2 ou exfiltração |
| Dados | O DNS não era coletado (lacuna GAP-007); só havia NetFlow e proxy |
| Resultado | Caça inconclusiva: não foi possível testar a hipótese |
| Saídas | Coleta de DNS priorizada e implantada; caça reexecutada 30 dias depois; nenhum achado, com cobertura registrada |

**Lição:** uma caça inconclusiva por falta de dados é um resultado válido, desde que a lacuna seja registrada e corrigida.

## 6. Caso 6: falso positivo de ferramenta administrativa

| Etapa | Resultado |
|---|---|
| Candidato | Executável de acesso remoto presente em poucos servidores, instalado fora do inventário |
| Validação | A equipe de infraestrutura o usava para suporte a um fornecedor, sem registro de mudança |
| Classificação | Violação de política (indevida), não malícia |
| Ações | Formalizar a exceção, atualizar o inventário e criar detecção para instalações fora do processo |

**Lição:** o contexto do negócio distingue o malicioso do indevido; as duas classificações geram ações diferentes.

## 7. Caso 7: insider preparando a saída

| Etapa | Resultado |
|---|---|
| Hipótese | Colaboradores em desligamento acumulam e copiam dados (T1213 e T1567) |
| Achado | Aumento de acessos e downloads em SharePoint e envio a armazenamento pessoal (pasta 19) |
| Tratamento | Escalonamento ao Jurídico e ao RH; preservação e retenção legal; investigação conduzida com escopo e sigilo |
| Saídas | Alerta de comportamento de saída, política de revisão de acessos em desligamentos |

**Lição:** achados que envolvem pessoas exigem governança, sigilo e proporcionalidade.

## 8. Erros comuns, consequências e prevenção

| Erro | Consequência provável | Prevenção |
|---|---|---|
| Caçar sem hipótese ("olhar os logs") | Esforço sem resultado e sem aprendizado | Hipótese específica no formato ABLE |
| Ignorar a qualidade e a cobertura dos dados | Conclusões falsas de "nada encontrado" | Verificação de dados e registro de lacunas |
| Tratar a ausência de achado como ausência de ameaça | Falsa segurança | Declarar o que foi testado e as limitações |
| Não registrar consultas e decisões | Caças irreprodutíveis e retrabalho | Registro de execução e relatórios |
| Não converter resultados em detecção | Esforço perdido e achados repetidos | Etapa obrigatória de transição |
| Linhas de base contaminadas | Comportamento do adversário tratado como normal | Revisar e validar as linhas de base |
| Confiar em anomalia estatística como prova | Falsos positivos e acusações indevidas | Corroboração por fonte independente |
| Listas de permissão sem validade e sem dono | Pontos cegos permanentes | Revisão periódica e responsáveis |
| Metas de quantidade de achados | Distorções e achados forçados | Métricas de valor (detecções, lacunas e cobertura) |
| Caça sem autorização e sem avaliação de privacidade | Violações de privacidade e legais | Autorização, escopo e minimização |
| Escalar sem preservar evidências | Perda de provas e da causa raiz | Preservação antes da contenção (pasta 03) |
| Contenção precipitada sem coordenação | Alerta ao adversário e perda de visibilidade | Coordenação com a resposta a incidentes |
| Usar ferramentas ofensivas ou de emulação em produção | Incidentes reais | Emulação em ambiente de teste ou com autorização formal |
| Julgar pessoas por indícios isolados | Dano a colaboradores e riscos trabalhistas | Hipóteses alternativas, RH e Jurídico |
| Caçadores sem tempo protegido | Programa abandonado | Capacidade dedicada e priorização |

## 9. Exercícios práticos

1. Escolha uma técnica do ATT&CK (por exemplo, T1053.005) e redija o plano de caça completo (modelo A), com hipótese ABLE, dados, consultas e critérios de sucesso.
2. Com um conjunto de dados público (OTRF Security-Datasets ou Boss of the SOC), execute as fichas de caça de execução, persistência e credenciais, e preencha os registros de execução e de candidatos.
3. Faça um empilhamento de processos por tipo de host com o DuckDB ou o KQL e identifique cinco candidatos, classificando-os com justificativa.
4. Construa o grafo de autenticações de um conjunto de dados e identifique contas de maior alcance.
5. Converta uma caça com achado em regra Sigma, teste-a com dados normais e com os dados da caça e documente os falsos positivos.
6. Em laboratório, execute um teste do Atomic Red Team para uma técnica e verifique se a sua detecção ou a sua caça identifica a atividade.
7. Elabore o relatório de caça de uma caça **sem achado**, com a lacuna de dados e a recomendação.

Use apenas conjuntos de dados públicos e ambientes de teste; a emulação de técnicas em produção exige autorização formal, coordenação e plano de reversão.

## 10. Normas e frameworks relevantes

- MITRE ATT&CK: T1546.003, T1567, T1558.003, T1098.001, T1071.004, T1219, T1213
- NIST CSF 2.0; NIST SP 800-61 Rev. 3; ISO/IEC 27035
- CIS Controls v8.1, controles 8, 13 e 17
- LGPD, arts. 6º, 7º, 46 e 48

## 11. Referências

- OTRF. Threat Hunter Playbook e Security-Datasets; Splunk. Boss of the SOC.
- The DFIR Report. Relatórios de intrusões (técnicas e linhas do tempo).
- Red Canary. Atomic Red Team; MITRE. CALDERA.
- Splunk SURGe. PEAK; FI-ISAC NL. TaHiTI.
- MITRE ATT&CK. https://attack.mitre.org
- SANS Institute. FOR508 e SEC555.
