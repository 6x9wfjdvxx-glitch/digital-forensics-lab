# Checklist Operacional de Fundamentos

> **Objetivo pedagógico:** oferecer uma lista de verificação executável que consolida os princípios, as fases e os controles de qualidade em ações do dia a dia, reduzindo o risco de omissões em campo.

**Caso:** DFL-AAAA-NNN
**Responsável:** ____________________
**Data e hora de início (UTC):** ____________________

## 1. Prontidão (antes do incidente)

- [ ] Política de resposta e de forense aprovada e comunicada
- [ ] Inventário de ativos e fontes de log atualizado
- [ ] Sincronização de tempo (NTP) configurada nos sistemas e nos logs
- [ ] Retenção de logs compatível com a necessidade investigativa
- [ ] Kit de resposta atualizado, com mídias confiáveis somente leitura
- [ ] Ferramentas validadas e versões registradas
- [ ] Contatos de Jurídico, DPO, RH, TI e fornecedores atualizados
- [ ] Exercício de resposta realizado no último ano

## 2. Abertura do caso

- [ ] Ficha de abertura preenchida e identificador do caso atribuído
- [ ] Base legal e autorização registradas
- [ ] Escopo, período e exclusões definidos
- [ ] Perguntas investigativas formuladas de modo neutro
- [ ] Declaração de imparcialidade assinada pela equipe
- [ ] Legal hold emitido, quando aplicável
- [ ] DPO consultado sobre dados pessoais e RIPD

## 3. Preservação inicial

- [ ] Logs de retenção curta preservados (proxy, M365, nuvem, VPN, EDR)
- [ ] Estado inicial do ambiente fotografado e descrito
- [ ] Decisão entre coleta ao vivo e sistema desligado registrada com justificativa
- [ ] Isolamento de rede aplicado preservando dados voláteis
- [ ] Fuso horário e diferença do relógio em relação ao UTC registrados

## 4. Coleta e aquisição

- [ ] Memória capturada antes de outras ações, quando aplicável
- [ ] Dados voláteis coletados na ordem de volatilidade
- [ ] Ferramentas executadas a partir de mídia confiável
- [ ] Saídas gravadas em mídia externa dedicada
- [ ] Bloqueador de escrita utilizado para discos
- [ ] Hash SHA-256 da fonte e da imagem calculados e comparados
- [ ] Ferramenta, versão, parâmetros e horário registrados em cada aquisição
- [ ] Lacres e etiquetas aplicados

## 5. Cadeia de custódia

- [ ] Formulário de custódia aberto com identificador único por item
- [ ] Cada transferência registrada com data, hora, origem, destino e assinaturas
- [ ] Armazenamento seguro com controle de acesso
- [ ] Cópias de trabalho criadas; original preservado
- [ ] Hash verificado a cada cópia ou transferência

## 6. Exame e análise

- [ ] Trabalho realizado exclusivamente em cópias
- [ ] Imagens montadas em modo somente leitura
- [ ] Ferramentas e versões registradas
- [ ] Todos os horários normalizados para UTC
- [ ] Linha do tempo construída com mais de uma fonte
- [ ] Hipóteses alternativas consideradas e registradas
- [ ] Conclusões corroboradas por ao menos duas fontes independentes
- [ ] Achados mapeados ao MITRE ATT&CK, quando aplicável
- [ ] Limitações e incertezas documentadas

## 7. Privacidade e legalidade

- [ ] Coleta limitada ao escopo autorizado
- [ ] Dados pessoais e sensíveis com acesso restrito
- [ ] Conteúdo fora do escopo interrompido, preservado e comunicado ao Jurídico
- [ ] Comunicações com a ANPD e com titulares decididas pelo Jurídico e pelo DPO

## 8. Relato

- [ ] Relatório técnico e sumário executivo elaborados
- [ ] Cada afirmação ligada a uma evidência e a um método
- [ ] Hashes, cadeia de custódia e lista de ferramentas anexados
- [ ] Revisão por pares realizada
- [ ] Classificação de confidencialidade aplicada e distribuição controlada

## 9. Encerramento

- [ ] Evidências retidas ou descartadas conforme política e legal hold
- [ ] Termo de descarte registrado, quando aplicável
- [ ] Reunião de lições aprendidas realizada
- [ ] Ações corretivas com responsável e prazo
- [ ] Playbooks, detecções e fontes de log atualizados
- [ ] Caso arquivado com índice de evidências

## 10. Critérios de aprovação

| Resultado | Condição |
|---|---|
| Conforme | Todos os itens aplicáveis marcados |
| Conforme com ressalvas | Itens pendentes sem impacto na integridade, com plano de ação |
| Não conforme | Falha em integridade, custódia ou autorização; exige comunicação ao líder e ao Jurídico |

**Assinatura do responsável:** ____________________
**Assinatura do revisor:** ____________________

## 11. Normas e frameworks relevantes

- ISO/IEC 27037, 27041, 27042 e 27043
- NIST SP 800-86 e NIST SP 800-61 Rev. 3
- RFC 3227
- CIS Controls v8.1, controles 8 e 17
- ISO/IEC 27002:2022, controles 5.24 a 5.28

## 12. Referências

- ISO/IEC 27037:2012.
- Brezinski, D.; Killalea, T. RFC 3227. 2002.
- NIST SP 800-86. 2006.
- Center for Internet Security. CIS Controls v8.1. 2024.
- SANS Institute. Incident Handler's Handbook. 2011.
