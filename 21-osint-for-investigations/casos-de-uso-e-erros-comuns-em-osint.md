# Casos de Uso e Erros Comuns em OSINT

> **Objetivo pedagógico:** consolidar o aprendizado de OSINT para investigações corporativas e de segurança com cenários realistas, os erros mais frequentes (inclusive os legais e éticos), suas consequências e as medidas de prevenção.

Os casos são fictícios e destinados ao treinamento.

## 1. Caso 1: campanha de phishing com domínios semelhantes

**Pergunta:** quem está por trás da infraestrutura e como derrubá-la?

| Fonte | Achado |
|---|---|
| Denúncias | Clientes relatam página de pagamento falsa em `pagamentos-empresaexemplo[.]com` |
| RDAP e CT | Domínio criado há 4 dias; mesmo emissor de certificados e padrão de nomes em outros 6 domínios |
| DNS passivo e varredura | Os 7 domínios compartilham 2 IPs, o mesmo hash de favicon e a mesma impressão TLS |
| Preservação | WARC, capturas, cabeçalhos e hashes; ata notarial por ser prova central |
| Ações | Pedidos de remoção ao registrador e à hospedagem, bloqueio em DNS e proxy, aviso aos clientes e compartilhamento de indicadores sob TLP |
| Resultado | Domínios retirados em 20 horas; nenhuma atribuição a pessoas foi feita, apenas a infraestrutura |

**Lição:** foque em infraestrutura e em remoção; atribuir pessoas com base em dados de registro é arriscado e raramente necessário.

## 2. Caso 2: perfil falso de executivo para golpe de pagamento

| Fonte | Achado |
|---|---|
| Denúncia | Fornecedores recebem mensagens de um perfil que se apresenta como o diretor financeiro |
| Análise do perfil | Criado há 9 dias; foto reutilizada de uma publicação de imprensa; mesmo texto em outros perfis |
| Verificação | O diretor confirma que não possui o perfil; domínio de e-mail do golpe é semelhante ao da empresa |
| Ações | Denúncia à plataforma com provas preservadas, comunicado aos fornecedores, bloqueio do domínio e registro de ocorrência |

**Lição:** a verificação com o próprio titular e a preservação adequada aceleram a remoção.

## 3. Caso 3: due diligence de fornecedor revela cadeia societária suspeita

| Fonte | Achado |
|---|---|
| CNPJ e QSA | Empresa nova, capital baixo, endereço de sala compartilhada |
| CEIS e CNEP | Outra empresa do mesmo sócio, suspensa há dois anos |
| Domínio e presença | Domínio de 5 meses, site genérico, sem clientes verificáveis |
| Análise ACH | Hipótese de empresa constituída para contornar sanção é a menos inconsistente; confiança moderada |
| Decisão | O comitê de integridade solicita documentos e referências antes de qualquer contratação |

**Lição:** sinais de alerta não são prova; a decisão deve ser tomada com análise, esclarecimentos e proporcionalidade.

## 4. Caso 4: segredos da empresa publicados em repositório público

| Fonte | Achado |
|---|---|
| Superfície de ataque (autorizada) | Busca em repositórios públicos encontra arquivo de configuração com chave de acesso de nuvem da empresa |
| Preservação | Captura do repositório e do histórico de commits, com hash |
| Resposta | Revogar e rotacionar a chave imediatamente; verificar uso indevido nos logs de nuvem (pasta 17); remover o conteúdo e o histórico; revisar processos de desenvolvimento |
| Prevenção | Ferramentas de detecção de segredos no pipeline e treinamento |

**Lição:** a ordem é revogar e rotacionar primeiro; remover o repositório não elimina o risco de cópias.

## 5. Caso 5: vídeo manipulado de executivo em redes sociais

| Fonte | Achado |
|---|---|
| Busca reversa | Cenário e roupas vêm de uma entrevista de 8 meses antes |
| Análise técnica | Sincronismo labial imperfeito e artefatos nos contornos do rosto |
| Perfis | Conta criada há 6 dias; mais de 20 perfis replicam o mesmo texto e link |
| Resposta | Denúncias com provas, comunicado oficial, remoção dos domínios do link e encaminhamento ao Jurídico (pasta 27) |

**Lição:** combinar proveniência, técnica e análise de fonte dá uma conclusão mais sólida do que um único indicador.

## 6. Caso 6: divulgação pública de informação confidencial por colaborador

| Fonte | Achado |
|---|---|
| Alerta | Publicação pública em rede profissional com trecho de documento interno confidencial |
| Preservação | Captura, hash e ata notarial; registro do identificador estável da publicação |
| Tratamento | Escalonamento ao Jurídico e ao RH; a investigação se limita ao conteúdo público e aos controles internos (logs de acesso, pastas 11 e 19), sem monitorar a vida privada da pessoa |
| Resultado | A publicação foi removida a pedido; o processo interno seguiu os procedimentos e a proporcionalidade |

**Lição:** a investigação deve ficar restrita ao fato relevante, com envolvimento de RH e Jurídico, e sem devassa na vida privada.

## 7. Caso 7: erro de identificação por homonímia

| Fonte | Achado |
|---|---|
| Situação | Em uma avaliação de contraparte, uma notícia sobre fraude foi associada ao sócio por coincidência de nome |
| Verificação | Cidade, data de nascimento e papel societário não coincidem; o processo citado envolvia outra pessoa |
| Impacto evitado | A contratação foi mantida; o relatório corrigido; o registro de pesquisa documentou a verificação |

**Lição:** homônimos são comuns; confirme com identificadores únicos antes de associar notícias e processos.

## 8. Erros comuns, consequências e prevenção

| Erro | Consequência provável | Prevenção |
|---|---|---|
| Iniciar sem requisito, finalidade e base legal | Coleta excessiva e riscos legais | Plano aprovado e avaliação de privacidade |
| Tratar "público" como "livre de regras" | Violação da LGPD e de termos de uso | Aplicar finalidade, necessidade e proporcionalidade |
| Usar contas pessoais ou ambientes não isolados | Exposição do investigador e infecção | Ambiente dedicado e política de contas |
| Criar perfis falsos ou enganar pessoas | Responsabilidade legal e contratual, e dano reputacional | Coleta passiva; aprovação formal em exceções |
| Usar bases vazadas ou obtidas ilicitamente | Ilicitude e invalidação da prova | Usar serviços legítimos e consultar o Jurídico |
| Não preservar conteúdo volátil | Perda de provas | Captura, WARC, hash e, se necessário, ata notarial |
| Depender de uma captura de tela isolada | Prova frágil e contestável | Método documentado e arquivos estruturados |
| Arquivar em serviços públicos conteúdo sensível | Exposição de dados e alerta ao adversário | Arquivamento local ou privado |
| Atribuir autoria a pessoas por dados de registro ou por semelhanças fracas | Acusações indevidas | Atributos múltiplos, confiança declarada e foco na infraestrutura |
| Confundir homônimos | Erros graves e responsabilidade | Identificadores únicos e verificação cruzada |
| Viés de confirmação | Conclusões distorcidas | ACH, hipóteses concorrentes e revisão por pares |
| Montar dossiês sobre a vida privada | Desproporção, perseguição e danos | Limitar ao requisito e ao papel profissional ou societário |
| Compartilhar dados pessoais no relatório sem necessidade | Violação de privacidade | Minimização, pseudonimização e TLP |
| Interagir com a infraestrutura ou com atores maliciosos | Retaliação e riscos legais | Coleta passiva; canais institucionais |
| Verificações ativas contra terceiros sem autorização | Acesso indevido | Passivo por padrão; autorização formal para ativos próprios |
| Compartilhar conclusões preliminares como fatos | Desinformação e danos | Declarar confiança; compartilhar o verificado |

## 9. Exercícios práticos

1. Escreva o plano de investigação (modelo A) para um requisito de proteção da marca, incluindo base legal, minimização e métodos proibidos.
2. Em um domínio de teste, execute uma captura em WARC com `wget`, calcule os hashes, preencha a ficha de coleta e valide a captura com uma ferramenta de reprodução.
3. Para um domínio fictício ou de exercício, colete RDAP, DNS, certificados de CT e variações com `dnstwist`, e agrupe infraestrutura relacionada atribuindo a confiança.
4. Faça a avaliação de um fornecedor fictício com os cadastros públicos (CNPJ de exemplo, CEIS e CNEP) e preencha o modelo ACH com duas hipóteses concorrentes.
5. Verifique uma imagem e um vídeo de exercício (desafios de verificação de organizações abertas): busca reversa, metadados, geolocalização e conclusão com confiança.
6. Escreva o relatório do caso 1 com indicadores neutralizados e classificação TLP.
7. Revise um relatório de exemplo e identifique excessos de dados pessoais e conclusões sem corroboração.

Pratique com ativos próprios, alvos fictícios e materiais de treinamento; jamais use os exercícios para investigar pessoas reais sem requisito, base legal e aprovação.

## 10. Normas e frameworks relevantes

- Protocolo de Berkeley; ISO/IEC 27037:2012; NIST SP 800-86 e SP 800-150; FIRST TLP
- MITRE ATT&CK: T1583, T1585, T1589, T1591, T1593, T1596, T1656
- Lei nº 12.846/2013; ISO 37001; ISO 37301
- LGPD, arts. 6º, 7º (§§ 3º e 4º), 11, 14 e 46; Marco Civil da Internet; CP, arts. 147-A e 154-A

## 11. Referências

- ONU (OHCHR) e UC Berkeley. Berkeley Protocol on Digital Open Source Investigations. 2020.
- Bellingcat. Online Investigation Toolkit e estudos de caso.
- Heuer, R. J.; Pherson, R. H. Structured Analytic Techniques for Intelligence Analysis. 2014.
- Brasil. CGU. Portal da Transparência; Lei nº 13.709/2018 (LGPD).
- First Draft. Verification Handbook.
- SANS Institute. SEC487.
