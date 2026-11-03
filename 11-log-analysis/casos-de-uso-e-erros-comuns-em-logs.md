# Casos de Uso e Erros Comuns em Logs

> **Objetivo pedagógico:** consolidar o aprendizado de análise de logs com cenários corporativos realistas, os erros mais frequentes, suas consequências e as medidas de prevenção.

Os casos são fictícios e destinados ao treinamento.

## 1. Caso 1: password spraying contra o Entra ID

**Pergunta:** houve acesso indevido a contas de e-mail?

| Fonte | Achado |
|---|---|
| `SigninLogs` | 2.400 falhas (`ResultType` de senha incorreta) de 14 IPs, contra 480 contas, ao longo de 3 horas, com 1 a 5 tentativas por conta |
| Padrão | Baixa frequência por conta e alta diversidade de contas: password spraying |
| Sucessos posteriores | 3 contas com sucesso do mesmo IP após falhas |
| Atividade seguinte | Criação de regras de caixa de entrada e encaminhamento externo nas 3 contas |
| Resposta | Redefinição de credenciais, revogação de sessões, MFA obrigatório e busca por outras contas do mesmo IP |

**Lição:** procure o padrão por IP e por diversidade de contas, e não apenas falhas por conta.

## 2. Caso 2: injeção de SQL e exfiltração observadas em logs web

| Fonte | Achado |
|---|---|
| Logs do Nginx | Parâmetros com `union select` e `sleep(`, a partir de um IP, por 40 minutos |
| Tamanho das respostas | Respostas crescentes para uma mesma URL (retorno de dados) |
| Logs do banco de dados | Consultas incomuns da conta da aplicação a tabelas de clientes |
| Firewall | Volume elevado de saída do servidor de banco de dados para o IP do atacante em horário seguinte |
| Conclusão | Exploração de injeção de SQL com extração de dados (T1190); confiança alta; notificação avaliada conforme a LGPD |

**Lição:** o log de acesso web mostra a tentativa; confirme o sucesso com resposta, banco de dados e rede.

## 3. Caso 3: túnel DNS

| Fonte | Achado |
|---|---|
| `dns.log` | Um servidor consultando 18 mil subdomínios aleatórios de um único domínio em 2 horas |
| Características | Rótulos longos de alta entropia e registros TXT |
| EDR | Processo `svc.exe` executando as consultas |
| Reputação | Domínio registrado havia 3 dias |
| Conclusão | Exfiltração ou C2 por túnel DNS (T1071.004 e T1048); confiança alta; ação de bloqueio e isolamento |

**Lição:** o volume por domínio de segundo nível e a entropia dos rótulos revelam o túnel.

## 4. Caso 4: chave de acesso de nuvem vazada

| Fonte | Achado |
|---|---|
| CloudTrail | Chamadas `ListBuckets`, `GetObject` e `CreateAccessKey` com a chave de um usuário de serviço, a partir de IP de país incomum |
| Padrão | Primeira ocorrência de IP e de user-agent para essa credencial |
| Contexto | A chave estava em repositório público de código |
| Resposta | Revogar a chave, avaliar o escopo dos acessos e rotacionar credenciais relacionadas |

**Lição:** a análise de primeira ocorrência por credencial é eficaz para identificar o uso indevido de chaves.

## 5. Caso 5: lacuna de logs após limpeza

| Fonte | Achado |
|---|---|
| Servidor local | Log de Segurança sem eventos entre 03:40Z e 04:10Z; evento 1102 às 04:10Z |
| SIEM | Eventos do período preservados, por envio em tempo real |
| Análise | Atividade de criação de conta e de serviço no período apagado |
| Conclusão | Tentativa de ocultação identificada e superada pelo log centralizado; confiança alta |

**Lição:** o envio imediato ao servidor central protege contra a limpeza local.

## 6. Caso 6: acesso VPN fora do padrão

| Fonte | Achado |
|---|---|
| VPN | Logons de usuário U de dois países em 25 minutos (viagem impossível) |
| Dispositivo | Segundo logon sem o certificado do dispositivo corporativo |
| Entra ID | Tentativas de MFA recusadas pelo usuário (fadiga de MFA) e uma aprovada |
| Resposta | Revogação de sessões, reset de credenciais e revisão de acessos |

**Lição:** combine geovelocidade com atributos de dispositivo e de MFA para reduzir falsos positivos.

## 7. Caso 7: exploração de Log4Shell

| Fonte | Achado |
|---|---|
| Logs web e de WAF | `${jndi:ldap://...}` em URL, cabeçalhos e user-agent |
| Rede | Conexões de saída do servidor para o IP do servidor LDAP do atacante |
| EDR | Processo Java criando processo filho de shell |
| Conclusão | Tentativa de exploração e, no host afetado, exploração bem-sucedida; confiança alta com base na conexão de saída e no processo filho |

**Lição:** distinga tentativas de exploração de explorações bem-sucedidas pela resposta de rede e pelo comportamento do processo.

## 8. Erros comuns, consequências e prevenção

| Erro | Consequência provável | Prevenção |
|---|---|---|
| Não preservar os logs de retenção curta | Perda irreversível | Preservação imediata e retenção ampliada |
| Analisar sem normalizar horários e fusos | Correlações erradas | UTC e documentação de fusos |
| Descartar o log bruto após o parsing | Impossibilidade de auditar e reprocessar | Preservar o bruto e produzir camadas derivadas |
| Confiar em logs apenas locais | Perda por limpeza ou adulteração | Centralização e imutabilidade |
| Concluir pela ausência de atividade sem verificar a política de auditoria | Falso negativo | Verificar a configuração de auditoria e a cobertura |
| Tratar tentativa de exploração como comprometimento | Superestimação | Confirmar com resposta, rede e EDR |
| Usar limiares sem calibração | Ruído ou falhas de detecção | Linhas de base e ajuste contínuo |
| Não registrar as consultas | Análise irreprodutível | Registro de consultas e scripts |
| Enviar dados internos a serviços públicos de análise | Vazamento | Consultar apenas por indicadores |
| Ignorar proxies e CDNs na atribuição de IPs | Atribuição errada | Usar `X-Forwarded-For` e a cadeia de origem |
| Registrar senhas e dados excessivos nos logs | Risco de segurança e privacidade | Revisar o que é registrado e mascarar |
| Esquecer o impacto de NAT e DHCP | IP atribuído à máquina errada | Correlacionar com concessões de DHCP e logs de NAT |
| Ignorar duplicidades e atrasos de ingestão | Contagens e horários distorcidos | Deduplicação e monitoramento de atraso |

## 9. Exercícios práticos

1. Baixe um conjunto público de EVTX (por exemplo, EVTX-ATTACK-SAMPLES), execute o Hayabusa e o Chainsaw e compare os resultados.
2. Escreva uma regra Sigma para a criação de serviço por conta incomum, converta-a para duas plataformas e teste com dados benignos.
3. Em um log web de exercício, identifique varredura, tentativa de injeção e possível web shell, com as consultas utilizadas.
4. Implemente o script de detecção de beaconing e avalie falsos positivos em dados de teste.
5. Monte um laboratório com Elastic ou Wazuh, envie logs de uma VM Linux e de uma VM Windows e crie dois alertas.
6. Elabore o Termo de Extração e Integridade de Logs para uma exportação de logs de nuvem.

## 10. Normas e frameworks relevantes

- MITRE ATT&CK: T1110, T1190, T1071.004, T1048, T1078, T1070.001
- NIST SP 800-92; NIST SP 800-61 Rev. 3; ISO/IEC 27042:2015
- CIS Controls v8.1, controles 8 e 13
- OWASP Top 10 e OWASP Logging Cheat Sheet
- LGPD, arts. 6º, 37 e 48

## 11. Referências

- Kent, K.; Souppaya, M. NIST SP 800-92. 2006.
- MITRE ATT&CK. https://attack.mitre.org
- OWASP. Top 10 (2021) e Logging Cheat Sheet.
- The DFIR Report. Relatórios públicos de intrusões.
- Davidoff, S.; Ham, J. Network Forensics. Prentice Hall, 2012.
- SANS Institute. FOR508, FOR572 e SEC555.
