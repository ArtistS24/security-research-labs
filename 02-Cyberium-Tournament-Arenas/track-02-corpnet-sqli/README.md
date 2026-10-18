# Track 02 — CorpNet SQL Injection Arena

[![Domain](https://img.shields.io/badge/Track-02_CorpNet_SQLi-38bdf8?style=for-the-badge&logo=mysql&logoColor=white)](https://github.com/ArtistS24/security-research-labs)
[![Standard](https://img.shields.io/badge/Standard-OWASP_Top_10-38bdf8?style=for-the-badge&logo=owasp&logoColor=white)](https://owasp.org/)
[![Tournament](https://img.shields.io/badge/Event-Cyberium_Hack_The_Grid-10b981?style=for-the-badge&logo=target&logoColor=white)](https://github.com/ArtistS24/security-research-labs)
[![Author](https://img.shields.io/badge/Architect-Denis_Albin-38bdf8?style=for-the-badge&logo=github&logoColor=white)](https://github.com/ArtistS24)

CorpNet is a relational database personnel query application engineered by **Denis Albin** for the **Cyberium "Hack The Grid" CTF Tournament** (Course Module: `XE107 - SQL`).

The application simulates an internal corporate directory where participants identify and exploit classic, union-based, and blind SQL injection vulnerabilities to extract proprietary database structures, administrator credentials, and hidden flags.

---

## Challenge Overview & Walkthrough Dossier

The track includes a complete, 10-question official walkthrough authored by Denis Albin detailing every SQL payload, schema mapping query, and flag extraction.

| Document Title | Scope & Topics | Questions | Official Solution Dossier |
| :--- | :--- | :---: | :--- |
| **CorpNet SQL Injection Walkthrough** | Authentication Bypass, UNION-based Extraction, Schema Dump | 10 | [`corpnet-sqli-walkthrough.pdf`](walkthroughs/corpnet-sqli-walkthrough.pdf) (631 KB) |

---

## Technical Architecture & Attack Vectors

```yaml
track_metadata:
  name: "CorpNet Employee Directory"
  stack: "PHP 8.x + MySQL 8.0 (Docker Compose)"
  tournament_id: "XE107 - SQL"
  total_questions: 10
  archive_package: "htg-sqli.zip"
  archive_password: "infected"

attack_surface:
  reconnaissance:
    vector: "Login form parameter probing & search query syntax fuzzing"
    target: "Identifying error leaks revealing backend DBMS dialect"
  exploitation_phases:
    phase_01: "Authentication Bypass via tautological payload (' OR '1'='1' --)"
    phase_02: "Column count discovery via ORDER BY and UNION SELECT null enumeration"
    phase_03: "Metadata extraction via information_schema.tables and information_schema.columns"
    phase_04: "Credential harvesting, password hash exfiltration, and tournament flag recovery"
```

---

## Deployment & Local Execution

The environment consists of an application service and an isolated MySQL database linked via Docker Compose.

```bash
# 1. Extract tournament challenge package (password: infected)
unzip -P infected htg-sqli.zip

# 2. Enter lab directory and launch compose stack
cd htg-sqli-final
bash start.sh

# 3. Access the running portal
# URL: http://localhost:8080
```

### Manual Teardown

```bash
cd htg-sqli-final
docker compose down
```
