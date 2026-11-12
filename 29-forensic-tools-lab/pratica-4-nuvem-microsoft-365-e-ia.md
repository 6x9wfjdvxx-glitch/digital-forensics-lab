# Prática 4: Nuvem, Microsoft 365 e IA

> **Objetivo pedagógico:** praticar a investigação em ambientes de nuvem, de Microsoft 365 e de IA, **em contas e ambientes de laboratório próprios**: gerar eventos benignos em uma conta de nuvem e reconstruí-los pelos logs de auditoria; consultar logs com KQL; praticar a auditoria do Microsoft 365 em um locatário de testes; e montar um laboratório de IA local (registro de interações com um modelo local, integridade de modelos e versionamento de dados).

> **Segurança e custos:** use **somente contas de laboratório** criadas para este fim, com orçamentos e alertas de custo configurados. Não execute técnicas de teste contra contas de terceiros nem de produção. Remova os recursos ao final.

## 1. Preparação

| Item | Descrição |
|---|---|
| Conta de nuvem de laboratório | Conta de teste (por exemplo, do nível gratuito do provedor), com MFA, orçamento e alerta de custo, e sem dados reais |
| Auditoria | Trilha de eventos habilitada na conta (pastas 17 e 18) |
| Locatário de Microsoft 365 de testes | Locatário de desenvolvimento ou de avaliação, com auditoria habilitada (a disponibilidade de programas de locatários de teste varia: confirme com a Microsoft) |
| Caso | `DFL-LAB-004` |

## 2. Nuvem: gerar eventos benignos e reconstruí-los

```bash
# Na conta de LABORATÓRIO (AWS como exemplo): ações benignas de gerenciamento
aws sts get-caller-identity
aws iam create-user --user-name usuario-lab-dfl
aws s3api create-bucket --bucket dfl-lab-$(date -u +%Y%m%d)-$RANDOM --region us-east-1
aws s3api list-buckets
aws iam delete-user --user-name usuario-lab-dfl
```

Aguarde alguns minutos (os eventos podem demorar para aparecer no histórico).

```bash
# Consultar o histórico de eventos por nome de evento
aws cloudtrail lookup-events --lookup-attributes AttributeKey=EventName,AttributeValue=CreateUser --max-results 5 --output json > createuser.json
jq -r '.Events[] | [.EventTime, .EventName, (.CloudTrailEvent|fromjson|.sourceIPAddress), (.CloudTrailEvent|fromjson|.userIdentity.arn)] | @tsv' createuser.json
```

**Exercícios:** (1) identifique quem criou o usuário, de onde e quando; (2) compare o histórico de 90 dias com a trilha entregue ao armazenamento; (3) verifique se há eventos de dados do armazenamento (leitura de objetos) e explique o motivo de sua ausência (pasta 17 e caso 4); (4) escreva a linha do tempo da sessão em UTC.

Para a nuvem do seu fornecedor, repita com os equivalentes (log de atividade do Azure e Cloud Audit Logs do Google Cloud).

## 3. Consultas em KQL

Use um espaço de trabalho do Log Analytics de teste com dados de exemplo (o ambiente de demonstração do Log Analytics, oferecido pela Microsoft, ou um espaço de trabalho seu), para praticar a linguagem:

```kusto
// Exemplo de estrutura de consulta (ajuste ao esquema disponível)
SigninLogs
| where TimeGenerated > ago(7d)
| summarize Entradas = count(), IPs = dcount(IPAddress) by UserPrincipalName
| top 10 by Entradas desc
```

| Exercício | Descrição |
|---|---|
| 1 | Liste as autenticações por país e por aplicativo; identifique viagens impossíveis simuladas |
| 2 | Escreva uma consulta para criação de regras de caixa e consentimentos a aplicativos (pasta 19) |
| 3 | Escreva uma consulta de linha de base e outra de desvio para volume de logins |

## 4. Microsoft 365: auditoria em um locatário de testes

```powershell
# No locatário de TESTES: conectar e consultar a auditoria unificada (permissões necessárias)
Connect-ExchangeOnline
Search-UnifiedAuditLog -StartDate (Get-Date).AddDays(-3) -EndDate (Get-Date) -Operations "New-InboxRule","FileDownloaded","UserLoggedIn" -ResultSize 200 |
  Select-Object CreationDate, UserIds, Operations, AuditData | Export-Csv .\auditoria_lab.csv -NoTypeInformation

# Gerar eventos benignos: crie uma regra de caixa de teste, baixe um arquivo de teste e depois remova a regra
New-InboxRule -Mailbox usuario.teste@seudominio.onmicrosoft.com -Name "RegraLabDFL" -SubjectContainsWords "LAB-DFL" -MarkAsRead $true
Get-InboxRule -Mailbox usuario.teste@seudominio.onmicrosoft.com
Remove-InboxRule -Mailbox usuario.teste@seudominio.onmicrosoft.com -Identity "RegraLabDFL" -Confirm:$false
```

Observação: os eventos de auditoria podem levar de minutos a horas para ficarem disponíveis. Explore os campos de `AuditData`, relacione os eventos com a conta, o IP e o aplicativo e escreva a linha do tempo.

## 5. Laboratório de IA local: registro de interações

Use um modelo pequeno executado localmente (por exemplo, com o Ollama), sem dados reais.

```bash
# Ambiente de Python e dependências
python3 -m venv ~/venvs/ia && source ~/venvs/ia/bin/activate
pip install requests duckdb mlflow dvc safetensors numpy
# Instale o Ollama conforme a documentação oficial e baixe um modelo pequeno (por exemplo, "ollama pull <modelo>")
```

```python
# Cliente que registra interações no formato do modelo E da pasta 25 (JSON Lines), com hashes
import hashlib, json, time, uuid, requests
from datetime import datetime, timezone

URL = "http://127.0.0.1:11434/api/generate"   # API local do Ollama
MODELO = "nome-do-modelo-local"                # ajuste ao modelo instalado
PROMPT_SISTEMA_VERSAO = "ps-v1"

def sha256(texto: str) -> str:
    return hashlib.sha256(texto.encode("utf-8")).hexdigest()

def consultar(usuario: str, prompt: str, arquivo_log="interacoes_lab.jsonl"):
    t0 = time.time()
    r = requests.post(URL, json={"model": MODELO, "prompt": prompt, "stream": False,
                                 "options": {"temperature": 0.2, "seed": 42}}, timeout=120)
    resposta = r.json().get("response", "")
    registro = {
        "id_requisicao": str(uuid.uuid4()),
        "horario_utc": datetime.now(timezone.utc).isoformat(),
        "usuario": usuario,
        "modelo": MODELO,
        "versao_prompt_sistema": PROMPT_SISTEMA_VERSAO,
        "parametros": {"temperature": 0.2, "seed": 42},
        "latencia_s": round(time.time() - t0, 3),
        "hash_prompt": sha256(prompt),
        "hash_resposta": sha256(resposta),
        "conteudo_prompt": prompt,
        "conteudo_resposta": resposta,
    }
    with open(arquivo_log, "a", encoding="utf-8") as f:
        f.write(json.dumps(registro, ensure_ascii=False) + "\n")
    return resposta

if __name__ == "__main__":
    print(consultar("aluno.lab", "Explique em duas frases o que é uma cadeia de custódia."))
```

```bash
# Consulta em DuckDB sobre os registros
duckdb -c "SELECT usuario, count(*) AS interacoes, round(avg(latencia_s),2) AS latencia_media FROM read_json_auto('interacoes_lab.jsonl') GROUP BY usuario;"
```

**Exercícios:** (1) execute 10 interações e analise o registro; (2) repita o mesmo prompt várias vezes com e sem a semente fixa e observe o não determinismo; (3) escreva a reconstrução de uma conversa a partir do registro; (4) busque texto oculto e caracteres invisíveis em um documento de teste **inofensivo** criado por você (pasta 25).

## 6. Integridade de modelos e versionamento de dados

```python
# Criar dois "modelos" minúsculos em formato seguro (safetensors), um deles com alteração simulada
import numpy as np
from safetensors.numpy import save_file

rng = np.random.default_rng(7)
tensores = {"camada1.peso": rng.standard_normal((4, 4)).astype("float32"),
            "camada1.vies": np.zeros(4, dtype="float32")}
save_file(tensores, "modelo_v1.safetensors", metadata={"origem": "lab", "versao": "1"})
tensores["camada1.peso"][0, 0] += 0.5       # alteração simulada
save_file(tensores, "modelo_v2.safetensors", metadata={"origem": "lab", "versao": "2"})
```

```bash
sha256sum modelo_v1.safetensors modelo_v2.safetensors | tee manifesto_modelos.sha256
sha256sum -c manifesto_modelos.sha256
```

```python
# Comparar as duas versões (diferença por tensor) e os metadados
import numpy as np
from safetensors import safe_open

def carregar(caminho):
    with safe_open(caminho, framework="numpy") as f:
        return {k: f.get_tensor(k) for k in f.keys()}, f.metadata()

a, ma = carregar("modelo_v1.safetensors")
b, mb = carregar("modelo_v2.safetensors")
print("Metadados:", ma, mb)
for nome in sorted(set(a) | set(b)):
    print(nome, "norma da diferença =", float(np.linalg.norm(a[nome] - b[nome])))
```

```bash
# Versionamento de dados com o DVC (repositório de laboratório)
git init lab_dados && cd lab_dados && dvc init
printf "id,valor\n1,10\n2,20\n" > dados.csv
dvc add dados.csv && git add dados.csv.dvc .gitignore && git commit -m "dados v1"
printf "id,valor\n1,10\n2,20\n3,30\n" > dados.csv
dvc add dados.csv && git add dados.csv.dvc && git commit -m "dados v2"
dvc diff HEAD~1
```

**Exercícios:** demonstre a divergência de hash entre as versões, a detecção da alteração por diferença de tensores e a identificação da mudança nos dados por `dvc diff`; registre o conjunto de versões (modelo B da pasta 24).

## 7. Rastreamento de experimentos (MLflow local)

```bash
mlflow server --host 127.0.0.1 --port 5000 &
python - <<'EOF'
import mlflow
mlflow.set_tracking_uri("http://127.0.0.1:5000")
mlflow.set_experiment("lab-dfl")
with mlflow.start_run():
    mlflow.log_param("semente", 7)
    mlflow.log_metric("acuracia", 0.91)
    mlflow.log_artifact("modelo_v1.safetensors")
EOF
```

Consulte as execuções com o cliente (pasta 24, arquivo 2), exporte o inventário e calcule os hashes dos artefatos; simule a substituição de um artefato no armazenamento local do MLflow e demonstre a detecção.

## 8. Testes de segurança de LLM (somente local e autorizado)

Ferramentas de avaliação de segurança de LLM (como promptfoo e garak) podem ser executadas **apenas contra o modelo local do laboratório**, para gerar logs de exercício e praticar a detecção. Configure o alvo como a API local, registre os resultados, e analise os registros de interação com as consultas da pasta 25. Não direcione essas ferramentas a serviços de terceiros ou de produção.

## 9. Limpeza e registro

| Item | Ação |
|---|---|
| Recursos de nuvem | Excluir buckets, usuários e instâncias criados; verificar custos |
| Locatário de testes | Remover regras e dados de teste |
| Ambiente de IA | Parar servidores locais; arquivar os registros relevantes com hash |
| Documentação | Registro de ferramentas, comandos, resultados e limitações; mini-relatório |

## 10. Perguntas de verificação

| Pergunta | Resposta esperada |
|---|---|
| Por que o histórico de eventos da nuvem não substitui uma trilha configurada? | O histórico tem retenção limitada e cobertura restrita; a trilha garante retenção e cobertura configuradas |
| Por que eventos de dados do armazenamento precisam ser habilitados? | Sem eles, não há registro de leitura de objetos |
| Por que registrar hash de prompt e de resposta no registro de interações? | Verificar a integridade e permitir a correlação sem manter o texto quando necessário |
| Por que preferir `safetensors` a formatos baseados em serialização de objetos? | O formato não executa código ao carregar |
| O que o não determinismo implica para a prova? | A reexecução não substitui o registro original |

## 11. Casos de uso corporativos

- Treinamento em investigações de nuvem, de Microsoft 365 e de IA sem risco para a produção.
- Desenvolvimento de consultas e de detecções em ambiente de teste.
- Protótipo do registro de interações com LLM antes da adoção em aplicações reais.

## 12. Normas e frameworks relevantes

- MITRE ATT&CK for Cloud; MITRE ATLAS; OWASP Top 10 para LLM; NIST AI RMF 1.0 e NIST AI 600-1
- ISO/IEC 27017; ISO/IEC 42001:2023; NIST SP 800-92; CIS Benchmarks e CIS Controls v8.1
- LGPD, arts. 6º, 37 e 46

## 13. Referências

- Documentação do AWS CloudTrail, do Azure Monitor e Log Analytics, do Google Cloud Audit Logs e do Microsoft Purview.
- Documentação do Ollama, do MLflow, do DVC e do safetensors.
- Pastas 17, 18, 19, 24, 25 e 26 deste repositório; PB-30 e PB-45 (pasta 23).
