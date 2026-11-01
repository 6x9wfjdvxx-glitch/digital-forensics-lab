# Casos de Uso e Erros Comuns em Evidências

> **Objetivo pedagógico:** consolidar o aprendizado sobre evidências digitais com cenários corporativos, os erros mais frequentes, suas consequências e as medidas de prevenção.

Os casos são fictícios e destinados ao treinamento.

## 1. Caso 1: ação trabalhista com mensagens de aplicativo

**Contexto:** ex-colaborador alega ter sido pressionado por mensagens fora do horário de trabalho. A empresa tem capturas de tela das conversas.

| Etapa | Decisão |
|---|---|
| Diagnóstico | Capturas de tela são frágeis e impugnáveis |
| Fonte | Obter, com autorização, a extração forense do dispositivo corporativo ou do backup |
| Autenticação | Hash, metadados, ata notarial e confirmação do outro participante |
| Contexto | Apresentar a conversa completa do período, e não apenas trechos |
| Resultado | Dossiê com extração, hash, linha do tempo de mensagens e limitações |

**Lição:** a captura de tela serve para fixar, mas a força probatória vem da extração e da corroboração.

## 2. Caso 2: e-mail de pagamento fraudulento (BEC)

**Contexto:** fornecedor recebeu e-mail com nova conta bancária. A empresa alega falsificação.

| Etapa | Decisão |
|---|---|
| Fonte | Exportar a mensagem original (`.eml`) do destinatário e do servidor |
| Autenticação | Analisar `Received`, SPF, DKIM e DMARC; comparar domínios semelhantes |
| Corroboração | Logs do gateway de e-mail e logs de entrada na conta supostamente envolvida |
| Reforço | Ata notarial da caixa do destinatário |
| Resultado | O DKIM não valida e o domínio é semelhante ao real: indício forte de falsificação, com confiança alta |

**Lição:** o cabeçalho completo e as autenticações do e-mail contam mais do que a impressão da mensagem.

## 3. Caso 3: conteúdo difamatório removido da web

**Contexto:** a empresa percebe postagens ofensivas e as perde após o autor apagar o perfil.

| Etapa | Decisão |
|---|---|
| Ação imediata | Captura técnica (WARC, PDF, imagem), hash e carimbo do tempo |
| Reforço | Ata notarial no mesmo dia |
| Plataforma | Pedido de preservação de registros e ordem judicial para fornecimento (Marco Civil, arts. 15, §2º, e 22) |
| Correlação | Registros de acesso e IPs com dados do provedor de conexão |

**Lição:** velocidade na preservação decide o caso; depois da exclusão, a prova depende da plataforma e do Judiciário.

## 4. Caso 4: contestação de log de acesso

**Contexto:** investigado nega ter acessado o repositório às 02:13 e alega que o log foi alterado.

| Etapa | Decisão |
|---|---|
| Integridade | Hash do log exportado e do manifesto; armazenamento imutável |
| Fonte independente | Registros do firewall, da VPN e do EDR corroboram o acesso |
| Relógio | Demonstrar a sincronização e a margem de erro |
| Autoria | Correlacionar conta, dispositivo, sessão e padrões de uso |
| Resultado | Acesso confirmado com confiança alta; autoria da pessoa sem confirmação conclusiva do uso por terceiros descartado: declarado como limitação |

**Lição:** um log isolado é frágil; mais de uma fonte independente e a defesa da integridade fortalecem a prova.

## 5. Caso 5: fotografia ou vídeo possivelmente manipulado

**Contexto:** vídeo atribuído a um executivo circula em redes com declarações polêmicas.

| Etapa | Decisão |
|---|---|
| Preservação | Obter o arquivo original e a cadeia de distribuição, com hash |
| Análise | Metadados, codec, histórico de edição e consistência visual e acústica |
| Proveniência | Buscar a versão mais antiga e verificar credenciais de conteúdo (C2PA), quando existirem |
| Conclusão | Relatar o grau de confiança e as limitações; nenhum detector é conclusivo isoladamente |

**Lição:** a análise de mídia combina técnica, proveniência e contexto, com humildade quanto aos limites.

## 6. Caso 6: base de dados corporativa e escopo excessivo

**Contexto:** a investigação exporta todo o banco de dados de clientes para procurar um registro.

| Etapa | Decisão |
|---|---|
| Problema | Violação do princípio da necessidade e exposição desnecessária de dados pessoais |
| Correção | Definir consultas direcionadas e justificar; registrar as consultas e os resultados |
| Controle | Acesso restrito, DPO consultado e retenção mínima |

**Lição:** coletar tudo "por precaução" cria risco jurídico e de privacidade.

## 7. Erros comuns, consequências e prevenção

| Erro | Consequência provável | Prevenção |
|---|---|---|
| Basear-se apenas em captura de tela | Impugnação bem-sucedida | Extração da fonte, metadados, hash e reforço notarial |
| Imprimir o e-mail sem preservar o original | Perda de metadados e impossibilidade de autenticação | Exportar `.eml` ou `.msg` com cabeçalhos |
| Demora na preservação de conteúdo online | Perda irreversível | Captura imediata e pedido de preservação |
| Obter a evidência sem autorização ou além do escopo | Ilicitude e responsabilização | Autorização formal, DPO e Jurídico |
| Não registrar o contexto (URL, data, conta) | Dificuldade de autenticar | Ficha de Evidência preenchida na hora |
| Apresentar trechos fora de contexto | Perda de credibilidade e acusação de manipulação | Conversa ou documento completo e justificativa de recortes |
| Confiar em uma única fonte | Erros não detectados | Corroboração independente |
| Concluir sobre autoria apenas pelo nome da conta | Conclusão equivocada | Correlacionar dispositivos, sessões e outros dados |
| Omitir achados exculpatórios | Parcialidade e questionamento da perícia | Relatar tudo o que for relevante |
| Linguagem acusatória no relatório | Perda de imparcialidade | Linguagem factual e confiança declarada |
| Não declarar limitações | Conclusões superestimadas | Seção de limitações em todo relatório |
| Descartar evidências sem verificar legal hold | Destruição de prova | Checklist de descarte e consulta ao Jurídico |

## 8. Exercícios práticos

1. Simule a captura técnica de uma página pública (WARC, PDF, imagem, hash e manifesto) e preencha a Ficha de Evidência.
2. Exporte um e-mail de teste com cabeçalhos completos e analise `Received`, SPF e DKIM.
3. Elabore a Matriz de Relevância para o caso 4 e atribua os graus de confiança.
4. Redija o trecho de conclusão do caso 2, separando fato, inferência e limitações.
5. Prepare o roteiro para a ata notarial de um conteúdo web.

## 9. Normas e frameworks relevantes

- ISO/IEC 27037:2012; ISO/IEC 27042:2015
- NIST SP 800-86
- CPC, arts. 369, 384, 411, 422 e 473; CPP, arts. 157 e 158-A a 158-F
- Marco Civil da Internet, arts. 13, 15 e 22; LGPD, arts. 6º e 7º
- C2PA

## 10. Referências

- ABNT NBR ISO/IEC 27037:2013.
- ISO/IEC 27042:2015.
- Brasil. CPC; CPP; Lei nº 12.965/2014; Lei nº 13.709/2018.
- C2PA. Technical Specification.
- Casey, E. Digital Evidence and Computer Crime. 3. ed. 2011.
- Mason, S.; Seng, D. (eds.). Electronic Evidence. 4. ed. 2017.
