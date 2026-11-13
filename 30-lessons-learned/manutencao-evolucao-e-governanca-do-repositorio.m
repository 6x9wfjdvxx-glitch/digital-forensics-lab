# Manutenção, Evolução e Governança do Repositório

> **Objetivo pedagógico:** manter, evoluir e governar o repositório `digital-forensics-lab` como um produto de conhecimento vivo: definir o calendário de revisão, acompanhar as mudanças de normas e de tecnologias, controlar versões e registrar alterações, garantir a qualidade (revisão, verificação de links e de diagramas), estabelecer políticas do projeto (licença, contribuição, segurança e aviso legal), usar recursos do GitHub para automatizar verificações e apresentar o repositório como portfólio profissional de forma responsável.

## 1. Princípios de manutenção

| Princípio | Aplicação |
|---|---|
| Conteúdo vivo | Normas, ferramentas e ameaças mudam; o repositório precisa de revisão periódica |
| Rastreabilidade | Toda alteração com mensagem de commit clara e, para mudanças relevantes, registro no histórico de versões |
| Qualidade antes de volume | É melhor revisar e corrigir do que acrescentar arquivos sem revisão |
| Segurança e legalidade | Sem dados reais, sem segredos, sem material ilícito e sem instruções operacionais de ataque |
| Transparência sobre limitações | Avisos de que o material é educacional e de que normas e comandos devem ser confirmados nas versões vigentes |
| Consistência | Mesma estrutura, mesma nomenclatura e mesmo estilo em todas as pastas |

## 2. Calendário de revisão

| Frequência | Atividade |
|---|---|
| A cada alteração | Conferir a renderização dos diagramas, os links relativos e a ortografia |
| Trimestral | Verificar links externos; revisar comandos e ferramentas mais sensíveis a versões (pasta 29); revisar números de versões de normas e de matrizes |
| Semestral | Revisar as pastas de maior volatilidade (nuvem, Microsoft 365, IA, prompts, LLM e deepfakes); atualizar os casos públicos |
| Anual | Revisão geral de conteúdo, de estrutura e de lições; atualizar o modelo de maturidade; balanço do que foi usado e do que não foi |
| Após eventos relevantes | Novas versões de normas, mudanças legais, incidentes públicos significativos ou novas técnicas de ataque (ATT&CK e ATLAS) |

## 3. Acompanhamento de normas e de tecnologias (lista de vigilância)

| Item | O que acompanhar | Pastas mais afetadas |
|---|---|---|
| NIST SP 800-61, 800-86, 800-88, 800-84 | Novas revisões | 01, 03, 22, 23, 29, 30 |
| ISO/IEC 27035, 27037, 27041 a 27043, 27001, 27002 | Novas edições e emendas | Todas |
| ISO 21043 e ABNT NBR ISO/IEC 17025 | Atualizações | 22, 29 |
| MITRE ATT&CK e ATLAS | Novas versões, técnicas e estudos de caso | 15 a 20, 24 a 28 |
| OWASP Top 10 para LLM e IA agêntica | Novas edições | 25 e 26 |
| NIST AI RMF, AI 600-1, AI 100-2 e AI 100-4 | Revisões e novos perfis | 24 a 27 |
| LGPD e regulamentos da ANPD | Novas resoluções e guias | 01, 06, 16, 22, 24 a 27 |
| Marco legal da IA no Brasil e AI Act da UE | Tramitação, cronogramas e regulamentos | 24 a 27 |
| Legislação penal e processual (incluindo crimes cibernéticos e conteúdo sintético) | Alterações | 06, 22, 27 |
| Serviços de nuvem e Microsoft 365 | Mudanças de logs, retenção e licenciamento | 17 a 19 |
| Ferramentas forenses | Novas versões e mudanças de licença | 29 |
| Jurisprudência relevante (por exemplo, responsabilidade de plataformas) | Decisões novas | 27 |

## 4. Controle de versões e histórico

| Prática | Descrição |
|---|---|
| Mensagens de commit | Verbo no infinitivo e descrição objetiva (por exemplo, "Corrigir numeração de seções na pasta 26") |
| Arquivo de histórico de alterações (`CHANGELOG.md`) na raiz | Registro por data das mudanças relevantes |
| Versões (releases) | Marcos como "v1.0" (30 pastas completas), "v1.1" (revisão trimestral) e assim por diante |
| Data de revisão nos arquivos sensíveis | Linha "Última revisão: AAAA-MM-DD" nos arquivos de normas e de ferramentas |
| Pull requests (se houver colaboradores) | Revisão antes da integração |

Modelo de `CHANGELOG.md`:

```
# Histórico de Alterações

## [v1.0] - AAAA-MM-DD
- Conclusão das 30 pastas do repositório.

## [v1.1] - AAAA-MM-DD
- Revisão trimestral: atualização de links, de normas e de comandos das pastas 17 a 19 e 29.
- Correção de numeração de seções na pasta 26.
```

## 5. Garantia de qualidade

| Verificação | Como fazer |
|---|---|
| Renderização dos diagramas Mermaid | Abrir os arquivos no GitHub e conferir os diagramas |
| Links relativos entre arquivos e entre pastas | Clicar nos links dos índices (README de cada pasta) |
| Links externos | Verificação periódica (manual ou automática) |
| Estrutura padronizada | Cada pasta com 8 arquivos de conteúdo e 1 README, com os mesmos blocos (objetivo, casos de uso, normas e referências) |
| Ortografia e estilo | Revisão de texto; uso consistente de termos |
| Segurança do conteúdo | Sem credenciais, tokens ou dados pessoais reais; IPs e domínios de exemplo em faixas reservadas |
| Exatidão técnica | Testar comandos em ambiente de laboratório; registrar versões |
| Exatidão normativa | Conferir artigos e versões das normas antes de citar |
| Revisão por pares | Quando possível, pedir a outro profissional que revise trechos críticos |

Checklist rápido para novos conteúdos:

- [ ] Objetivo pedagógico claro e conteúdo coerente com a pasta
- [ ] Avisos legais e de limitação, quando sensível
- [ ] Sem dados reais, segredos ou conteúdo ilícito
- [ ] Comandos testados em laboratório ou marcados como exemplos a validar
- [ ] Normas e referências conferidas, com versão e data
- [ ] Diagramas renderizam; links funcionam
- [ ] Índice (README da pasta) atualizado

## 6. Políticas do projeto (arquivos na raiz do repositório)

| Arquivo | Finalidade | Observações |
|---|---|---|
| `README.md` (raiz) | Apresenta o repositório, o público, a estrutura das 30 pastas e como usar | Veja o modelo opcional ao final desta resposta |
| `LICENSE` | Define como o conteúdo pode ser usado | Escolha uma licença adequada (por exemplo, uma licença Creative Commons para o texto e uma licença permissiva para códigos); o GitHub oferece modelos ao criar o arquivo |
| `CONTRIBUTING.md` | Regras para contribuições | Estilo, estrutura, revisão e o que não é aceito (dados reais e conteúdo ofensivo) |
| `CODE_OF_CONDUCT.md` | Conduta esperada | Modelo oferecido pelo GitHub |
| `SECURITY.md` | Como reportar problemas de segurança ou conteúdo sensível | Canal de contato |
| `CHANGELOG.md` | Histórico de alterações | Seção 4 |
| `CITATION.cff` | Como citar o repositório | Opcional |
| Aviso legal | Material educacional; não substitui parecer jurídico; confirmar normas e comandos | Na raiz e nas pastas sensíveis |

## 7. Recursos do GitHub úteis

| Recurso | Uso |
|---|---|
| Releases | Marcar versões do repositório |
| Issues | Registrar correções, ideias e pendências (por exemplo, "atualizar normas da pasta 24") |
| Projects | Quadro de acompanhamento das revisões |
| Discussions | Espaço para dúvidas e sugestões, se desejado |
| Actions | Automação de verificações (modelo abaixo) |
| Branch protection e revisão | Proteção da branch principal quando houver colaboradores |
| Dependabot e varredura de segredos | Alertas de segurança para o repositório |

### Modelo opcional de automação (GitHub Actions): verificação de Markdown e de links

Crie o arquivo `.github/workflows/qualidade.yml` na raiz do repositório. **Exceção à regra do nome de arquivo:** aqui você deve digitar o caminho completo com barras no campo do nome, a partir da raiz do repositório, para que o GitHub crie as pastas `.github/workflows`. Ajuste as versões das ações conforme a documentação atual.

```yaml
name: Qualidade da documentação

on:
  pull_request:
  push:
    branches: [main]
  schedule:
    - cron: "0 6 1 * *"   # primeiro dia de cada mês, às 06:00 UTC

jobs:
  verificar:
    runs-on: ubuntu-latest
    steps:
      - name: Obter o código
        uses: actions/checkout@v4

      - name: Verificar estilo do Markdown
        uses: DavidAnson/markdownlint-cli2-action@v16
        with:
          globs: "**/*.md"
        continue-on-error: true

      - name: Verificar links
        uses: lycheeverse/lychee-action@v1
        with:
          args: --no-progress --accept 200,204,403,429 "**/*.md"
          fail: false
```

Esses testes não validam a renderização dos diagramas Mermaid; continue conferindo-os visualmente no GitHub.

## 8. Evolução do conteúdo: ideias de próximas etapas

| Tema | Possível extensão |
|---|---|
| Novas plataformas | Forense de Google Workspace, de ambientes SaaS adicionais e de contêineres e serverless em profundidade |
| Tecnologia operacional (OT) e IoT | Forense em sistemas industriais e dispositivos conectados |
| Criptomoedas e rastreamento | Análise de transações e investigações financeiras |
| Automação e engenharia de detecção | Pipeline de detecção como código, com testes |
| Exercícios | Biblioteca ampliada de cenários de mesa e de laboratório, com conjuntos de dados sintéticos |
| Tradução | Versões em outros idiomas |
| Casos | Novos casos fictícios e análises de incidentes públicos recentes |
| Integração com playbooks | Exportar os playbooks (pasta 23) em formatos executáveis ou em SOAR |
| Revisão por especialistas | Convidar peritos, advogados e DPO para revisar capítulos |

## 9. Uso do repositório como portfólio profissional

| Aspecto | Orientação |
|---|---|
| Objetivo | Demonstrar conhecimento técnico, rigor metodológico, comunicação e atenção a aspectos legais e éticos |
| Como apresentar | Descrição clara na raiz, com o público, a estrutura, as pastas de maior destaque e as limitações |
| Destacar entregáveis | Modelos de relatório, matrizes, playbooks, casos e exercícios que você mesmo(a) elaborou |
| Honestidade | Informe que o material é educacional, que casos são fictícios e o que foi validado em laboratório |
| Evidências de uso | Exemplos de exercícios de mesa realizados, de relatórios produzidos e de análises reproduzidas |
| Cuidado com a confidencialidade | Não inclua informações de empregadores ou de clientes; nenhum dado real |
| Atualização | Datas de revisão e histórico de versões mostram manutenção ativa |
| Complementos | Certificações, participação em comunidades e contribuições abertas (por exemplo, regras de detecção) |

## 10. Ciclo de manutenção

```mermaid
flowchart TD
    A["Vigilância: normas, ferramentas, ameaças e legislação"] --> B["Registrar itens a revisar (Issues)"]
    B --> C["Revisar e atualizar o conteúdo, testando comandos em laboratório"]
    C --> D["Conferir diagramas, links, estrutura e segurança do conteúdo"]
    D --> E["Atualizar o histórico de alterações e criar a versão"]
    E --> F["Divulgar e coletar feedback"]
    F --> A
```

## 11. Exemplo prático: revisão trimestral

| Passo | Resultado |
|---|---|
| 1 | Abrir uma Issue "Revisão trimestral AAAA-T1" com a lista de vigilância |
| 2 | Executar a verificação automática de links; corrigir 6 links quebrados |
| 3 | Revisar a pasta 19 (mudanças de licenciamento e de retenção de auditoria) e a pasta 29 (versões de ferramentas) |
| 4 | Atualizar a referência de uma norma que teve nova revisão |
| 5 | Registrar no `CHANGELOG.md` e criar a versão "v1.1" |
| 6 | Fechar a Issue com o resumo das mudanças |

## 12. Casos de uso corporativos

- Gestão de repositórios internos de conhecimento de segurança (políticas, playbooks e lições).
- Modelo para manter bases de conhecimento de DFIR atualizadas e auditáveis.
- Governança de documentação em programas de capacitação.

## 13. Normas e frameworks relevantes

- ISO/IEC 27001:2022 (informação documentada, cláusula 7.5); ISO 9001 (gestão de documentos, como referência de boas práticas)
- NIST SP 800-61 Rev. 3; NIST CSF 2.0 (ID.IM)
- Boas práticas de documentação como código; Semantic Versioning (como referência de versionamento)
- LGPD, arts. 6º, 46 e 50

## 14. Referências

- GitHub Docs: Licensing a repository, Adding a security policy, GitHub Actions.
- Creative Commons. Escolha de licenças.
- Keep a Changelog (keepachangelog.com) e Semantic Versioning (semver.org).
- Pastas 22, 23, 29 e 30 deste repositório.
