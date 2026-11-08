# Track 03 — BrightBoard Cross-Site Scripting (XSS) Arena

[![Domain](https://img.shields.io/badge/Track-03_BrightBoard_XSS-f59e0b?style=for-the-badge&logo=javascript&logoColor=white)](https://github.com/ArtistS24/security-research-labs)
[![Standard](https://img.shields.io/badge/Standard-OWASP_Top_10-38bdf8?style=for-the-badge&logo=owasp&logoColor=white)](https://owasp.org/)
[![Tournament](https://img.shields.io/badge/Event-Cyberium_Hack_The_Grid-10b981?style=for-the-badge&logo=target&logoColor=white)](https://github.com/ArtistS24/security-research-labs)
[![Author](https://img.shields.io/badge/Architect-Denis_Albin-38bdf8?style=for-the-badge&logo=github&logoColor=white)](https://github.com/ArtistS24)

BrightBoard is an interactive corporate communication platform engineered by **Denis Albin** for the **Cyberium "Hack The Grid" CTF Tournament** (Course Module: `XE107-M03`).

The arena simulates a workplace discussion board where participants discover and exploit Reflected, Stored, and DOM-based Cross-Site Scripting vulnerabilities, culminating in session token hijacking and administrative account takeover.

---

## Challenge Overview & Walkthrough Dossiers

The track includes 2 official walkthrough dossiers authored by Denis Albin containing detailed JavaScript payload craft, DOM inspection, and cookie exfiltration workflows.

| Document Title | Scope & Topics | Questions | Official Solution Dossier |
| :--- | :--- | :---: | :--- |
| **BrightBoard Master Walkthrough** | Comprehensive XSS: Reflected, Stored, DOM sinks & Cookie Hijack | 10 | [`BrightBoard-XSS-Walkthrough.pdf`](walkthroughs/BrightBoard-XSS-Walkthrough.pdf) (589 KB) |
| **Challenge 01 — Reflected XSS** | URL parameter reflection, context breaking & script injection | 6 | [`c1-reflected-xss.pdf`](walkthroughs/c1-reflected-xss.pdf) (904 KB) |

---

## Technical Architecture & Attack Vectors

```yaml
track_metadata:
  name: "BrightBoard Collaboration Suite"
  stack: "PHP 8.2 + SQLite (PDO) + JavaScript Frontend (Docker Compose)"
  tournament_id: "XE107-M03"
  total_questions: 16
  archive_package: "htg-xss.zip"
  archive_password: "infected"

attack_surface:
  reflected_xss:
    vector: "Search query reflection in URL parameter ?q="
    mechanism: "Unencoded output rendering directly into HTML context"
    exploit: "<script>alert(document.domain)</script>"
  stored_xss:
    vector: "Persistent message board post submission"
    mechanism: "SQLite storage of unescaped user comments rendered to all active users"
    exploit: "Injected payload steals document.cookie upon victim thread viewing"
  dom_xss:
    vector: "Client-side JavaScript DOM manipulation (?name= parameter)"
    mechanism: "Unsafe innerHTML / window.location.search sinks processing untrusted client input"
    exploit: "Execution flow redirection bypassing server-side input filters"
```

---

## Deployment & Local Execution

The environment launches via Docker Compose using `htg-xss.zip`.

```bash
# 1. Extract tournament challenge package (password: infected)
unzip -P infected htg-xss.zip

# 2. Enter lab directory and launch compose stack
cd htg-xss-final
bash start.sh

# 3. Access the running portal
# URL: http://localhost:8080
```

### Manual Teardown

```bash
cd htg-xss-final
docker compose down
```
