# Cyberium "Hack The Grid" CTF Tournament Challenge Arenas

[![Tournament](https://img.shields.io/badge/Event-Cyberium_Hack_The_Grid-10b981?style=for-the-badge&logo=target&logoColor=white)](https://github.com/ArtistS24/security-research-labs)
[![Standard](https://img.shields.io/badge/Standard-OWASP_Top_10-38bdf8?style=for-the-badge&logo=owasp&logoColor=white)](https://owasp.org/)
[![Architect](https://img.shields.io/badge/Challenge_Architect-Denis_Albin-38bdf8?style=for-the-badge&logo=github&logoColor=white)](https://github.com/ArtistS24)
[![Solution Dossiers](https://img.shields.io/badge/Official_Walkthroughs-7_PDFs-e879f9?style=for-the-badge&logo=adobeacrobatreader&logoColor=white)](https://github.com/ArtistS24/security-research-labs)

This directory houses the complete collection of vulnerable web application arenas engineered from scratch by **Denis Albin** for the **Cyberium "Hack The Grid" CTF Tournament**.

Rather than solving pre-packaged challenges, Denis architected these multi-tier containerized environments to simulate enterprise software flaws, authored full objective rubrics, and published forensic step-by-step solution dossiers.

---

## Tournament Tracks & Walkthrough Matrix

```
02-Cyberium-Tournament-Arenas/
├── track-01-corplink-php/         # 4-stage PHP exploitation arena (RCE, LFI, Cookie)
├── track-02-corpnet-sqli/         # Relational database injection hub (Union & Blind SQLi)
└── track-03-brightboard-xss/      # Multi-vector client-side exploitation (DOM & Stored XSS)
```

| Track | Module ID | Core Vulnerabilities | Questions | Official Solution Dossiers | Track Guide |
| :--- | :--- | :--- | :---: | :--- | :--- |
| **Track 01: CorpLink PHP** | `XE107-M04` | File Upload to RCE, Command Injection, LFI Traversal, Cookie Role Tampering | 37 | • [`c1-file-upload.pdf`](track-01-corplink-php/walkthroughs/c1-file-upload.pdf) (1.0 MB)<br/>• [`c2-command-injection.pdf`](track-01-corplink-php/walkthroughs/c2-command-injection.pdf) (1.0 MB)<br/>• [`c3-lfi.pdf`](track-01-corplink-php/walkthroughs/c3-lfi.pdf) (882 KB)<br/>• [`c4-cookie.pdf`](track-01-corplink-php/walkthroughs/c4-cookie.pdf) (754 KB) | [View Runbook](track-01-corplink-php/README.md) |
| **Track 02: CorpNet SQLi** | `XE107 - SQL` | Authentication Bypass, UNION Extraction, Information Schema Enumeration | 10 | • [`corpnet-sqli-walkthrough.pdf`](track-02-corpnet-sqli/walkthroughs/corpnet-sqli-walkthrough.pdf) (631 KB) | [View Runbook](track-02-corpnet-sqli/README.md) |
| **Track 03: BrightBoard XSS** | `XE107-M03` | Reflected URL Injection, Stored Thread Payloads, DOM Sinks, Cookie Hijacking | 16 | • [`BrightBoard-XSS-Walkthrough.pdf`](track-03-brightboard-xss/walkthroughs/BrightBoard-XSS-Walkthrough.pdf) (589 KB)<br/>• [`c1-reflected-xss.pdf`](track-03-brightboard-xss/walkthroughs/c1-reflected-xss.pdf) (904 KB) | [View Runbook](track-03-brightboard-xss/README.md) |

---

## Quickstart & Local Deployment

All tournament arenas are packaged in password-protected archives (`infected`) containing complete Dockerfiles and Docker Compose manifests.

```toml
[tournament_quickstart]
archive_password = "infected"
container_engine = "Docker / Docker Compose"
network_isolation = "Bridge networking per track"
```

### 1. Launch Track 01 (CorpLink PHP)
```bash
cd track-01-corplink-php
unzip -P infected htg-php.zip
cd htg-php
bash start.sh
# Open http://localhost:8080
```

### 2. Launch Track 02 (CorpNet SQLi)
```bash
cd track-02-corpnet-sqli
unzip -P infected htg-sqli.zip
cd htg-sqli-final
bash start.sh
# Open http://localhost:8080
```

### 3. Launch Track 03 (BrightBoard XSS)
```bash
cd track-03-brightboard-xss
unzip -P infected htg-xss.zip
cd htg-xss-final
bash start.sh
# Open http://localhost:8080
```

---

## Clean Teardown

To shut down and remove challenge containers:

```bash
# CorpLink standalone container
docker stop corplink-lab && docker rm corplink-lab

# CorpNet & BrightBoard Compose stacks
docker compose -f track-02-corpnet-sqli/htg-sqli-final/docker-compose.yml down
docker compose -f track-03-brightboard-xss/htg-xss-final/docker-compose.yml down
```
