# Evidências, Anexos, Hashes e Reprodutibilidade

> **Objetivo pedagógico:** documentar as evidências, os hashes, os comandos e os anexos de modo que o relatório seja verificável e reproduzível por terceiros, aplicar a minimização e a redação segura de dados pessoais, garantir a integridade do próprio relatório (hash, assinatura e carimbo do tempo) e organizar a entrega e o arquivamento com segurança.

## 1. O que torna um relatório verificável

| Requisito | Como atender |
|---|---|
| Identificação inequívoca das evidências | Identificadores, descrição, origem e hash de cada item |
| Método descrito | Ferramentas, versões, parâmetros e comandos |
| Resultados rastreáveis | Cada achado remete à fonte (arquivo, registro, offset ou linha de log) |
| Dados e consultas disponíveis | Anexos com consultas, scripts e saídas, ou instruções para obtê-los |
| Cadeia de custódia | Formulários e registros que cobrem todo o percurso |
| Integridade do próprio relatório | Hash, assinatura e carimbo de tempo do documento final |
| Possibilidade de contestação | Informações suficientes para que outro perito refaça o exame |

## 2. Organização dos anexos

| Anexo | Conteúdo |
|---|---|
| A: Cadeia de custódia | Formulários de recebimento, transferência, armazenamento e devolução (pasta 02) |
| B: Lista de evidências e hashes | Tabela com identificador, descrição, origem, hash SHA-256 (e outros) e data |
| C: Procedimentos e comandos | Comandos, consultas e scripts utilizados, com as versões das ferramentas |
| D: Saídas e dados de suporte | Exportações (CSV e JSON) dos resultados relevantes, com hash |
| E: Linha do tempo | Linha do tempo completa, com fontes e confiança (pasta 05) |
| F: Capturas de tela e figuras | Imagens ilustrativas, com a referência aos arquivos originais |
| G: Validação de ferramentas | Evidências de validação e de testes |
| H: Currículo e qualificações | Do autor |
| I: Glossário e referências | Termos e fontes citadas |

Cada anexo deve ser citado no corpo do relatório, e cada figura deve ter legenda e fonte.

## 3. Tabela de evidências e hashes (modelo)

| ID | Descrição | Origem | Data e hora de recebimento (UTC) | Tamanho | SHA-256 | Observações |
|---|---|---|---|---|---|---|
| I-01 | Notebook, série X | Sala 4, empresa Y | 2026-10-03 13:20 | n/a | n/a | Lacre nº 000412 íntegro |
| I-02 | Imagem forense do disco do I-01 (arquivo .E01) | Aquisição em 2026-10-03 | 2026-10-03 15:00 | 238 GB | `a1b2...c3d4` | Verificação concluída sem divergências |
| I-03 | Exportação de logs do servidor Z (período 2026-09 a 2026-10) | SIEM da empresa | 2026-10-04 10:15 | 1,2 GB | `e5f6...a7b8` | Exportado com conta nominal |

```bash
# Gerar a tabela de hashes de uma pasta de evidências (para o Anexo B)
find /mnt/evidencias/DFL-2026-001 -type f -print0 | sort -z | xargs -0 sha256sum > anexoB_hashes.sha256
wc -l anexoB_hashes.sha256

# Conferir a integridade depois (qualquer pessoa pode repetir)
sha256sum -c anexoB_hashes.sha256
```

## 4. Registro de comandos e de ambiente

| Informação | Exemplo |
|---|---|
| Ferramenta e versão | `Plaso 20240308`, `Autopsy 4.21`, `Hayabusa 2.x` |
| Sistema e ambiente | Estação de análise, sistema operacional e versão |
| Comando completo | Com todos os parâmetros e caminhos |
| Data e hora (UTC) e analista | Quando e quem executou |
| Saída e hash | Arquivo de resultado com hash |
| Erros e avisos | O que foi emitido e como foi tratado |

```bash
# Capturar o histórico do terminal e o ambiente de uma sessão de análise (para o Anexo C)
script -q -f /mnt/analise/DFL-2026-001_sessao_$(date -u +%Y%m%dT%H%M%SZ).log
# ... executar os comandos de análise ...
exit
uname -a > /mnt/analise/ambiente.txt; date -u >> /mnt/analise/ambiente.txt
sha256sum /mnt/analise/DFL-2026-001_sessao_*.log /mnt/analise/ambiente.txt > /mnt/analise/hashes_sessao.sha256
```

Arquivos de sessão podem conter dados sensíveis: trate-os como evidências e proteja o acesso.

## 5. Reprodutibilidade

| Prática | Descrição |
|---|---|
| Descrever o ponto de partida | Estado dos materiais e hashes antes do exame |
| Descrever cada transformação | Entrada, ferramenta, parâmetros e saída |
| Usar ferramentas versionadas | Versões exatas; arquivar os instaladores, quando possível |
| Determinismo | Preferir procedimentos que produzam o mesmo resultado quando repetidos |
| Registro de decisões analíticas | Por que um filtro foi aplicado e por que uma hipótese foi descartada |
| Teste de reprodução interno | Um colega repete os passos principais e confere os resultados antes da emissão |
| Preservação dos dados de trabalho | Cópias de trabalho e saídas guardadas com hash por prazo definido |
| Limites da reprodução | Declarar o que não pode ser reproduzido (por exemplo, dados em nuvem alterados com o tempo) |

## 6. Minimização e redação segura de dados pessoais e sigilosos

| Tema | Orientação |
|---|---|
| Princípio | Incluir apenas os dados necessários à finalidade do relatório (LGPD, arts. 6º, I a III) |
| Camadas de detalhe | Versão completa restrita (com dados identificados) e versão reduzida (com dados pseudonimizados) para outros públicos |
| Pseudonimização | Substituir nomes e identificadores por códigos (por exemplo, "Usuário A"), mantendo a tabela de correspondência em local protegido |
| Dados sensíveis e de terceiros | Excluir ou resumir; evitar transcrever conteúdo íntimo ou privilegiado |
| Comunicações privilegiadas | Retirar do relatório e tratar conforme orientação do Jurídico |
| Redação segura de PDF | A tarja preta desenhada sobre o texto não remove o conteúdo: use ferramentas de **redação verdadeira**, que removem o texto e os metadados, e conferir o resultado |
| Metadados do documento | Remover informações do autor, do software e do histórico, quando adequado |

```bash
# Verificar se o texto "redigido" ainda é extraível do PDF final (teste de vazamento)
pdftotext relatorio_final.pdf - | grep -n -i -E "cpf|123\.456|nome-sigiloso" || echo "Nenhuma ocorrência encontrada"

# Inspecionar os metadados do PDF antes de distribuir
exiftool relatorio_final.pdf
```

## 7. Integridade do relatório: hash, assinatura e carimbo do tempo

| Medida | Descrição |
|---|---|
| Hash do relatório | SHA-256 do arquivo final, registrado no termo de entrega e, quando possível, em canal independente |
| Assinatura eletrônica qualificada | Certificado ICP-Brasil, com validade jurídica (MP nº 2.200-2/2001 e Lei nº 14.063/2020) |
| Carimbo do tempo | Prova do momento de existência do documento; no Brasil, serviços de Autoridade de Carimbo do Tempo (ACT) da ICP-Brasil; internacionalmente, o padrão RFC 3161 |
| Formato de arquivamento | Formatos estáveis e autocontidos (por exemplo, PDF/A) para preservação de longo prazo |
| Controle de versões | Cada versão com identificador e hash; a versão entregue é a versão de referência |
| Canal de entrega | Transmissão criptografada e confirmação de recebimento |

```bash
# Hash do relatório final e assinatura destacada da lista de hashes (GPG)
sha256sum relatorio_final.pdf > relatorio_final.pdf.sha256
gpg --armor --detach-sign relatorio_final.pdf.sha256

# Carimbo de tempo RFC 3161: gerar a requisição e enviá-la a uma Autoridade de Carimbo do Tempo (a URL é um exemplo)
openssl ts -query -data relatorio_final.pdf -sha256 -cert -no_nonce -out relatorio_final.tsq
curl -s -H "Content-Type: application/timestamp-query" --data-binary @relatorio_final.tsq https://tsa.exemplo.org/tsr -o relatorio_final.tsr
openssl ts -reply -in relatorio_final.tsr -text | head -n 20
```

Para validade no Brasil, avalie os serviços de ACT credenciados à ICP-Brasil e a assinatura qualificada; a escolha depende do uso (judicial, administrativo ou privado).

## 8. Entrega, guarda e retenção

| Aspecto | Prática |
|---|---|
| Termo de entrega | Identifica o documento, a versão, o hash, o destinatário, a data e o meio |
| Controle de acesso | Entrega apenas a destinatários autorizados; registro de quem recebeu |
| Segurança | Criptografia em trânsito e em repouso; senha enviada por canal distinto, quando aplicável |
| Arquivamento | Relatório e anexos arquivados com hash, em repositório imutável, pelo prazo legal e de política |
| Retenção de evidências e dados de trabalho | Prazos definidos; descarte seguro e registrado (pasta 02) |
| Atualizações | Complementos e retificações como novas versões, com histórico e justificativa |
| Retirada de dados pessoais | Quando o prazo expira, avaliar o descarte do que não for mais necessário (LGPD, arts. 15 e 16) |

## 9. Exemplo prático: pacote de entrega de um laudo

| Item | Conteúdo |
|---|---|
| `Laudo_DFL-2026-001_v1.0.pdf` | Laudo assinado com certificado ICP-Brasil e carimbo do tempo |
| `Laudo_DFL-2026-001_v1.0.pdf.sha256` | Hash do laudo |
| `Anexos_A-I.zip` (criptografado) | Cadeia de custódia, hashes, comandos, saídas, linha do tempo, figuras, validação e currículo |
| `Anexos_A-I.zip.sha256` | Hash do pacote de anexos |
| `Termo_de_entrega.pdf` | Identifica os arquivos, os hashes, o meio de entrega e o destinatário |
| Verificação | O destinatário executa `sha256sum -c` para conferir os arquivos |
| Guarda | Cópia no repositório imutável do laboratório, com registro de acesso |

## 10. Casos de uso corporativos

- Preparação de pacotes de laudos e de relatórios com anexos verificáveis.
- Revisão de qualidade que confere hashes, referências cruzadas e reprodutibilidade.
- Política de redação segura e de pseudonimização para relatórios com dados pessoais.

## 11. Normas e frameworks relevantes

- ISO/IEC 27037:2012; ISO/IEC 27041:2015; ISO/IEC 27042:2015; ISO/IEC 17025
- NIST SP 800-86; NIST IR 8387; NIST CFTT
- RFC 3161 (carimbo do tempo); ISO 19005 (PDF/A); MP nº 2.200-2/2001 e Lei nº 14.063/2020
- CPP, arts. 158-A a 158-F; LGPD, arts. 6º, 15, 16 e 46

## 12. Referências

- Adams, C. et al. RFC 3161: Time-Stamp Protocol (TSP). 2001.
- ITI (Instituto Nacional de Tecnologia da Informação). ICP-Brasil: documentos e autoridades de carimbo do tempo.
- NIST. Computer Forensics Tool Testing Program.
- ISO 19005. Document management: Electronic document file format for long-term preservation (PDF/A).
- Casey, E. Digital Evidence and Computer Crime. 3. ed. 2011.
