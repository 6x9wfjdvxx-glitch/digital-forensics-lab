# Playbooks de Mobile, OSINT, IA e Casos Especiais

> **Objetivo pedagógico:** executar os playbooks de casos que fogem do fluxo padrão de sistemas e de nuvem: apreensão e aquisição de dispositivo móvel (PB-40), suspeita de stalkerware ou spyware (PB-41), preservação de conteúdo público (PB-42), infraestrutura de phishing e proteção da marca (PB-43), mídia suspeita de manipulação ou de geração por IA (PB-44), incidente envolvendo IA e LLM (PB-45) e retenção legal e eDiscovery (PB-46).

> Os playbooks PB-44 e PB-45 são de **triagem e preservação**. O aprofundamento técnico será tratado nas pastas 24 a 27 deste repositório.

## PB-40: Dispositivo móvel (apreensão e aquisição)

| Campo | Conteúdo |
|---|---|
| Gatilho | Necessidade de examinar smartphone ou tablet em investigação interna, litígio ou incidente |
| Objetivo | Preservar o dispositivo e adquirir os dados de forma lícita, íntegra e proporcional |
| Papéis | Executor: analista mobile. Aprovadores: Jurídico, RH e DPO. Informado: líder |
| Pré-requisitos | Autorização formal, bolsas de Faraday, baterias externas, ferramentas validadas e formulários de custódia |

**Passos**

1. **Portão legal:** autorização, base legal e escopo (dispositivo corporativo ou pessoal; no caso de BYOD, consentimento específico e escopo restrito). Sem autorização, parar.
2. Fotografar o aparelho e o ambiente; registrar o estado (desligado, bloqueado, desbloqueado) e a hora.
3. **Não desligar** um aparelho ligado; manter energia; isolar da rede (bolsa de Faraday ou modo avião documentado).
4. Registrar os identificadores (IMEI, série, SIM e contas) e as informações de gestão (MDM). **Não acionar apagamento remoto.**
5. Obter a credencial por via lícita; **nunca** tentar senhas ou biometria sem plano.
6. Embalar, lacrar e iniciar a custódia (PB-04), com energia.
7. Planejar a aquisição conforme o modelo, a versão e o estado (AFU ou BFU): lógica, sistema de arquivos ou nuvem; registrar o nível de extração e as limitações.
8. Adquirir com ferramenta validada; calcular o hash do pacote; verificar a abertura e as contagens.
9. Trabalhar em cópia; aplicar filtros de escopo e de minimização (período, aplicativos e contatos).
10. Analisar artefatos (comunicações, mídia, localização e uso) e corroborar com nuvem, operadora e MDM.
11. Relatar com limitações; tratar dados de terceiros e conteúdo privilegiado com o Jurídico.

**Escalonamento:** risco de apagamento remoto; dispositivo de alto risco; indício de spyware (PB-41).
**Referências:** pasta 14.

## PB-41: Suspeita de stalkerware ou spyware em dispositivo móvel

| Campo | Conteúdo |
|---|---|
| Gatilho | Relato de monitoramento, alerta oficial de ameaça ou comportamento anômalo em dispositivo de pessoa de alto risco |
| Objetivo | Verificar a presença de monitoramento, preservar e proteger a pessoa afetada |
| Papéis | Executor: analista mobile. Consultados: Jurídico e apoio a vítimas |
| Pré-requisitos | Canal seguro com a pessoa, ferramentas de verificação (por exemplo, MVT) e autorização |

**Passos**

1. **Segurança primeiro:** avaliar o risco para a pessoa; se houver suspeita de monitoramento por alguém próximo, **não remover** o aplicativo nem restaurar o aparelho sem planejamento (pode alertar o autor e elevar o risco).
2. Combinar um **canal seguro** de comunicação, em dispositivo e conta não comprometidos.
3. Preservar o aparelho sem restaurar de fábrica; registrar o estado.
4. Obter backup ou extração e executar as verificações (por exemplo, o MVT com listas de indicadores atualizadas); revisar aplicativos de terceiros, permissões, acessibilidade, perfis e certificados.
5. Se houver indicadores, corroborar com rede, conta e outros artefatos.
6. Planejar com a pessoa: preservação das provas, remoção, troca de credenciais **a partir de dispositivo seguro** e apoio especializado.
7. Registrar o resultado, inclusive negativo, com a limitação de que a ausência de indicadores conhecidos não prova a ausência de comprometimento.

**Referências:** pasta 14.

## PB-42: Preservação de conteúdo público (OSINT)

| Campo | Conteúdo |
|---|---|
| Gatilho | Publicação, página ou perfil público relevante e sujeito a remoção |
| Objetivo | Preservar o conteúdo com metadados, hash e método, para uso como prova |
| Papéis | Executor: analista OSINT. Consultado: Jurídico |
| Pré-requisitos | VM de investigação, perfil de navegador dedicado e ferramentas de captura |

**Passos**

1. Confirmar o requisito, a finalidade e a base legal; aplicar a minimização.
2. Preparar o ambiente isolado; verificar o relógio.
3. Capturar: **captura da página inteira**, arquivo estrutural (WARC ou HTML) e cabeçalhos; registrar a URL exata, a cadeia de redirecionamentos e os identificadores estáveis da conta e da publicação.
4. Calcular o hash e registrar data e hora (UTC), coletor, ferramenta e versão.
5. Arquivar em local protegido; avaliar arquivamento independente **privado** (o arquivamento público torna o conteúdo público).
6. **Decisão:** a prova é crítica? Solicitar **ata notarial** ou serviço de certificação.
7. Preencher a ficha de coleta e a custódia.

```bash
wget --warc-file=DFL-2026-001-W001 --warc-header="Caso: DFL-2026-001" --page-requisites --no-parent --adjust-extension "https://exemplo.com.br/pagina"
sha256sum DFL-2026-001-W001.warc.gz > DFL-2026-001-W001.warc.gz.sha256
curl -sIL --max-redirs 10 "https://exemplo.com.br/pagina" > DFL-2026-001-W001.cabecalhos.txt
```

**Referências:** pastas 02, 04, 06 e 21.

## PB-43: Infraestrutura de phishing e proteção da marca

| Campo | Conteúdo |
|---|---|
| Gatilho | Domínio semelhante, página clonada, perfil falso ou anúncio fraudulento usando a marca |
| Objetivo | Documentar a infraestrutura, agrupá-la e obter a remoção e o bloqueio |
| Papéis | Executor: analista OSINT e de CTI. Consultado: Jurídico e comunicação |
| Pré-requisitos | Ambiente isolado; contatos de registradores e plataformas |

**Passos**

1. Preservar a página e os indicadores (PB-42), com URLs neutralizadas nos registros.
2. Coletar a infraestrutura **de forma passiva**: RDAP, DNS e DNS passivo, certificados (CT), hospedagem e impressões digitais.
3. Agrupar infraestrutura relacionada usando **atributos múltiplos e raros**; declarar a confiança.
4. Avaliar o risco e o alcance (clientes expostos, volume e urgência).
5. Bloquear em DNS, proxy e gateway; alertar clientes e parceiros, conforme o caso.
6. Enviar pedidos de remoção ao registrador, à hospedagem e às plataformas, com as provas preservadas; avaliar medidas de disputa e judiciais com o Jurídico.
7. Compartilhar indicadores (TLP) e acompanhar a remoção; monitorar o reaparecimento.
8. Não atribuir autoria a pessoas com base em dados de registro.

**Referências:** pastas 12 e 21.

## PB-44: Mídia suspeita de manipulação ou de geração por IA (triagem)

| Campo | Conteúdo |
|---|---|
| Gatilho | Vídeo, áudio ou imagem que afeta a organização ou a pessoa e suspeita de ser sintético ou manipulado |
| Objetivo | Preservar, triar a proveniência e escalar ao especialista adequado |
| Papéis | Executor: analista de mídia e OSINT. Consultados: Jurídico e comunicação |
| Pré-requisitos | Ambiente isolado e ferramentas de metadados e de busca reversa |

**Passos**

1. **Preservar o original** (arquivo e página de origem) com hash; não converter nem recomprimir.
2. Registrar a origem, a primeira ocorrência conhecida e a conta que publicou (PB-42).
3. Extrair metadados e quadros-chave; fazer a busca reversa para identificar reutilização e contexto anterior.
4. Avaliar a **fonte** (conta, histórico e rede de contas) e a **proveniência** (credenciais de conteúdo, quando presentes).
5. Registrar inconsistências visuais e sonoras observáveis, **sem concluir** apenas por elas.
6. **Decisão:** a gravidade e o impacto exigem análise especializada? Escalar (pasta 27).
7. Preparar as ações de proteção: comunicado oficial, denúncias às plataformas e orientação jurídica.
8. Comunicar apenas o que está verificado; declarar a confiança.

```bash
exiftool -a -G1 -s arquivo.mp4 > metadados.txt
ffprobe -v quiet -print_format json -show_format -show_streams arquivo.mp4 > ffprobe.json
sha256sum arquivo.mp4 > arquivo.mp4.sha256
```

**Referências:** pastas 21 e 27 (aprofundamento).

## PB-45: Incidente envolvendo IA e modelos de linguagem (triagem e preservação)

| Campo | Conteúdo |
|---|---|
| Gatilho | Vazamento de dados por uso de IA, comportamento anômalo de um assistente, abuso de prompt ou saída que expõe informação indevida |
| Objetivo | Preservar os registros do incidente, delimitar o escopo e acionar as equipes adequadas |
| Papéis | Executor: analista forense. Consultados: dono do sistema de IA, Jurídico e DPO |
| Pré-requisitos | Inventário dos sistemas de IA, acessos aos logs e contato com fornecedores |

**Passos**

1. Identificar o sistema, o modelo e a versão, o fornecedor e os dados envolvidos.
2. **Preservar** os registros: prompts, respostas, logs de acesso, configurações, ferramentas conectadas, versões de modelos e instruções do sistema, com hash.
3. Aplicar **retenção legal** nos registros do aplicativo e do fornecedor, quando possível.
4. Determinar quem acessou, quais dados foram expostos e se houve dados pessoais ou sigilosos.
5. Verificar se há comprometimento de contas, de chaves de API ou de fontes de dados conectadas.
6. Conter: restringir o acesso, revogar chaves e desabilitar integrações afetadas, registrando o estado anterior.
7. Avaliar as notificações (Jurídico e DPO) e a comunicação ao fornecedor.
8. Escalar para a análise especializada (pastas 24 a 26) e registrar as lições aprendidas.

**Referências:** pastas 19 (Copilot e auditoria), 24, 25 e 26 (aprofundamento).

## PB-46: Retenção legal e solicitação de eDiscovery

| Campo | Conteúdo |
|---|---|
| Gatilho | Ordem judicial, litígio previsto, auditoria, investigação interna ou solicitação do Jurídico |
| Objetivo | Preservar o conteúdo relevante, coletar com escopo definido e exportar de forma defensável |
| Papéis | Executor: especialista em eDiscovery. Aprovadores: Jurídico e DPO |
| Pré-requisitos | Funções de eDiscovery com privilégio mínimo, escopo escrito e política de retenção |

**Passos**

1. Receber a solicitação por escrito, com escopo (pessoas, período, fontes e palavras-chave) e base legal.
2. **Aplicar a retenção legal primeiro** (caixas, OneDrive, sites, Teams e outras fontes), e confirmar o estado.
3. Elaborar e testar a consulta; registrar o texto completo e a versão.
4. Executar a pesquisa; validar estatísticas e amostras com o Jurídico.
5. Revisar privilégio e confidencialidade (Jurídico) e aplicar a minimização.
6. Exportar com relatórios; calcular hashes; registrar custódia.
7. Entregar por canal seguro, com termo de extração e controle de acesso.
8. Manter as retenções até a autorização formal de encerramento; registrar o encerramento e o descarte.

**Referências:** pastas 06, 19 e 22.

## Resumo dos playbooks deste arquivo

| ID | Playbook | Quando usar |
|---|---|---|
| PB-40 | Dispositivo móvel | Apreensão e aquisição |
| PB-41 | Stalkerware e spyware | Suspeita de monitoramento |
| PB-42 | Preservação OSINT | Conteúdo público volátil |
| PB-43 | Infraestrutura de phishing e marca | Domínios e perfis falsos |
| PB-44 | Mídia suspeita de manipulação ou de IA | Triagem e escalonamento |
| PB-45 | Incidente com IA e LLM | Triagem e preservação |
| PB-46 | Retenção legal e eDiscovery | Ordens, litígios e auditorias |

## Exemplo prático: vídeo falso de executivo com divulgação de fraude

| Etapa | Playbook | Resultado |
|---|---|---|
| Vídeo circula nas redes | PB-42 | Preservação do vídeo, da publicação e do perfil, com hash e ata notarial |
| Suspeita de manipulação | PB-44 | Busca reversa mostra reutilização de uma entrevista antiga; escalado para análise especializada |
| Domínios do link fraudulento | PB-43 | 7 domínios e 2 IPs agrupados; pedidos de remoção |
| Comunicação | Jurídico e comunicação | Comunicado oficial e denúncias às plataformas com as provas |

## Casos de uso corporativos

- Resposta padronizada a casos de mobile, de marca e de mídia suspeita.
- Preservação consistente de conteúdo público para uso em litígios.
- Preparação do laboratório para incidentes com IA, com triagem e escalonamento claros.

## Normas e frameworks relevantes

- ISO/IEC 27037; NIST SP 800-101 Rev. 1; NIST SP 800-124 Rev. 2; Protocolo de Berkeley
- NIST AI RMF 1.0; ISO/IEC 42001:2023; ISO/IEC 27050 (eDiscovery); C2PA
- MITRE ATT&CK Mobile; MITRE ATLAS (ameaças a sistemas de IA)
- CPC, art. 384 (ata notarial); LGPD, arts. 6º, 7º, 46 e 48

## Referências

- Pastas 06, 14, 19, 21, 22 e (futuramente) 24 a 27 deste repositório.
- ONU (OHCHR) e UC Berkeley. Berkeley Protocol on Digital Open Source Investigations. 2020.
- NIST. AI Risk Management Framework 1.0 (2023); MITRE ATLAS.
