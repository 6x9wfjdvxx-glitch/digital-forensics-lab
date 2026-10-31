glossario-forense.md# Glossário Forense

> **Objetivo pedagógico:** padronizar o vocabulário técnico, jurídico e operacional utilizado em todo o laboratório, reduzindo ambiguidades em relatórios, laudos e comunicações com Jurídico, RH, DPO e alta direção.

## 1. Como usar este glossário

- Utilize os termos exatamente como definidos aqui em relatórios, formulários e comunicações do caso.
- Quando um termo possuir definição normativa (ISO/IEC 27037, ISO/IEC 27035-1, LGPD), prevalece a definição da norma.
- Termos novos devem ser incluídos por commit, com a fonte indicada.

## 2. Conceitos gerais

| Termo | Definição | Observação |
|---|---|---|
| Forense digital | Aplicação de métodos científicos e técnicos à identificação, preservação, coleta, exame, análise e relato de evidências digitais, de modo que os resultados sejam reproduzíveis e utilizáveis em procedimentos administrativos, cíveis ou criminais | Ramos: computador, rede, memória, móvel, nuvem, IA |
| DFIR | Digital Forensics and Incident Response: combinação de forense digital e resposta a incidentes | A forense apoia a resposta e a resposta alimenta a forense |
| Evento de segurança da informação | Ocorrência identificada em sistema, serviço ou rede que indica possível violação da política de segurança ou falha de controles | Definição da ISO/IEC 27035-1 |
| Incidente de segurança da informação | Um ou mais eventos relacionados e identificados que podem prejudicar ativos ou comprometer operações | Definição da ISO/IEC 27035-1 |
| Evidência digital | Informação ou dado, armazenado ou transmitido em forma binária, que pode ser usado como evidência | Definição da ISO/IEC 27037 |
| Artefato | Vestígio gerado pelo uso de um sistema ou aplicação (arquivo, chave de registro, entrada de log) que permite inferir atividade | Exemplos: Prefetch, entrada de log, cache de DNS |
| IOC | Indicator of Compromise: observável associado a atividade maliciosa, como hash, IP, domínio ou chave de registro | Vida útil curta; ver Pirâmide da Dor |
| IOA | Indicator of Attack: indicador de comportamento ou intenção do adversário, independente de artefatos específicos | Mais durável que o IOC |
| TTP | Táticas, técnicas e procedimentos de um adversário | Descritos no MITRE ATT&CK |
| e-Discovery e ESI | Processo de identificação, preservação, coleta, processamento, revisão e produção de informação armazenada eletronicamente (ESI) para litígios e investigações | ISO/IEC 27050-1 e modelo EDRM |
| Legal hold | Ordem formal de preservação de informações potencialmente relevantes, que suspende rotinas de descarte | Emitido por Jurídico |

## 3. Evidência e custódia

| Termo | Definição | Observação |
|---|---|---|
| Evidência original | Dado ou dispositivo na forma e no local em que foi encontrado | Não deve ser alterada |
| Imagem forense (cópia forense) | Cópia bit a bit do conteúdo de uma mídia ou volume, verificada por hash | Formatos RAW/dd, E01 e AFF4 |
| Cópia de trabalho | Duplicata da imagem forense usada na análise | Preserva a imagem forense original |
| Cadeia de custódia | Conjunto de procedimentos para manter e documentar a história cronológica do vestígio, rastreando posse e manuseio do reconhecimento até o descarte | CPP, arts. 158-A a 158-F |
| Integridade | Propriedade de que o dado não foi alterado desde a coleta | Demonstrada por hash |
| Autenticidade | Propriedade de que a evidência é o que se afirma ser, com origem, autoria e momento verificáveis | Depende de metadados e custódia |
| Admissibilidade | Aptidão da evidência para ser aceita em um procedimento | Depende da licitude da obtenção e da custódia |
| Valor probatório | Força da evidência para demonstrar um fato | Aumenta com corroboração por múltiplas fontes |
| Metadados | Dados que descrevem outros dados (autor, datas, tamanho, dispositivo, geolocalização) | Exemplo: EXIF de uma imagem |
| DEFR | Digital Evidence First Responder: pessoa autorizada, treinada e qualificada para atuar na cena inicial e coletar ou adquirir evidências | Papel da ISO/IEC 27037 |
| DES | Digital Evidence Specialist: pessoa com conhecimento especializado para tratar questões técnicas complexas (rede, memória, sistemas específicos) | Papel da ISO/IEC 27037 |

## 4. Aquisição e preservação

| Termo | Definição | Observação |
|---|---|---|
| Identificação | Busca, reconhecimento e documentação das fontes potenciais de evidência | Primeiro processo da ISO/IEC 27037 |
| Coleta | Remoção física do item de seu local original para outro ambiente de custódia | ISO/IEC 27037 |
| Aquisição | Criação de uma cópia do conteúdo digital para análise | ISO/IEC 27037 |
| Preservação | Manutenção da integridade e da autenticidade da evidência ao longo do tempo | ISO/IEC 27037 |
| Aquisição ao vivo (live) | Coleta com o sistema ligado, para capturar dados voláteis | Altera o estado do sistema; documentar |
| Aquisição com sistema desligado (dead) | Aquisição da mídia com o sistema desligado | Perde dados voláteis |
| Triagem (triage) | Exame rápido e priorizado para decidir o que coletar primeiro | Útil em grandes volumes de dispositivos |
| Bloqueador de escrita | Dispositivo ou software que impede gravação na mídia original | Hardware é preferível para discos |
| RAW/dd, E01 e AFF4 | Formatos de imagem forense: bruto, Expert Witness Format (com compressão e metadados) e Advanced Forensic Format 4 | E01 é amplamente suportado |
| Hash | Valor calculado por função criptográfica que identifica o conteúdo | Recomenda-se SHA-256 |
| Colisão | Dois conteúdos distintos com o mesmo hash | Motivo da substituição de MD5 e SHA-1 |
| Volatilidade | Tempo de permanência do dado antes de ser perdido | Base da ordem de coleta (RFC 3227) |
| Snapshot | Cópia pontual de um disco ou VM em nuvem ou virtualização | Preserva estado sem desligar |

## 5. Análise e artefatos

| Termo | Definição | Observação |
|---|---|---|
| Linha do tempo (timeline) | Sequência cronológica de eventos reconstruída a partir de múltiplas fontes | Normalizar para UTC |
| MACB | Modified, Accessed, Changed e Born: os carimbos de data e hora de um arquivo | Variam por sistema de arquivos |
| Timestomping | Alteração deliberada de carimbos de data e hora para ocultar atividade | MITRE ATT&CK T1070.006 |
| File carving | Recuperação de arquivos por assinaturas de cabeçalho e rodapé, sem metadados do sistema de arquivos | Útil em espaço não alocado |
| Slack space | Espaço entre o fim do conteúdo e o fim da unidade de alocação | Pode conter resíduos |
| ADS | Alternate Data Streams do NTFS: fluxos de dados associados a um arquivo | Podem ocultar conteúdo |
| Anti-forense | Técnicas para dificultar ou impedir a análise (apagamento, ofuscação, criptografia, manipulação de tempos) | Documentar indícios no relatório |
| Super timeline | Linha do tempo que combina artefatos de sistema de arquivos, logs e aplicações | Ferramenta típica: Plaso |
| Pivoteamento | Uso de um achado (usuário, IP, hash) para buscar atividade relacionada | Amplia o escopo da análise |
| Correlação | Relação entre eventos de fontes diferentes que reforça uma hipótese | Mínimo de duas fontes independentes |
| Linha de base (baseline) | Comportamento normal de um sistema, usado para detectar desvios | Reduz falsos positivos |
| Falso positivo e falso negativo | Alerta indevido e atividade maliciosa não detectada, respectivamente | Registrar limitações |

## 6. Jurídico e privacidade

| Termo | Definição | Observação |
|---|---|---|
| Perito oficial | Perito designado pelo Estado, com formação superior, para realizar perícias | CPP, art. 159 |
| Assistente técnico | Profissional indicado pela parte para acompanhar a perícia e emitir parecer | CPC, arts. 465 e 466 |
| Quesito | Pergunta formulada pelas partes ou pelo juiz que o perito deve responder | Estrutura o laudo |
| Laudo pericial | Documento do perito com objeto, análise técnica, método e resposta conclusiva aos quesitos | CPC, art. 473 |
| Parecer técnico | Manifestação técnica do assistente técnico ou de consultor | Não substitui o laudo |
| Dado pessoal | Informação relacionada a pessoa natural identificada ou identificável | LGPD, art. 5º, I |
| Dado pessoal sensível | Dado sobre origem racial ou étnica, convicção religiosa, opinião política, saúde, vida sexual, dado genético ou biométrico, entre outros | LGPD, art. 5º, II |
| Controlador, operador e encarregado | Quem decide sobre o tratamento, quem trata em nome do controlador e o canal de comunicação com titulares e ANPD | LGPD, art. 5º, VI, VII e VIII |
| RIPD | Relatório de Impacto à Proteção de Dados Pessoais | LGPD, art. 5º, XVII |
| Necessidade (minimização) | Limitação do tratamento ao mínimo necessário para a finalidade | LGPD, art. 6º, III |

## 7. Exemplo prático de uso correto dos termos

| Formulação imprecisa | Formulação correta |
|---|---|
| "Copiamos o computador do usuário." | "Adquirimos a imagem forense do disco em formato E01, com bloqueador de escrita, e verificamos o hash SHA-256 da fonte e da imagem." |
| "O arquivo foi alterado." | "O carimbo de modificação (M) do arquivo é posterior ao de nascimento (B); há indício de timestomping, a ser corroborado por $UsnJrnl." |
| "Achamos o vírus." | "Identificamos o IOC (hash SHA-256 e domínio de C2) associado à técnica T1055 do MITRE ATT&CK." |
| "A prova é válida." | "A evidência tem cadeia de custódia documentada e integridade verificada; sua admissibilidade é decidida pela autoridade competente." |

## 8. Casos de uso corporativos do glossário

- Padronizar o vocabulário entre SOC, Jurídico, RH e DPO em uma investigação de ameaça interna.
- Alinhar o relatório executivo e o relatório técnico de um incidente de ransomware.
- Treinar novos analistas de DFIR com o mesmo conjunto de termos usado em auditorias.

## 9. Normas e frameworks relevantes

- ISO/IEC 27037:2012 (identificação, coleta, aquisição e preservação) e ABNT NBR ISO/IEC 27037:2013
- ISO/IEC 27035-1:2023 (gestão de incidentes)
- ISO/IEC 27050-1:2019 (e-Discovery)
- LGPD (Lei nº 13.709/2018), art. 5º e art. 6º
- Código de Processo Penal, arts. 158-A a 158-F e 159; Código de Processo Civil, arts. 465, 466 e 473

## 10. Referências

- ABNT NBR ISO/IEC 27037:2013. Tecnologia da informação: técnicas de segurança: diretrizes para identificação, coleta, aquisição e preservação de evidência digital.
- ISO/IEC 27035-1:2023. Information security incident management, Part 1: Principles and process.
- Brasil. Lei nº 13.709/2018 (LGPD).
- Brasil. Decreto-Lei nº 3.689/1941 (Código de Processo Penal), com as alterações da Lei nº 13.964/2019.
- Brasil. Lei nº 13.105/2015 (Código de Processo Civil).
- Casey, E. Digital Evidence and Computer Crime. 3. ed. Academic Press, 2011.
- Sammons, J. The Basics of Digital Forensics. 2. ed. Syngress, 2014.
- MITRE ATT&CK. https://attack.mitre.org
- EDRM Reference Model. https://edrm.net
