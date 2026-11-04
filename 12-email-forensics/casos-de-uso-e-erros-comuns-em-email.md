# Casos de Uso e Erros Comuns em E-mail

> **Objetivo pedagógico:** consolidar o aprendizado de forense de e-mail com cenários corporativos realistas, os erros mais frequentes, suas consequências e as medidas de prevenção.

Os casos são fictícios e destinados ao treinamento.

## 1. Caso 1: fraude de fornecedor com domínio semelhante

**Pergunta:** o pedido de alteração de dados bancários veio do fornecedor?

| Fonte | Achado |
|---|---|
| Cabeçalhos | Domínio `fornecedor-exemplo.com` (com hífen), diferente do legítimo `fornecedorexemplo.com` |
| Autenticação | SPF, DKIM e DMARC passam para o domínio do atacante |
| `whois` | Domínio criado seis dias antes |
| `Reply-To` | Provedor gratuito |
| Conversa | Mensagem em continuação de uma conversa real (thread hijacking), com histórico copiado |
| Resultado | Falsificação por domínio semelhante; pagamento não realizado após a verificação por telefone com o fornecedor |

**Lição:** "pass" em SPF, DKIM e DMARC não significa legitimidade: verifique o domínio e confirme por um canal independente.

## 2. Caso 2: conta de executiva comprometida (BEC)

| Fonte | Achado |
|---|---|
| Sign-in logs | Entrada a partir de IP e ASN novos, com token reutilizado, às 02:11Z |
| UAL | `New-InboxRule` com nome "." e `Set-Mailbox` com encaminhamento externo |
| Message trace | 4 mensagens para fornecedores com dados bancários novos |
| Contenção | Preservação, revogação de sessões, remoção de regras e encaminhamento, aviso a fornecedores e ao banco |
| Resultado | Um pagamento interceptado pelo banco; os demais não foram efetuados |

**Lição:** a preservação precede a contenção, e a comunicação rápida a bancos e a fornecedores reduz perdas.

## 3. Caso 3: spear phishing com HTML smuggling

| Fonte | Achado |
|---|---|
| Mensagem | Anexo `fatura.html` com bloco base64 e `Reply-To` incomum; DMARC falhou |
| Análise | O script monta e baixa `fatura.iso`, que contém um atalho executando comando oculto |
| Alcance | 38 destinatários, 6 aberturas, 2 execuções confirmadas no EDR |
| Resposta | Purge, bloqueio do domínio e do hash, isolamento das duas estações e revisão de credenciais |

**Lição:** correlacione e-mail, EDR e rede para delimitar o alcance real.

## 4. Caso 4: phishing por QR code

| Fonte | Achado |
|---|---|
| Mensagem | Imagem com QR code, sem links no texto, passando por filtros de URL |
| Análise | QR decodificado em ambiente isolado: página falsa de login do Microsoft 365 |
| Proxy | Acessos de dispositivos móveis (fora do proxy corporativo) a partir de redes celulares |
| Entra ID | Logins das contas afetadas a partir do IP do proxy reverso do atacante (AiTM) |
| Resposta | Revogação de sessões, MFA resistente a phishing, bloqueio do domínio e orientação aos usuários |

**Lição:** links em imagens e em dispositivos pessoais escapam de controles tradicionais; analise as entradas na nuvem.

## 5. Caso 5: vazamento interno por regra de encaminhamento

| Fonte | Achado |
|---|---|
| Auditoria | Regra criada pelo próprio usuário (gerente comercial) para encaminhar mensagens com "proposta" a um endereço pessoal, 4 meses antes do desligamento |
| Message trace | 1.150 mensagens encaminhadas, inclusive propostas e contratos |
| Política | Regra de DLP não bloqueava o encaminhamento para domínios pessoais |
| Medidas | Legal hold, preservação, relatório ao Jurídico e ao RH, revisão da política de encaminhamento externo |

**Lição:** revise periodicamente regras e encaminhamentos externos e bloqueie por política.

## 6. Caso 6: exportação de e-mails para ação trabalhista

| Etapa | Decisão |
|---|---|
| Hold | Litigation hold na caixa do colaborador e de gestores relacionados, antes da exportação |
| Escopo | Pesquisa por período e por palavras-chave, validada pelo Jurídico |
| Exportação | Purview eDiscovery, com relatório de exportação; hash dos arquivos e custódia |
| Privilégio | Filtragem de comunicações com advogados, definida pelo Jurídico |
| Entrega | Pacote com relatório de exportação, manifesto de hashes e termo de extração |

**Lição:** um processo de exportação bem documentado sustenta a autenticidade e a licitude da prova.

## 7. Caso 7: falso positivo de DMARC em e-mail legítimo de marketing

| Fonte | Achado |
|---|---|
| Relatório DMARC | Muitas falhas de alinhamento para IPs de um fornecedor de e-mail marketing |
| Análise | O fornecedor enviava em nome do domínio sem SPF e DKIM configurados para ele |
| Medida | Autorizar o fornecedor no SPF, configurar DKIM com o domínio e revisar a política DMARC |
| Resultado | Mensagens legítimas passam a ser autenticadas; a política pode avançar de `none` para `reject` |

**Lição:** relatórios DMARC revelam fontes legítimas não autenticadas e abusos; analise antes de endurecer a política.

## 8. Erros comuns, consequências e prevenção

| Erro | Consequência provável | Prevenção |
|---|---|---|
| Encaminhar a mensagem como evidência | Cabeçalhos originais perdidos | Exportar o `.eml` ou usar a exportação oficial |
| Trabalhar apenas com impressões ou capturas de tela | Autenticidade contestável | Fonte primária e hash |
| Confiar nos cabeçalhos fora da fronteira de confiança | Conclusões falsas | Considerar somente os adicionados por sua infraestrutura |
| Tratar "DMARC pass" como prova de legitimidade | Falha em detectar domínios semelhantes e contas comprometidas | Verificar o domínio e o comportamento |
| Conter antes de preservar (remover regras, excluir mensagens) | Perda de evidências e alerta ao atacante | Exportar logs e configuração primeiro |
| Clicar em links ou abrir anexos em estações comuns | Infecção e contaminação | Ambiente isolado e neutralização de URLs |
| Ignorar a retenção dos logs e dos itens recuperáveis | Perda irreversível | Preservação imediata e legal hold |
| Esquecer fusos horários nos cabeçalhos | Linha do tempo errada | Converter para UTC |
| Enviar mensagens ou anexos a serviços públicos de análise | Vazamento de dados | Consultar por indicadores e usar ambiente interno |
| Atribuir o ataque a pessoa ou grupo sem evidências fortes | Acusação indevida | Tratar como hipótese e declarar a confiança |
| Não verificar outras contas e destinatários | Comprometimento persistente | Delimitar o alcance por logs |
| Acessar o conteúdo de e-mails sem autorização ou além do escopo | Violação de privacidade e ilicitude | Autorização, DPO e minimização |

## 9. Exercícios práticos

1. Analise três arquivos `.eml` de exercício (por exemplo, de coleções públicas de phishing) e preencha o modelo de análise de cabeçalho.
2. Verifique os registros SPF, DKIM e DMARC de um domínio de teste e explique o resultado para uma mensagem enviada de um servidor não autorizado.
3. Em um laboratório com Microsoft 365 de testes (ou ambiente equivalente), crie uma regra de encaminhamento e identifique-a por auditoria e por `Get-InboxRule`.
4. Gere variações de um domínio com o dnstwist e avalie quais estão registradas.
5. Extraia e calcule o hash dos anexos de uma mensagem de exercício, analise um documento com macros usando `olevba` em ambiente isolado e registre os IOCs.
6. Elabore o relatório de campanha para o caso 3, com linha do tempo, IOCs e recomendações.

Fontes públicas de prática: corpus de phishing (por exemplo, o corpus de Jose Nazario), exercícios de análise de tráfego e de e-mail do site Malware-Traffic-Analysis.net, corpus de spam do SpamAssassin e o corpus Enron (somente para treino de análise de formatos). Use sempre em ambiente isolado.

## 10. Normas e frameworks relevantes

- MITRE ATT&CK: T1566, T1534, T1656, T1078.004, T1114.003, T1098.002, T1528, T1539, T1564.008
- RFC 5321, 5322, 7208, 6376, 7489 e 8601
- NIST SP 800-177 Rev. 1; NIST SP 800-61 Rev. 3
- LGPD, arts. 6º, 7º e 48; CF, art. 5º, X e XII

## 11. Referências

- Rose, S. et al. NIST SP 800-177 Rev. 1: Trustworthy Email. 2019.
- FBI IC3. Business Email Compromise.
- CISA. Phishing Guidance e orientações para Microsoft 365.
- The DFIR Report. Relatórios públicos de intrusões.
- Nazario, J. Phishing Corpus (monkey.org); Malware-Traffic-Analysis.net.
- MITRE ATT&CK. https://attack.mitre.org
