# Casos de Uso e Erros Comuns em Investigação de Deepfakes

> **Objetivo pedagógico:** consolidar o aprendizado de investigação de mídias sintéticas com cenários corporativos realistas, os erros mais frequentes, suas consequências e as medidas de prevenção.

Os casos são fictícios e destinados ao treinamento.

## 1. Caso 1: mensagem de voz do diretor ordena transferência

| Fonte | Achado |
|---|---|
| Fato | Mensagem de voz, em aplicativo de mensagens, com a voz do diretor, ordenando uma transferência urgente e sigilosa |
| Controle | A analista ligou de volta para o número cadastrado; o diretor negou a ordem; a transferência foi bloqueada |
| Preservação | Áudio original do aparelho, com hash; conversa exportada; registros do número de origem |
| Análise | Áudio reencodificado pelo aplicativo; prosódia uniforme e ausência de respiração; número de origem recente e sem relação com o diretor |
| Conclusão | Confiança moderada a alta de voz sintética, apoiada principalmente no contexto; controles reforçados |

**Lição:** a verificação por canal independente interrompeu a fraude antes de qualquer análise técnica.

## 2. Caso 2: videoconferência com "diretor financeiro" sintético

| Fonte | Achado |
|---|---|
| Fato | Em uma videochamada com vários "colegas", um funcionário recebeu a instrução de realizar transferências para novas contas |
| Registros da plataforma | Os participantes entraram por convites externos, com nomes exibidos semelhantes aos de colegas; endereços IP e dispositivos não correspondiam aos dos colegas |
| Endpoint | Sem evidências no dispositivo do funcionário (somente visualizou a reunião) |
| Registros financeiros | 5 transferências a contas recém-abertas em 36 horas |
| Resposta | Contestação imediata com o banco, retenção parcial de valores, preservação das gravações e dos registros, revisão de políticas de aprovação |

**Lição:** registros de convites, de identidade e de dispositivos corroboraram a fraude mais do que a análise visual; pagamentos nunca devem ser autorizados apenas por videochamada.

## 3. Caso 3: vídeo falso de executivo em redes sociais

| Fonte | Achado |
|---|---|
| Fato | Vídeo com declaração polêmica atribuída ao CEO circula em perfis anônimos |
| Proveniência | Sem C2PA e sem arquivo original; primeira ocorrência em perfil anônimo; busca reversa sem fonte anterior |
| Técnica | Halo no contorno do rosto em rotações; reflexo dos óculos incoerente; ruído do rosto mais suave que o do fundo; desalinhamento labial |
| Contexto | O CEO estava em evento sem gravação; nenhuma fonte independente corrobora a declaração |
| Resposta | Comunicado oficial, pedidos de remoção com provas preservadas (WARC e ata notarial), adoção de credenciais de conteúdo nas comunicações oficiais |

**Lição:** a convergência de proveniência, contexto e vestígios técnicos sustentou uma conclusão; nenhuma linha, isoladamente, bastaria.

## 4. Caso 4: conteúdo íntimo sintético de uma colaboradora

| Fonte | Achado |
|---|---|
| Fato | Imagens íntimas sintéticas com o rosto da colaboradora circulam em grupo interno e em perfil externo |
| Conduta | Acolhimento, equipe restrita, preservação mínima (URLs, contas, horários e ata notarial), denúncias às plataformas, StopNCII.org, orientação para ocorrência policial |
| Apuração interna | Registros do grupo indicam o primeiro compartilhamento; RH e Jurídico conduziram o procedimento com direito de defesa |
| Resultado | Remoção em 48 horas, processo disciplinar concluído e apoio contínuo à vítima |

**Lição:** minimizar a exposição e centrar a resposta na vítima é tão importante quanto a análise técnica.

## 5. Caso 5: áudio apresentado como prova em disputa trabalhista

| Fonte | Achado |
|---|---|
| Fato | Um ex-colaborador apresenta uma gravação em que um gerente supostamente o ameaça |
| Arquivo | Cópia de um aplicativo de mensagens, reencodificada; sem o dispositivo de gravação original |
| Análise | Espectrograma com cortes de banda típicos do canal; sem sinais conclusivos de síntese ou de edição; vozes comparáveis, mas sem material de referência no mesmo canal |
| Contexto | A data e o local alegados são incompatíveis com a agenda e com os registros de acesso do gerente |
| Conclusão | Indeterminada quanto à síntese; o contexto contradiz a alegação; recomendação de perícia com o aparelho original e material de referência, assegurado o contraditório |

**Lição:** quando o arquivo está degradado, declare "indeterminada" e apoie-se em corroboração; peça o dispositivo original.

## 6. Caso 6: vídeo real alegado como deepfake

| Fonte | Achado |
|---|---|
| Fato | Um gestor, filmado em uma reunião, alega que o vídeo é um deepfake |
| Proveniência | O vídeo foi obtido do sistema de gravação da reunião, com registros de entrada de todos os participantes e hashes de arquivo coerentes |
| Corroboração | Três participantes confirmam a fala; a transcrição automática do sistema coincide; metadados do contêiner coerentes |
| Análise técnica | Sem anomalias relevantes; qualidade adequada |
| Conclusão | Alta confiança de autenticidade, apoiada em proveniência e corroboração independente |

**Lição:** a alegação de deepfake não deve ser aceita sem verificação: o dividendo do mentiroso é um risco real.

## 7. Caso 7: rede de contas abertas com identidades sintéticas

| Fonte | Achado |
|---|---|
| Alerta | 64 contas em 10 dias, aprovadas automaticamente, com movimentações semelhantes |
| KYC | 41 sessões com câmera virtual; 9 impressões digitais de dispositivo explicam 52 contas |
| Mídias | Rostos sintéticos reaproveitados; hashes perceptuais agrupam as imagens; documentos com erros nos dígitos verificadores da MRZ |
| Resposta | Bloqueio de contas e dispositivos, retenção de valores, comunicação às áreas e às autoridades, detecção de injeção, leitura de chip NFC e revisão humana de risco |

**Lição:** o agrupamento por dispositivo e por reutilização de mídias revelou a rede; a defesa está no canal de captura e na validação do documento.

## 8. Erros comuns, consequências e prevenção

| Erro | Consequência provável | Prevenção |
|---|---|---|
| Concluir apenas pela "aparência" de falsidade ou de autenticidade | Conclusões erradas e contestáveis | Raciocínio por hipóteses e corroboração independente |
| Usar a pontuação de um detector como prova isolada | Falsos positivos e negativos | Validação, uso como apoio e múltiplas linhas de evidência |
| Analisar uma cópia recomprimida sem registrar a degradação | Interpretações indevidas de artefatos | Obter o original e registrar a qualidade |
| Confiar em critérios ultrapassados (por exemplo, piscadas) | Falsa segurança | Atualizar os métodos e validar com amostras |
| Presumir que a ausência de C2PA, de metadados ou de marca d'água indica falsidade | Erros de interpretação | Ausência é neutra; credenciais só provam o que o emissor declarou |
| Presumir que metadados presentes provam autenticidade | Aceitar mídia forjada | Metadados são editáveis; corroborar |
| Ignorar o dividendo do mentiroso | Rejeitar provas reais | Verificar de forma neutra e por evidências positivas |
| Demorar nas ações financeiras para concluir a análise | Perdas evitáveis | Contenção imediata e verificação independente (PB-32) |
| Autorizar pagamentos por voz ou videochamada | Fraude | Verificação por canal independente e dupla aprovação |
| Enviar mídias sensíveis a detectores externos | Nova exposição e violação de privacidade | Autorização, contratos e ferramentas internas |
| Copiar, compartilhar ou armazenar conteúdo íntimo ou de menores | Revitimização e responsabilidade legal | Preservação mínima, escalonamento e protocolos do arquivo 6 |
| Atribuir autoria a uma pessoa por indícios frágeis | Injustiças e danos | Evidências sólidas e processo legal |
| Comunicar publicamente de forma categórica e prematura | Retratações e danos à reputação | Verificar antes e declarar incertezas |
| Amplificar o conteúdo falso no comunicado | Mais difusão | Descrever o conteúdo, sem reproduzi-lo |
| Confiar apenas na imagem em KYC | Ataques de injeção passam | Sinais de dispositivo, atestação e validação de chip |
| Não validar ferramentas e métodos com amostras de referência | Resultados não defensáveis | Validação documentada |

## 9. Exercícios práticos

1. Pratique o fluxo de proveniência com imagens **autênticas suas**: calcule hashes, extraia metadados com o ExifTool, leia credenciais com o `c2patool` (quando existirem) e documente o modelo B.
2. Com ferramentas de geração que você tenha licença para usar, produza **imagens e áudios sintéticos benignos de teste** (sem pessoas reais, sem conteúdo íntimo e sem usar a voz ou o rosto de terceiros sem consentimento) e compare os metadados e os espectros com os de arquivos autênticos.
3. Use conjuntos públicos de pesquisa (por exemplo, FaceForensics++ e ASVspoof, conforme as licenças) para praticar a extração de quadros, a análise de espectrogramas e a validação de um detector, registrando as taxas de erro no modelo D.
4. Recomprima uma mídia autêntica em diferentes níveis de qualidade e observe como as análises de compressão, de ruído e de espectro mudam; escreva uma nota sobre as limitações.
5. Escreva consultas SQL de agrupamento por impressão digital de dispositivo em dados **fictícios** de KYC e identifique um anel de contas simulado.
6. Implemente e teste a validação de dígitos verificadores da MRZ com exemplos fictícios.
7. Realize um exercício de mesa do caso 1 (voz do diretor) com Financeiro, Jurídico e Comunicação, usando o fluxo do arquivo 4 e o PB-32.
8. Redija um protocolo interno de resposta a conteúdo íntimo sintético (arquivo 6), com papéis, apoio à vítima, preservação mínima e comunicação restrita.

Use somente material próprio, dados fictícios, conjuntos públicos licenciados e ambientes de laboratório. Não produza, distribua nem armazene mídias sintéticas de pessoas reais sem consentimento, nem qualquer conteúdo íntimo ou envolvendo menores.

## 10. Normas e frameworks relevantes

- ISO/IEC 27037, 27041, 27042; ISO 21043; SWGDE; C2PA; Protocolo de Berkeley
- NIST AI 100-4; ISO/IEC 30107; Regulamento (UE) 2024/1689, art. 50
- LGPD, arts. 5º, 6º, 11, 20 e 46; Código Penal, arts. 171, 218-C, 299 e 307; ECA, arts. 240 a 241-E; CPC, arts. 422 e 439 a 441

## 11. Referências

- Chesney, R.; Citron, D. Deep Fakes: A Looming Challenge. 2019.
- Verdoliva, L. Media Forensics and DeepFakes: An Overview. 2020.
- Rössler, A. et al. FaceForensics++. 2019; Dolhansky, B. et al. DFDC. 2020; ASVspoof (relatórios).
- WITNESS. Prepare, Don't Panic; Partnership on AI. Responsible Practices for Synthetic Media.
- Pastas 21, 22, 23, 24, 25 e 26 deste repositório.
