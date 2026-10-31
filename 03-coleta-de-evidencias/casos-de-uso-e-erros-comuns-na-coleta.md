# Casos de Uso e Erros Comuns na Coleta

> **Objetivo pedagógico:** consolidar o aprendizado da fase de coleta por meio de cenários corporativos, dos erros mais frequentes, de suas consequências e das medidas de prevenção.

Os casos são fictícios e destinados ao treinamento.

## 1. Caso 1: notebook ligado com disco criptografado

**Contexto:** colaborador sob investigação deixa o notebook ligado e desbloqueado, com BitLocker ativo.

| Etapa | Decisão |
|---|---|
| Fixação | Fotografar a tela e registrar o horário e o fuso |
| Decisão | Coleta ao vivo, para não perder o acesso ao volume criptografado |
| Execução | Capturar a memória; registrar o status do BitLocker; obter a chave de recuperação por meio do administrador; adquirir o volume desbloqueado |
| Preservação | Hash, lacre e custódia; isolamento de rede mantendo o equipamento ligado |

**Lição:** desligar um sistema criptografado e desbloqueado pode tornar a evidência inacessível.

## 2. Caso 2: servidor Linux crítico em produção

**Contexto:** suspeita de shell reverso em servidor de aplicação que não pode ser desligado.

| Etapa | Decisão |
|---|---|
| Autorização | Aprovação da gestão e do Jurídico para coleta sem parada |
| Execução | AVML para memória; coleta de sockets, processos e logs; snapshot do volume na plataforma de virtualização |
| Contenção | Isolar o tráfego de saída por regra de rede, preservando o processo |
| Análise posterior | Imagem do disco a partir do snapshot, em ambiente isolado |

**Lição:** snapshots reduzem o impacto operacional e preservam o estado.

## 3. Caso 3: máquina virtual na nuvem

**Contexto:** instância comprometida que a automação encerrará em duas horas.

| Etapa | Decisão |
|---|---|
| Preservação imediata | Snapshot dos discos e exportação dos logs de API e de rede |
| Isolamento | Grupo de segurança restritivo, sem destruir a instância |
| Registro | Identificadores dos recursos, região, horário e conta que executou as ações |
| Custódia | Cópia do snapshot em conta de investigação, com hash e acesso restrito |

**Lição:** em nuvem, a coleta de logs e snapshots é a primeira ação, e não a última.

## 4. Caso 4: triagem remota de 200 estações

**Contexto:** alerta de inteligência de ameaças com IOCs de hash e domínio.

| Etapa | Decisão |
|---|---|
| Plano | Artefatos mínimos, lotes de 20 hosts, janela fora do horário de pico |
| Execução | Coletor de triagem, hashes por host e manifesto central |
| Análise | Consulta dos IOCs em todos os pacotes |
| Resultado | 6 hosts com indícios; aquisição completa e captura de memória priorizadas |
| Relatório | 194 sem indícios dentro da cobertura coletada; limitações declaradas |

**Lição:** a triagem orienta, mas não prova ausência de comprometimento.

## 5. Caso 5: logs de M365 prestes a expirar

**Contexto:** BEC em conta de diretoria, com retenção limitada do audit log.

| Etapa | Decisão |
|---|---|
| Prioridade | Exportar primeiro o audit log e os logs de entrada |
| Execução | Exportação nominal, com filtros e período documentados |
| Integridade | Hash dos arquivos e armazenamento imutável |
| Contenção | Revogar sessões somente após a coleta dos dados necessários |

**Lição:** a contenção precipitada pode apagar ou alterar evidências; sincronize com a coleta.

## 6. Caso 6: coleta em dispositivo pessoal de executivo

**Contexto:** executivo usa smartphone pessoal para e-mail corporativo, e há suspeita de vazamento.

| Etapa | Decisão |
|---|---|
| Base legal | Consentimento por termo específico e cláusula BYOD, validados pelo Jurídico e pelo DPO |
| Escopo | Aplicativos corporativos e logs; sem acesso a conteúdo pessoal |
| Execução | Conforme procedimento de forense mobile, com registro do consentimento |
| Alternativa | Coleta de logs corporativos (MDM e M365) sem acesso ao aparelho |

**Lição:** o caminho menos invasivo que atenda à finalidade deve ser o escolhido.

## 7. Erros comuns, consequências e prevenção

| Erro | Consequência provável | Prevenção |
|---|---|---|
| Começar sem autorização | Ilicitude da coleta e responsabilização | Termo assinado antes de qualquer ação |
| Desligar antes de coletar a memória | Perda de dados voláteis e de chaves | Ordem de volatilidade e decisão documentada |
| Gravar saídas no disco investigado | Sobrescrita de evidências | Mídia externa dedicada |
| Não usar bloqueador de escrita | Alteração de metadados e do sistema de arquivos | Bloqueador de hardware |
| Confundir origem e destino na imagem | Destruição do original | Conferência de modelo, série e tamanho antes de executar |
| Não calcular ou não conferir o hash | Impossibilidade de demonstrar integridade | Hash da fonte e da imagem em todas as aquisições |
| Conter antes de coletar | Perda de evidências e alerta ao atacante | Sincronizar contenção e coleta |
| Coletar além do escopo | Violação de privacidade e invalidade de prova | Escopo e minimização |
| Esquecer logs de retenção curta | Perda irreversível | Lista de fontes de retenção curta no plano |
| Não registrar limitações | Conclusões superestimadas | Relatório de coleta com limitações |
| Não registrar o impacto da coleta ao vivo | Questionamento da integridade | Declaração do impacto conhecido |

## 8. Exercícios práticos

1. Escolha um dos casos e elabore o Plano de Coleta (Modelo A), com a matriz de priorização.
2. Para o caso 3, descreva em uma página a sequência de preservação em nuvem.
3. Para o caso 4, escreva o relatório de coleta com as limitações.
4. Para o caso 6, redija o termo de consentimento e a justificativa da base legal para análise do Jurídico.

## 9. Normas e frameworks relevantes

- ISO/IEC 27037:2012; NIST SP 800-86; RFC 3227
- ISO/IEC 27002:2022, controle 5.28
- MITRE ATT&CK
- CIS Controls v8.1, controles 8 e 17
- LGPD, arts. 6º, 7º e 46

## 10. Referências

- ABNT NBR ISO/IEC 27037:2013.
- Kent, K. et al. NIST SP 800-86. 2006.
- Brezinski, D.; Killalea, T. RFC 3227. 2002.
- Ligh, M. et al. The Art of Memory Forensics. Wiley, 2014.
- Brasil. Lei nº 13.709/2018 (LGPD).
- SANS Institute. FOR508 e FOR498.
