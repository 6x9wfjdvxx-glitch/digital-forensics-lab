# 27 Investigação de Deepfakes

## Objetivo

Investigar mídias sintéticas e manipuladas (imagem, vídeo e áudio) com foco em detecção, preservação e resposta: priorizar a proveniência (arquivo original, credenciais de conteúdo, metadados e marcas d'água), conduzir a análise técnica com múltiplas linhas de evidência e detectores validados, investigar fraudes por voz, por videochamada e por identidade sintética (KYC), proteger vítimas de conteúdo íntimo e de assédio com preservação mínima, conduzir a resposta jurídica e de comunicação, e formular conclusões por hipóteses com graus de confiança e limitações, considerando também o risco de mídias autênticas serem desqualificadas como falsas.

## Trilha de estudo recomendada

```mermaid
flowchart LR
    A["1. Fundamentos"] --> B["2. Proveniência e metadados"]
    B --> C["3. Imagens e vídeos"]
    C --> D["4. Áudio e fraudes por voz"]
    D --> E["5. KYC e videochamadas"]
    E --> F["6. Vítimas, jurídico e desinformação"]
    F --> G["7. Ferramentas e checklist"]
    G --> H["8. Casos e erros comuns"]
```

## Conteúdo da pasta

| Ordem | Arquivo | Objetivo |
|---|---|---|
| 1 | [fundamentos-de-midias-sinteticas-e-deepfakes.md](fundamentos-de-midias-sinteticas-e-deepfakes.md) | Terminologia, ameaças, perguntas forenses, hipóteses e confiança |
| 2 | [proveniencia-metadados-c2pa-e-marcas-dagua.md](proveniencia-metadados-c2pa-e-marcas-dagua.md) | Aquisição do original, C2PA, metadados, marcas d'água e estrutura de arquivos |
| 3 | [analise-tecnica-de-imagens-e-videos-sinteticos.md](analise-tecnica-de-imagens-e-videos-sinteticos.md) | Análise visual, de sinal e temporal, e uso de detectores |
| 4 | [audio-sintetico-clonagem-de-voz-e-fraudes-por-voz.md](audio-sintetico-clonagem-de-voz-e-fraudes-por-voz.md) | Áudio, codecs, comparação de voz, telefonia e resposta financeira |
| 5 | [fraudes-de-identidade-kyc-e-videochamadas-sinteticas.md](fraudes-de-identidade-kyc-e-videochamadas-sinteticas.md) | Ataques de injeção, KYC, videochamadas, documentos e recrutamento |
| 6 | [protecao-de-vitimas-resposta-juridica-e-desinformacao.md](protecao-de-vitimas-resposta-juridica-e-desinformacao.md) | Abordagem centrada na vítima, remoção, caminhos jurídicos e comunicação |
| 7 | [ferramentas-fluxo-modelos-e-checklist-de-deepfakes.md](ferramentas-fluxo-modelos-e-checklist-de-deepfakes.md) | Ferramentas, modelos de registro e checklist |
| 8 | [casos-de-uso-e-erros-comuns-em-investigacao-de-deepfakes.md](casos-de-uso-e-erros-comuns-em-investigacao-de-deepfakes.md) | Sete cenários, erros comuns e exercícios |

## Princípios

- Proveniência primeiro: obter o arquivo mais próximo do original e preservar com hash e cadeia de transmissão
- Raciocínio por hipóteses (autêntica, edição convencional, parcialmente sintética, totalmente sintética e indeterminada), nunca "falso ou verdadeiro" por aparência
- Nenhuma linha de evidência é conclusiva: buscar convergência de proveniência, contexto, análise técnica e registros
- Detectores baseados em modelos são apoio, com validação, limiar e taxa de erro registrados
- Considerar o dividendo do mentiroso: mídias autênticas também podem ser desqualificadas
- Contenção financeira e de acesso imediata, sem aguardar a conclusão da análise; verificação por canal independente
- Abordagem centrada na vítima, preservação mínima e escalonamento imediato diante de crianças e adolescentes
- Declarar o grau de confiança e as limitações; atribuir autoria apenas com evidências sólidas e por processo legal

## Relação com outras pastas

- 02, 04 e 05: custódia, hash e linha do tempo
- 06 e 22: evidências digitais, valor probatório e relatórios
- 12 e 14: e-mail, mensageiros e dispositivos móveis
- 18 e 19: identidade, videoconferência e auditoria no Microsoft 365
- 21: OSINT, preservação de conteúdo público e infraestrutura de difusão
- 23: playbooks PB-32, PB-42, PB-44 e PB-46
- 24, 25 e 26: forense de IA, de prompts e incidentes com LLM
- 28: estudos de caso
- 30: lições aprendidas

## Referências

- C2PA. Technical Specification; Content Authenticity Initiative (c2patool)
- SWGDE. Best Practices for Image Authentication; ISO 21043; ISO/IEC 27037, 27041, 27042
- NIST AI 100-4 e NIST AI 600-1; programa NIST GenAI; ISO/IEC 30107; ICAO Doc 9303
- Verdoliva, L. Media Forensics and DeepFakes: An Overview (2020); Chesney, R.; Citron, D. (2019)
- Rössler, A. et al. FaceForensics++ (2019); Dolhansky, B. et al. DFDC (2020); ASVspoof
- Protocolo de Berkeley; WITNESS. Prepare, Don't Panic; Partnership on AI. Responsible Practices for Synthetic Media
- Brasil. LGPD (Lei nº 13.709/2018); Código Penal; ECA (Lei nº 8.069/1990); Marco Civil da Internet (Lei nº 12.965/2014); Lei nº 11.340/2006; CPC; CPP
- Regulamento (UE) 2024/1689 (AI Act), art. 50; Resolução TSE nº 23.610/2019 (com alterações)
- StopNCII.org; NCMEC. Take It Down; SaferNet Brasil
