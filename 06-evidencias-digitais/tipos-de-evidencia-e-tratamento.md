# Tipos de Evidência Digital e Tratamento

> **Objetivo pedagógico:** saber como identificar, coletar, preservar e apresentar cada tipo comum de evidência digital (documentos, e-mail, mensagens, web, logs, mídia, bancos de dados, nuvem, criptoativos e IoT), conhecendo os riscos de impugnação e as boas práticas de cada tipo.

## 1. Visão geral por tipo

| Tipo | Fonte preferencial | Principais metadados | Risco de impugnação | Cuidado essencial |
|---|---|---|---|---|
| Documentos (Word, PDF, planilhas) | Original no repositório ou no dispositivo | Autor, datas, revisões, propriedades | Alteração de conteúdo e de data | Preservar o arquivo nativo com hash |
| E-mail | Servidor e caixa de correio | Cabeçalhos, rota, identificador da mensagem | Spoofing, edição | Exportar o original com cabeçalhos e validar SPF, DKIM e DMARC |
| Mensagens instantâneas | Banco de dados do aplicativo ou backup | Identificador, remetente, horário | Captura de tela forjada | Extração forense e confirmação por outras fontes |
| Redes sociais e web | Plataforma e captura técnica | URL, data e hora, cabeçalhos | Conteúdo removido ou editado | Captura certificada, WARC, ata notarial |
| Logs de sistema e de rede | Servidores, SIEM, provedores | Horário, origem, usuário | Relógio incorreto, adulteração | Exportação oficial, hash e validação do relógio |
| Imagens, áudio e vídeo | Arquivo nativo e dispositivo | EXIF, codec, geolocalização, histórico de edição | Edição, deepfake | Arquivo original, hash, análise de integridade |
| Bancos de dados e sistemas corporativos | Consulta autorizada e registros de auditoria | Logs de transação, usuário, data | Consulta alterada, dados inconsistentes | Registrar a consulta, o escopo e o horário; exportar com hash |
| Nuvem e SaaS | Exportação oficial e logs de auditoria | Logs de API, identidade, IP | Retenção expirada, jurisdição | Exportar cedo, registrar a requisição e o escopo |
| Criptoativos e blockchain | Registro público do ledger | Hash da transação, endereço, bloco | Atribuição de titularidade | Registrar o hash da transação e o explorador usado |
| IoT e dispositivos embarcados | Dispositivo e serviço de nuvem associado | Logs próprios, relógios internos | Relógio impreciso, formato proprietário | Documentar o firmware e preservar o dispositivo |

## 2. Documentos eletrônicos

| Aspecto | Orientação |
|---|---|
| Coleta | Copiar o arquivo nativo (não apenas a impressão) preservando os metadados |
| Metadados | Extrair propriedades do arquivo e do sistema de arquivos (datas, autor, última modificação) |
| Versões | Verificar histórico de versões, lixeira e cópias de segurança |
| Assinaturas | Validar a assinatura e o certificado; registrar a data de validação |
| Apresentação | Entregar o arquivo nativo, o hash e uma cópia legível |

```bash
# Metadados de documentos (ExifTool)
exiftool -a -G1 -s documento.docx

# Hash do arquivo nativo
sha256sum documento.docx
```

## 3. E-mail

| Aspecto | Orientação |
|---|---|
| Fonte | Preferir o servidor ou o arquivo exportado (`.eml`, `.msg`, PST) a impressões |
| Cabeçalhos | Preservar completos; analisar `Received`, `Message-ID`, `Date`, `Return-Path` |
| Autenticação | Verificar SPF, DKIM e DMARC no cabeçalho `Authentication-Results` |
| Corroboração | Logs do gateway, do servidor e da caixa do destinatário |
| Anexos | Preservar com hash; analisar em ambiente isolado |
| Limitação | Mensagens sem autenticação e com falsificação possível exigem mais corroboração |

```bash
# Verificar a assinatura DKIM de uma mensagem exportada (dkimpy)
dkimverify < mensagem.eml
```

## 4. Mensagens instantâneas e aplicativos

| Aspecto | Orientação |
|---|---|
| Captura de tela | Fragilidade alta; usar apenas como apoio |
| Extração forense | Aquisição do dispositivo ou do backup e análise dos bancos de dados do aplicativo (por exemplo, `msgstore.db` no Android e `ChatStorage.sqlite` no iOS) |
| Exportação de conversa | Pode ser usada como complemento; não preserva todos os metadados |
| Identificação | Registrar número, nome exibido, identificadores e dispositivo |
| Mídias | Preservar os arquivos de mídia e seus metadados |
| Contexto | Apresentar a conversa completa do período, e não apenas trechos |
| Reforço | Ata notarial e confirmação do outro participante, quando possível |

## 5. Web e redes sociais

| Aspecto | Orientação |
|---|---|
| Conteúdo mutável | Capturar o quanto antes: pode ser alterado ou removido |
| Captura técnica | Arquivo WARC, HTML, PDF e imagem, com URL, data e hora (UTC) |
| Identificação do servidor | Registrar IP, certificado e cabeçalhos da resposta |
| Reforço | Ata notarial |
| Perfil e autoria | Registrar identificadores de conta, URL do perfil e dados públicos visíveis |
| Pedido à plataforma | Preservação e fornecimento de registros por vias formais |

Veja o arquivo de preservação de conteúdo web e mensagens.

## 6. Logs, redes e sistemas

| Aspecto | Orientação |
|---|---|
| Origem | Exportação oficial do sistema, e não cópia manual |
| Relógio | Registrar o fuso e a sincronização |
| Filtros | Documentar período, campos e critérios |
| Integridade | Hash e armazenamento imutável |
| Correlação | Mais de uma fonte independente |

## 7. Imagem, áudio e vídeo

| Aspecto | Orientação |
|---|---|
| Arquivo original | Obter do dispositivo ou do serviço, e não de aplicativos que recomprimem |
| Metadados | EXIF, codec, resolução, dispositivo, geolocalização |
| Integridade | Hash e análise de consistência |
| Edição e deepfake | Verificar sinais de edição e proveniência (ver pasta de investigação de deepfakes) |
| Apresentação | Exibir o original com a transcrição ou a descrição, indicando as limitações |

```bash
# Metadados de mídia
exiftool -a -G1 -s foto.jpg
ffprobe -v error -show_format -show_streams video.mp4
```

## 8. Bancos de dados e sistemas corporativos

| Aspecto | Orientação |
|---|---|
| Consulta | Registrar o texto da consulta, o usuário, o horário e o resultado |
| Escopo | Limitar aos dados necessários e aos pedidos |
| Logs de auditoria | Coletar os logs de acesso e de alteração do próprio sistema |
| Exportação | Formato aberto com hash, preservando a estrutura |
| Dados pessoais | Aplicar minimização e controle de acesso |

## 9. Nuvem e SaaS

| Aspecto | Orientação |
|---|---|
| Retenção | Identificar prazos e exportar antes da expiração |
| Exportação | Usar recursos oficiais e contas nominais; registrar o escopo e a requisição |
| Jurisdição | Avaliar a localização dos dados e as regras de acesso |
| Terceiros | Preservar contratos, termos e relatórios de conformidade do provedor |

## 10. Criptoativos e blockchain

| Aspecto | Orientação |
|---|---|
| Registro | Hash da transação, endereços, valor, bloco e horário |
| Ferramentas | Exploradores de blocos e ferramentas de análise, com versão e data de consulta registradas |
| Atribuição | Endereço não prova a identidade do titular; correlacionar com dados de exchanges e de dispositivos |
| Preservação | Capturar a consulta e arquivar os dados em formato aberto com hash |

## 11. IoT e dispositivos embarcados

| Aspecto | Orientação |
|---|---|
| Preservação do dispositivo | Isolar sem desligar quando houver armazenamento volátil relevante |
| Logs | Extrair do dispositivo e do serviço em nuvem associado |
| Relógio | Documentar a fonte de tempo e o desvio |
| Formato | Formatos proprietários exigem registro das ferramentas e das limitações |

## 12. Casos de uso corporativos

- Coleta de e-mails e documentos para ação trabalhista.
- Preservação de conteúdo difamatório em redes sociais para medida judicial.
- Apresentação de logs de acesso a bancos de dados em auditorias.

## 13. Normas e frameworks relevantes

- ISO/IEC 27037:2012 e ISO/IEC 27042:2015
- NIST SP 800-101 Rev. 1 (dispositivos móveis); NIST SP 800-86
- RFC 5322 (formato de mensagens de e-mail), RFC 7208, 6376 e 7489 (SPF, DKIM, DMARC)
- C2PA (proveniência de conteúdo)
- ISO/IEC 27050-1:2019 (e-discovery)

## 14. Referências

- ABNT NBR ISO/IEC 27037:2013.
- Resnick, P. RFC 5322: Internet Message Format. 2008.
- Kitterman, S. RFC 7208 (SPF). 2014.
- Crocker, D. et al. RFC 6376 (DKIM). 2011.
- Kucherawy, M.; Zwicky, E. RFC 7489 (DMARC). 2015.
- Ayers, R. et al. NIST SP 800-101 Rev. 1. 2014.
- Casey, E. Digital Evidence and Computer Crime. 3. ed. 2011.
- Documentação do ExifTool e do FFmpeg (ffprobe).
