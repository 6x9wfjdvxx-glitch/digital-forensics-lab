# Casos de Uso e Erros Comuns em Mobile

> **Objetivo pedagógico:** consolidar o aprendizado de forense mobile com cenários corporativos realistas, os erros mais frequentes, suas consequências e as medidas de prevenção.

Os casos são fictícios e destinados ao treinamento.

## 1. Caso 1: smartphone de colaborador em desligamento

**Pergunta:** o colaborador enviou informações confidenciais por mensagens antes de sair?

| Etapa | Decisão |
|---|---|
| Preservação | Aparelho corporativo, ligado e bloqueado, em AFU, isolado em bolsa de Faraday com energia, sem desligar |
| Autorização | Termo assinado pelo Jurídico, DPO e CISO; a senha foi fornecida pelo colaborador por escrito |
| Aquisição | Extração de sistema de arquivos por ferramenta validada; hash e verificação |
| Análise | Fotos de documentos enviadas por WhatsApp a número pessoal; mensagens apagadas recuperadas do banco SQLite |
| Corroboração | Logs do MDM e do e-mail corporativo |
| Resultado | Envio comprovado; conteúdo apagado marcado como registro recuperado |

**Lição:** a rapidez na preservação em AFU permitiu a extração; registros recuperados exigem rótulo próprio.

## 2. Caso 2: disputa sobre mensagens em ação trabalhista

| Fonte | Achado |
|---|---|
| Material apresentado | Capturas de tela de conversas, contestadas pela outra parte |
| Providência | Extração do aparelho corporativo (com autorização) e do banco do aplicativo |
| Autenticação | Hash, metadados (identificadores de mensagens e horários), conferência com o aparelho do outro participante e ata notarial |
| Resultado | Conversa completa do período, com identificadores e horários, e limitações declaradas |

**Lição:** capturas de tela são frágeis; a força probatória vem da extração e da corroboração (ver pasta 06).

## 3. Caso 3: stalkerware em aparelho de executiva

| Fonte | Achado |
|---|---|
| Aparelho | Aplicativo "Atualização do Sistema" instalado de fonte desconhecida, com permissões de SMS, localização, microfone e acessibilidade |
| Rede | Conexões periódicas a plataforma comercial de monitoramento |
| Preservação | Pacote e dados preservados antes da remoção; credenciais trocadas a partir de dispositivo seguro |
| Segurança | Comunicação conduzida por canal seguro, com apoio do Jurídico |

**Lição:** preserve antes de remover e proteja a pessoa envolvida.

## 4. Caso 4: verificação de spyware avançado em dispositivo de alto risco

| Etapa | Resultado |
|---|---|
| Contexto | Diretor recebeu notificação oficial de ameaça patrocinada por Estado |
| Aquisição | Backup criptografado do iPhone e sysdiagnose |
| MVT | Sem correspondências nas listas de IOCs atuais; registros de falhas com processos incomuns, a investigar |
| Medidas | Modo de bloqueio ativado, atualização do sistema, troca de credenciais e consulta a apoio especializado |
| Relatório | "Ausência de indicadores conhecidos"; a ausência não prova a inexistência de comprometimento |

**Lição:** relate o resultado negativo com cautela e recomende medidas de proteção.

## 5. Caso 5: aparelho perdido e risco de apagamento remoto

| Etapa | Decisão |
|---|---|
| Situação | Smartphone corporativo de um gerente é perdido; há suspeita de furto |
| MDM | Consulta de inventário e localização; **não acionar apagamento imediato** se for necessário preservar dados |
| Equilíbrio | Se houver risco de exposição de dados sensíveis e a preservação não for a prioridade, o apagamento remoto pode ser a decisão correta, registrada e autorizada pelo líder e pelo CISO |
| Registro | Decisão, horários e justificativas no relatório |

**Lição:** a decisão entre preservar e proteger é de risco; documente quem decidiu e por quê.

## 6. Caso 6: dispositivo pessoal (BYOD) com consentimento restrito

| Etapa | Decisão |
|---|---|
| Base | Termo de consentimento específico, validado pelo Jurídico e pelo DPO |
| Escopo | Aplicativos corporativos, e-mail e mensagens com contatos do trabalho, em período definido |
| Método | Aquisição lógica com filtros e análise limitada ao escopo; conteúdo pessoal excluído |
| Alternativa | Logs corporativos (MDM, e-mail e rede) sem acesso ao aparelho |

**Lição:** o caminho menos invasivo que atenda à finalidade deve ser o escolhido.

## 7. Caso 7: localização como álibi

| Fonte | Achado |
|---|---|
| Aparelho | Fotos com EXIF às 22:05Z e 22:40Z em locais diferentes; Wi-Fi conectado à rede da residência às 22:20Z |
| Aplicativos | Registro de uso de aplicativo de transporte com trajeto |
| Operadora | Torres de celular compatíveis (obtidas por via legal) |
| Conclusão | Conjunto consistente com a presença na residência no período; precisão limitada; apresentar o grau de confiança e as margens de erro |

**Lição:** a localização exige várias fontes e uma margem de erro declarada.

## 8. Erros comuns, consequências e prevenção

| Erro | Consequência provável | Prevenção |
|---|---|---|
| Desligar o aparelho ligado | Estado BFU: acesso reduzido ou perdido | Manter ligado, com energia, isolado |
| Deixar o aparelho conectado à rede | Apagamento remoto, novas mensagens e sincronização | Faraday ou modo avião documentado |
| Tentar senhas ou biometria sem plano | Bloqueio, atraso ou apagamento | Obter a credencial por via lícita |
| Navegar livremente no conteúdo | Alteração e extrapolação do escopo | Interação mínima e documentada |
| Acessar o conteúdo sem autorização ou além do escopo | Ilicitude e violação de privacidade | Autorização, DPO e minimização |
| Restaurar de fábrica ou desbloquear o bootloader | Perda dos dados | Preservar antes de qualquer reconfiguração |
| Conectar o aparelho a computadores sem controle | Pareamentos e sincronizações indesejados | Estação de análise controlada e registro |
| Não registrar identificadores e estado | Perda de rastreabilidade | Modelo de registro do dispositivo |
| Basear-se apenas em capturas de tela | Prova frágil e contestável | Extração e hash |
| Não verificar a extração (contagens e abertura) | Aquisição incompleta não detectada | Verificação com a tela e com outra ferramenta |
| Confundir registro ativo com recuperado | Conclusões superestimadas | Rotular os registros recuperados e a confiança |
| Ignorar a nuvem e outros dispositivos | Perda de evidências | Mapear contas, backups e pareamentos |
| Tratar o resultado negativo do MVT como prova de ausência de spyware | Falsa segurança | Declarar a limitação das listas de IOCs |
| Remover stalkerware sem planejar a segurança da vítima | Risco de escalada | Planejamento com a vítima e apoio especializado |
| Expor dados de terceiros no relatório | Violação da LGPD | Minimização e restrição de acesso |

## 9. Exercícios práticos

1. Em aparelhos de teste (Android e iOS) com contas fictícias, preencha o Registro do Dispositivo e planeje a aquisição conforme o estado.
2. Gere um backup criptografado de um iPhone de teste, localize o `sms.db` pelo `Manifest.db` e converta os horários para UTC.
3. Use `adb bugreport` e `dumpsys` em um Android de teste e liste os aplicativos de terceiros e suas permissões.
4. Analise uma imagem pública de treinamento (por exemplo, as imagens de Android e iOS publicadas por Josh Hickman e as do NIST CFReDS) com o ALEAPP ou o iLEAPP e preencha o Registro de Análise de Artefatos.
5. Execute o MVT sobre um backup de teste e redija o relatório do resultado, incluindo as limitações.
6. Elabore o relatório mobile do caso 1, com os filtros de escopo e de minimização.

Desafios práticos: os desafios de forense móvel do Magnet CTF e os conjuntos de dados públicos de treinamento. Use sempre dispositivos e dados de teste.

## 10. Normas e frameworks relevantes

- NIST SP 800-101 Rev. 1; NIST SP 800-124 Rev. 2
- SWGDE (mobile); ISO/IEC 27037:2012; ISO/IEC 27042:2015
- MITRE ATT&CK Mobile; OWASP MASVS e MASTG
- LGPD, arts. 6º, 7º, 11, 46 e 48; Constituição Federal, art. 5º, X e XII

## 11. Referências

- Ayers, R. et al. NIST SP 800-101 Rev. 1. 2014.
- Tamma, R. et al. Practical Mobile Forensics. 4. ed. 2020.
- Mahalik, H. et al. Mobile Forensics: Advanced Investigative Strategies. 2016.
- Hickman, J. Imagens públicas de Android e iOS para treinamento.
- NIST CFReDS: Computer Forensic Reference Data Sets.
- Amnesty International Security Lab. MVT; Citizen Lab. Relatórios.
- SANS Institute. FOR585.
