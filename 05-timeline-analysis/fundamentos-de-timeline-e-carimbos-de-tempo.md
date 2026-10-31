# Fundamentos de Timeline e Carimbos de Tempo

> **Objetivo pedagógico:** compreender o que cada carimbo de data e hora realmente representa, como cada sistema de arquivos e cada aplicação o armazena, como convertê-los com segurança para UTC e quais limitações afetam a interpretação.

## 1. Por que a linha do tempo é central na forense

A linha do tempo (timeline) organiza em ordem cronológica os eventos reconstruídos a partir de múltiplas fontes. Ela permite responder às perguntas fundamentais de qualquer investigação: o que aconteceu, em que ordem, em que intervalo de tempo, por qual conta e por qual sistema. Uma linha do tempo só é confiável se os carimbos forem corretamente interpretados e normalizados.

## 2. MACB: os quatro carimbos de um arquivo

| Letra | Nome | Significado geral | Cuidado |
|---|---|---|---|
| M | Modified | Última alteração do conteúdo | Pode ser preservada em cópias |
| A | Accessed | Último acesso ao arquivo | Frequentemente desabilitada ou atrasada por desempenho |
| C | Changed | Alteração de metadados (no NTFS, alteração do registro MFT; em Unix, alteração do inode) | Em Unix, "ctime" não é data de criação |
| B | Born | Criação do arquivo no volume | Nem todos os sistemas de arquivos registram |

### 2.1 Comportamento por sistema de arquivos

| Sistema | Carimbos | Resolução e referência de tempo | Observações |
|---|---|---|---|
| NTFS | 4 em `$STANDARD_INFORMATION` e 4 em `$FILE_NAME` (8 no total por arquivo) | 100 ns; UTC (FILETIME) | `$FILE_NAME` é atualizado pelo sistema em operações como renomear e mover; é mais difícil de alterar por aplicações |
| FAT32 | Criação, modificação e data de acesso | Modificação com 2 s; hora local, sem fuso armazenado | O acesso guarda apenas a data |
| exFAT | Criação, modificação e acesso | Resolução de 10 ms; armazena deslocamento de fuso em campos próprios | Interpretar o deslocamento |
| ext3 | Modificação, acesso e mudança de inode | 1 s | Sem data de criação |
| ext4 | Modificação, acesso, mudança de inode e criação (crtime) | Nanossegundos em inodes estendidos | Algumas ferramentas só exibem crtime com utilitários recentes (por exemplo, `stat`) |
| APFS | Criação, modificação, mudança de atributos e acesso | Nanossegundos | Comportamento de acesso depende do sistema |
| HFS+ | Criação, modificação, mudança de atributos e acesso | 1 s | Datas armazenadas em UTC |

Observações sobre atualização do acesso:

- Windows: em versões modernas, a atualização do último acesso costuma estar desabilitada ou adiada por padrão; não presuma que "Accessed" indica leitura recente.
- Linux: a opção de montagem `relatime` atualiza o acesso apenas sob condições (por exemplo, se o acesso anterior for mais antigo que a modificação ou tiver mais de 24 horas).
- Antivírus, indexadores, backups e atualizações modificam carimbos em massa.

### 2.2 Regras práticas de interpretação

| Observação | Interpretação provável |
|---|---|
| Criação posterior à modificação (NTFS) | Arquivo copiado: a cópia recebe nova data de criação e preserva a de modificação |
| Todos os arquivos de uma pasta com o mesmo horário de criação | Instalação, extração, restauração de backup ou cópia em lote |
| Datas de criação idênticas e fração de segundo zerada | Possível alteração artificial; investigar (ver arquivo de manipulação) |
| Modificação anterior à criação do volume | Origem em outro sistema, cópia ou data alterada |

## 3. Referências de tempo e épocas

| Sistema ou formato | Unidade | Época (início) | Observação |
|---|---|---|---|
| Windows FILETIME | 100 ns | 1601-01-01 UTC | NTFS, registro, EVTX, muitos artefatos |
| Unix epoch | Segundos (ou ms, μs, ns) | 1970-01-01 UTC | Linux, macOS, Android, logs, JSON |
| Chrome e WebKit | Microssegundos | 1601-01-01 UTC | Histórico de navegadores baseados em Chromium |
| Firefox (PRTime) | Microssegundos | 1970-01-01 UTC | Bancos do Firefox |
| Apple Cocoa (Core Data) | Segundos | 2001-01-01 UTC | macOS e iOS |
| OLE e Excel | Dias | 1899-12-30 | Documentos Office |
| GPS | Semanas e segundos | 1980-01-06 | Dispositivos de navegação |

Fórmulas úteis:

- Unix = FILETIME / 10.000.000 − 11.644.473.600 (segundos)
- Chrome (segundos Unix) = valor em microssegundos / 1.000.000 − 11.644.473.600
- Unix = Cocoa + 978.307.200 (segundos)

## 4. Fusos horários, horário de verão e relógios

| Fator | Impacto | Medida |
|---|---|---|
| Fuso do sistema | Logs e artefatos locais podem estar em hora local | Registrar o fuso de cada fonte e normalizar para UTC |
| Horário de verão | Horários ambíguos ou inexistentes nas transições | Usar base IANA de fusos (que guarda o histórico); o Brasil não adota horário de verão desde 2019, mas datas anteriores podem ter sido afetadas |
| Desvio do relógio (clock skew) | Diferença entre o relógio do sistema e a hora real | Registrar a diferença na coleta e corrigi-la na análise |
| Sincronização (NTP) | Relógios não sincronizados geram inconsistências entre fontes | Verificar a configuração e os logs de sincronização |
| Segundos intercalares | Raros; podem aparecer como 23:59:60 | Tratar como exceção |
| Alteração manual do relógio | Compromete a confiabilidade dos registros | Detectar por eventos de mudança de hora |

Regra de ouro: toda linha do tempo deve ser apresentada em UTC, com o fuso original e a margem de erro de cada fonte documentados.

## 5. Exemplos práticos de conversão

```powershell
# FILETIME para data UTC
[DateTime]::FromFileTimeUtc(133754400000000000)

# Data para FILETIME
([DateTime]::SpecifyKind((Get-Date "2026-10-31T10:00:00"), "Utc")).ToFileTimeUtc()
```

```bash
# Unix epoch para data legível em UTC
date -u -d @1761904800

# Mostrar os carimbos de um arquivo (inclui Birth, se suportado)
stat arquivo.txt

# Fuso e sincronização
timedatectl
```

```python
from datetime import datetime, timedelta, timezone

def filetime(v):  return datetime(1601,1,1,tzinfo=timezone.utc) + timedelta(microseconds=v//10)
def unix(v):      return datetime.fromtimestamp(v, tz=timezone.utc)
def webkit(v):    return datetime(1601,1,1,tzinfo=timezone.utc) + timedelta(microseconds=v)
def cocoa(v):     return datetime(2001,1,1,tzinfo=timezone.utc) + timedelta(seconds=v)

print(filetime(133754400000000000).isoformat())
print(unix(1761904800).isoformat())
```

## 6. Relação entre carimbo e evento

Um carimbo não é sempre o horário do evento que o analista procura. Registre o que cada campo significa:

| Artefato | O que o horário representa |
|---|---|
| Data de modificação de arquivo | Última gravação do conteúdo, e não a última abertura |
| Última gravação de chave de registro | Última alteração naquela chave ou em seus valores, não necessariamente a execução de um programa |
| Entrada de log | Momento em que o registro foi escrito, que pode divergir do momento do evento |
| Tempo de criação de processo | Início do processo, e não a primeira execução do programa |
| Data de visita em histórico de navegador | Visita registrada, sujeita a sincronização entre dispositivos |

## 7. Casos de uso corporativos

- Reconstrução do intervalo entre o acesso inicial e a criptografia em um ataque de ransomware.
- Comprovação do horário de uma cópia de arquivos antes do desligamento de um colaborador.
- Normalização de logs de equipamentos que operam em fusos distintos.

## 8. Normas e frameworks relevantes

- NIST SP 800-86 (análise de dados e correlação temporal)
- ISO/IEC 27042:2015 (análise e interpretação)
- ISO/IEC 27002:2022, controle 8.17 (sincronização de relógios)
- CIS Controls v8.1, safeguard 8.4 (padronizar a sincronização de tempo)
- ISO 8601 e RFC 3339 (representação de data e hora)
- RFC 5905 (NTPv4)
- MITRE ATT&CK T1070.006 (Timestomp)

## 9. Referências

- Carrier, B. File System Forensic Analysis. Addison-Wesley, 2005.
- Casey, E. Digital Evidence and Computer Crime. 3. ed. Academic Press, 2011.
- Microsoft. Documentação sobre FILETIME e NTFS.
- Klyne, G.; Newman, C. RFC 3339: Date and Time on the Internet: Timestamps. 2002.
- Mills, D. et al. RFC 5905: Network Time Protocol Version 4. 2010.
- SANS Institute. FOR508: Advanced Incident Response, Threat Hunting and Digital Forensics.
- Kent, K. et al. NIST SP 800-86. 2006.
