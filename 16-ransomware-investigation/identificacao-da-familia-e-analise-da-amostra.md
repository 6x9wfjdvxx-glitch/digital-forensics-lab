# Identificação da Família e Análise da Amostra

> **Objetivo pedagógico:** identificar a família ou a variante de ransomware a partir de notas de resgate, extensões e marcadores de arquivos, avaliar a existência de decifradores e de outras vias de recuperação, extrair da amostra e dos artefatos o comportamento (serviços, cópias de sombra, alvos e rede) e reconhecer as variantes para Linux e ESXi.

## 1. Por que identificar a família

| Benefício | Descrição |
|---|---|
| Decifradores | Algumas famílias têm decifradores gratuitos ou falhas conhecidas |
| Comportamento esperado | Técnicas, ferramentas e tempo típicos dos afiliados |
| Verificação de exfiltração | Muitas famílias praticam extorsão dupla |
| Inteligência | Indicadores, relatórios públicos e orientações |
| Decisões | Subsidia a avaliação de risco de pagamento e de recuperação |

A identificação é uma hipótese: variantes e *rebrandings* são comuns; valide pelo comportamento no seu ambiente.

## 2. Elementos de identificação

| Elemento | O que observar |
|---|---|
| Nota de resgate | Nome do arquivo, texto, formas de contato (site Tor, e-mail e mensageria), identificador único da vítima, ameaça de publicação |
| Extensão dos arquivos criptografados | Extensão acrescentada ou substituída, que pode incluir o identificador da vítima |
| Marcadores em arquivos | Cabeçalho ou rodapé acrescentado ao arquivo criptografado, com informações da chave |
| Nome e caminho do executável | Nomes e diretórios típicos de implantação |
| Fundo de tela e mensagens | Alterações visuais |
| Comandos executados | Lista de serviços interrompidos, exclusão de cópias de sombra e argumentos |
| Infraestrutura | Domínios, IPs e sites de pagamento e de vazamento |
| Ferramentas pré-criptografia | Frameworks de pós-exploração e ferramentas de exfiltração utilizadas |

### 2.1 Serviços de identificação e de decifradores

| Recurso | Uso |
|---|---|
| ID Ransomware | Identificação por nota de resgate e arquivo criptografado de exemplo |
| No More Ransom | Repositório de decifradores gratuitos e orientações |
| Relatórios de fornecedores de segurança e de CSIRTs | Análises e indicadores |
| Pesquisadores e comunidades | Análises técnicas de falhas de criptografia |

Cuidado com a privacidade: ao enviar amostras a serviços públicos, use somente a nota de resgate e um arquivo criptografado **sem dados sensíveis** (por exemplo, um arquivo de teste); jamais envie documentos reais da organização.

## 3. Comportamentos típicos do binário

| Comportamento | Indício observável | ATT&CK |
|---|---|---|
| Interromper serviços de bancos de dados, de backup, de antivírus e de aplicações | Comandos de parada de serviços; eventos de serviço | T1489 |
| Excluir cópias de sombra e catálogos de backup | Linhas de comando como `vssadmin delete shadows /all /quiet`, `wmic shadowcopy delete` e `wbadmin delete catalog` | T1490 |
| Desabilitar a recuperação do Windows | `bcdedit` com `recoveryenabled no` e `bootstatuspolicy ignoreallfailures` | T1490 |
| Encerrar processos que mantêm arquivos abertos | Terminação de processos de aplicações e de bancos de dados | T1489 |
| Limpar logs | `wevtutil cl` e eventos 1102 e 104 | T1070.001 |
| Selecionar arquivos por extensão e evitar diretórios do sistema | Lista de extensões e de exclusões na amostra | T1486 |
| Criptografar compartilhamentos de rede e unidades mapeadas | Grande volume de gravações e de renomeações por SMB | T1486 |
| Criptografia intermitente ou parcial | Apenas partes de cada arquivo criptografadas, para acelerar | T1486 |
| Reinício em modo de segurança | Alteração de configuração de inicialização | T1562.009 |
| Criação de nota em cada diretório | Milhares de arquivos de nota | T1491 |

Esses padrões são úteis para **detecção** e para a linha do tempo: procure-os em logs de EDR, no Sysmon (evento 1) e no EVTX 4688.

## 4. Esquema de criptografia e viabilidade de recuperação

| Característica | Implicação |
|---|---|
| Criptografia híbrida (chave simétrica por arquivo, protegida por chave pública do atacante) | Sem a chave privada, a decifragem por força bruta é inviável |
| Geração fraca de chaves ou falhas de implementação | Em alguns casos, pesquisadores desenvolveram decifradores; não conte com isso |
| Chave ou segredos em memória no momento da criptografia | Em casos raros, a memória capturada permite recuperar material de chave (ver pasta 09) |
| Criptografia intermitente | Pode permitir a recuperação parcial de alguns tipos de arquivos (por exemplo, bancos ou arquivos grandes), com ferramentas especializadas |
| Arquivos originais excluídos após a criação da cópia criptografada | Possível recuperação de dados remanescentes de espaço não alocado, com limitações (ver pasta 10; discos SSD com TRIM reduzem as chances) |
| Criptografia no local (sobrescrita) | Sem dados originais remanescentes |

Não tente decifrar ou "reparar" os arquivos originais; trabalhe sempre em **cópias** e preserve os arquivos criptografados e as notas.

## 5. Outras vias de recuperação (sem pagamento)

| Via | Observação |
|---|---|
| Backups íntegros e fora do alcance do atacante | Via principal; verifique a integridade e a ausência de persistência (ver arquivo de recuperação) |
| Cópias de sombra do Windows | Frequentemente excluídas; verifique se sobreviveram |
| Versões e lixeiras de serviços em nuvem (por exemplo, OneDrive e SharePoint) | Restauração de versões anteriores e recursos de recuperação de arquivos, conforme a retenção |
| Instantâneos de hipervisor e de armazenamento | Dependem de terem sido preservados e não terem sido alcançados |
| Sistemas de arquivos com instantâneos imutáveis | Restauração a partir de pontos anteriores |
| Réplicas e ambientes de recuperação de desastres | Se estiverem isolados |
| Cópias em dispositivos offline, e-mails e dispositivos móveis | Recuperação parcial de dados |
| Decifradores públicos | Quando existirem para a família e a variante identificadas |
| Reconstrução de dados a partir de sistemas de origem | Reprocessamento e reconstrução manual |

## 6. Variantes para Linux e ESXi

| Aspecto | Observação |
|---|---|
| Alvo | Servidores Linux e hipervisores VMware ESXi, com criptografia de arquivos de máquinas virtuais (por exemplo, discos virtuais e arquivos de configuração) |
| Comportamento | Listar e interromper máquinas virtuais em execução para liberar os arquivos, e depois criptografá-los |
| Acesso | SSH habilitado, credenciais de administrador do ESXi ou do vCenter comprometidas |
| Evidências | Logs do ESXi (`hostd.log`, `vmkernel.log`, `shell.log`, `auth.log`), eventos de SSH habilitado, histórico de comandos e processos |
| Recuperação | Backups das VMs; em alguns casos, reconstrução dos arquivos de configuração das VMs; decifradores quando existirem |
| Prevenção | Desabilitar SSH quando não necessário, segmentar a rede de gestão, MFA no vCenter, atualização e *lockdown mode* |

```bash
# ESXi: indícios de uso do shell e do SSH nos logs (execução com autorização)
grep -i "ssh" /var/log/auth.log | tail -50
grep -i "esxcli vm process" /var/log/shell.log | tail -50
```

## 7. Análise da amostra: o que extrair

Aplique os procedimentos da pasta 15 (laboratório isolado, análise estática, dinâmica e de memória). Objetivos específicos:

| Objetivo | Como |
|---|---|
| Identificar a lista de alvos (extensões e diretórios) e as exclusões | Strings, configuração e comportamento |
| Identificar argumentos de linha de comando | Análise estática e histórico de execução |
| Obter a configuração incorporada (nota, chave pública, lista de serviços) | Memória e análise de código |
| Mapear o comportamento de rede e de propagação | Captura de rede no laboratório |
| Verificar se há tentativa de exfiltração pelo próprio binário | Rede e comportamento |
| Extrair indicadores (hashes, mutexes, nome de serviços e arquivos) | Estática e dinâmica |
| Verificar se o comportamento depende de parâmetros do ambiente (domínio e idioma) | Teste controlado |

Nunca execute a amostra fora do laboratório isolado.

## 8. Exemplo prático: identificação e viabilidade de recuperação

| Etapa | Resultado |
|---|---|
| Nota | `README_RESTORE.txt` com identificador de 32 caracteres e site Tor |
| Extensão | `.locked7f3a` (aleatória por vítima) |
| Serviço público de identificação | Candidatos de duas famílias; nenhum decifrador disponível |
| Binário (laboratório) | Executa `vssadmin delete shadows`, interrompe serviços de banco de dados e de backup e criptografa compartilhamentos de rede |
| Criptografia | Híbrida, com criptografia intermitente em arquivos acima de 1 MB |
| Memória | Sem material de chave recuperável |
| Via de recuperação | Backups imutáveis do dia anterior; cópias de sombra excluídas |
| Conclusão | Família não determinada com certeza; sem decifrador; recuperação por backups |

## 9. Casos de uso corporativos

- Determinação rápida de opções de recuperação sem pagamento.
- Alimentação da caça com os comportamentos e indicadores da amostra.
- Subsídio técnico às decisões da direção sobre a estratégia de resposta.

## 10. Normas e frameworks relevantes

- MITRE ATT&CK: T1486, T1489, T1490, T1491, T1070.001, T1562
- NIST IR 8374; NIST SP 800-61 Rev. 3; NIST SP 800-83 Rev. 1
- CISA #StopRansomware Guide; No More Ransom
- CIS Controls v8.1, controles 10, 11 e 17

## 11. Referências

- No More Ransom Project. Decifradores e orientações. https://www.nomoreransom.org
- ID Ransomware (MalwareHunterTeam). Serviço de identificação.
- Sikorski, M.; Honig, A. Practical Malware Analysis. 2012.
- Relatórios públicos de fornecedores sobre famílias de ransomware.
- VMware. Documentação de segurança e de logs do ESXi.
- The DFIR Report. Relatórios de intrusões com ransomware.
