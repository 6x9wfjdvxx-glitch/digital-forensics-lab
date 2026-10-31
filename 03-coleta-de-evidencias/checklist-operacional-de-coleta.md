# Checklist Operacional de Coleta de Evidências

> **Objetivo pedagógico:** oferecer uma lista de verificação executável que cobre toda a fase de coleta, do planejamento ao encerramento, reduzindo omissões e permitindo auditoria posterior.

**Caso:** DFL-AAAA-NNN
**Responsável pela coleta:** ____________________
**Data e hora de início (UTC):** ____________________

## 1. Antes de ir a campo

- [ ] Ficha de abertura e termo de autorização assinados
- [ ] Base legal e DPO consultados quando houver dados pessoais
- [ ] Escopo, período e exclusões definidos
- [ ] Plano de coleta aprovado, com fontes priorizadas
- [ ] Kit de resposta conferido (ferramentas, mídias, bloqueadores, material de custódia)
- [ ] Ferramentas validadas e versões registradas
- [ ] Mídia de destino limpa, criptografada e com capacidade suficiente
- [ ] Formulários de custódia e modelos de registro prontos

## 2. Chegada ao local ou início da sessão remota

- [ ] Local e equipamentos fotografados antes de qualquer ação
- [ ] Estado dos dispositivos registrado (ligado, desligado, bloqueado, em hibernação)
- [ ] Horário do sistema, fuso e diferença para UTC registrados
- [ ] Acesso físico ou lógico restringido
- [ ] Decisão entre coleta ao vivo e sistema desligado registrada com justificativa
- [ ] Isolamento de rede aplicado preservando o estado, quando necessário

## 3. Coleta de dados voláteis

- [ ] Memória capturada primeiro, quando aplicável
- [ ] Hash do arquivo de memória calculado
- [ ] Conexões, processos, sessões e serviços coletados
- [ ] Logs de eventos exportados
- [ ] Ferramentas executadas a partir de mídia confiável
- [ ] Saídas gravadas em mídia externa, nunca no disco investigado
- [ ] Diário de coleta preenchido em tempo real

## 4. Aquisição de discos e mídias

- [ ] Bloqueador de escrita utilizado (hardware, quando possível)
- [ ] Modelo e série do bloqueador registrados
- [ ] Dispositivo identificado corretamente antes de iniciar (modelo, série e tamanho)
- [ ] HPA e DCO verificados (discos ATA)
- [ ] Criptografia de disco avaliada e chaves obtidas conforme autorização
- [ ] Imagem criada em E01, RAW ou AFF4
- [ ] Hash da fonte e da imagem calculados e iguais
- [ ] Relatório de verificação arquivado
- [ ] Erros de leitura e setores defeituosos registrados

## 5. Coleta remota e triagem

- [ ] Teste do coletor em hosts de controle
- [ ] Execução em lotes com monitoramento de impacto
- [ ] Identificador e hash por host e por coleta
- [ ] Logs do servidor de coleta e do EDR preservados
- [ ] Contas nominais e privilégios mínimos
- [ ] Hosts não alcançados e limitações registrados

## 6. Logs e fontes de retenção curta

- [ ] Logs de proxy, DNS, VPN, firewall e identidade preservados
- [ ] Logs de M365, nuvem e SaaS exportados antes da expiração
- [ ] Retenções ampliadas ou legal hold aplicados
- [ ] Exportações com hash e manifesto

## 7. Privacidade e legalidade

- [ ] Coleta limitada ao escopo autorizado
- [ ] Conteúdo pessoal e privilegiado tratado conforme orientação do Jurídico e do DPO
- [ ] Dispositivos pessoais coletados somente com consentimento ou base adequada
- [ ] Conteúdo ilícito fora do escopo interrompido, preservado e comunicado

## 8. Custódia

- [ ] Ficha de Identificação (Formulário A) para cada item
- [ ] Registro de Aquisição (Formulário C) para cada imagem
- [ ] Itens embalados individualmente, com lacre numerado
- [ ] Movimentações registradas (Formulário B)
- [ ] Transferências com hash conferido

## 9. Encerramento da coleta

- [ ] Relatório de coleta elaborado, com intercorrências e limitações
- [ ] Impacto da coleta ao vivo declarado
- [ ] Manifesto de hashes arquivado em local separado
- [ ] Mídias e itens armazenados com controle de acesso
- [ ] Líder do caso informado e plano de análise definido
- [ ] Lições aprendidas registradas para melhoria do kit e dos procedimentos

## 10. Resultado da verificação

| Resultado | Condição |
|---|---|
| Conforme | Todos os itens aplicáveis marcados |
| Conforme com ressalvas | Pendências sem impacto na integridade, com plano de ação |
| Não conforme | Falha de autorização, de integridade ou de custódia; comunicação imediata ao líder e ao Jurídico |

**Assinatura do responsável pela coleta:** ____________________
**Assinatura do revisor:** ____________________

## 11. Normas e frameworks relevantes

- ISO/IEC 27037:2012; NIST SP 800-86; RFC 3227
- ISO/IEC 27002:2022, controle 5.28
- CIS Controls v8.1, controles 8 e 17
- LGPD, arts. 6º e 7º

## 12. Referências

- ABNT NBR ISO/IEC 27037:2013.
- Brezinski, D.; Killalea, T. RFC 3227. 2002.
- Kent, K. et al. NIST SP 800-86. 2006.
- SWGDE. Best Practices for Computer Forensic Acquisitions.
