# Track 01 — CorpLink PHP Exploitation Arena

[![Domain](https://img.shields.io/badge/Track-01_CorpLink_PHP-e879f9?style=for-the-badge&logo=php&logoColor=white)](https://github.com/ArtistS24/security-research-labs)
[![Standard](https://img.shields.io/badge/Standard-OWASP_Top_10-38bdf8?style=for-the-badge&logo=owasp&logoColor=white)](https://owasp.org/)
[![Tournament](https://img.shields.io/badge/Event-Cyberium_Hack_The_Grid-10b981?style=for-the-badge&logo=target&logoColor=white)](https://github.com/ArtistS24/security-research-labs)
[![Author](https://img.shields.io/badge/Architect-Denis_Albin-38bdf8?style=for-the-badge&logo=github&logoColor=white)](https://github.com/ArtistS24)

CorpLink is a multi-tier enterprise corporate intranet portal engineered by **Denis Albin** for the **Cyberium "Hack The Grid" CTF Tournament** (Course Module: `XE107-M04`).

The application simulates a legacy enterprise administrative back-office containing real-world OWASP Top 10 vulnerabilities, structured across 4 progressive attack stages.

---

## Challenge Overview & Walkthrough Dossiers

Each challenge is accompanied by Denis Albin's official, step-by-step PDF solution containing full question keys, terminal outputs, HTTP request/response captures, and exploit payloads.

| Challenge | Topic & Attack Vector | Questions | Official Solution Dossier |
| :--- | :--- | :---: | :--- |
| **Challenge 01** | Unrestricted File Upload → Webshell Deployment → RCE | 10 | [`c1-file-upload.pdf`](walkthroughs/c1-file-upload.pdf) (1.0 MB) |
| **Challenge 02** | Command Injection → Shell Metacharacter Escaping → RCE | 10 | [`c2-command-injection.pdf`](walkthroughs/c2-command-injection.pdf) (1.0 MB) |
| **Challenge 03** | Local File Inclusion (LFI) → Path Traversal (`../../`) | 9 | [`c3-lfi.pdf`](walkthroughs/c3-lfi.pdf) (882 KB) |
| **Challenge 04** | Insecure Cookie Handling → Privilege Escalation | 8 | [`c4-cookie.pdf`](walkthroughs/c4-cookie.pdf) (754 KB) |

---

## Technical Architecture & Attack Vectors

```yaml
track_metadata:
  name: "CorpLink Enterprise Intranet"
  runtime: "PHP 8.x / Apache (Dockerized)"
  tournament_id: "XE107-M04"
  total_questions: 37
  archive_package: "htg-php.zip"
  archive_password: "infected"

attack_surface:
  challenge_01:
    vector: "Unrestricted File Upload"
    flaw: "MIME-type validation bypass and lack of server-side extension whitelisting"
    impact: "Arbitrary PHP webshell upload leading to interactive OS shell"
  challenge_02:
    vector: "Remote Command Injection"
    flaw: "Unsanitized system command concatenation via user-supplied IP parameters"
    impact: "Shell separator chaining (; && |) executing unauthorized system utilities"
  challenge_03:
    vector: "Local File Inclusion (LFI)"
    flaw: "Dynamic page parameter passed to include() without path sanitization"
    impact: "Arbitrary file disclosure (/etc/passwd, internal configuration keys)"
  challenge_04:
    vector: "Cookie Role Tampering"
    flaw: "Client-side editable authorization cookies without cryptographic signatures"
    impact: "Privilege escalation to administrator dashboard"
```

---

## Deployment & Local Execution

The entire lab runs inside an isolated Docker container configured from `htg-php.zip`.

```bash
# 1. Extract tournament challenge package (password: infected)
unzip -P infected htg-php.zip

# 2. Enter lab directory and execute automated starter
cd htg-php
bash start.sh

# 3. Access the running portal
# URL: http://localhost:8080
```

### Manual Container Management

```bash
# Build and run manually
docker build -t corplink-lab .
docker run -d --name corplink-lab -p 8080:80 corplink-lab

# Teardown (or run bash stop.sh)
docker stop corplink-lab && docker rm corplink-lab
```
