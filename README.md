# Security Research & Vulnerable Lab Arenas

> **Author**: Denis Albin ([ArtistS24](https://github.com/ArtistS24))  
> **Focus**: Threat Intelligence, AI Security Research, and Web Exploitation Lab Architecture  

---

## 01. In-the-Wild Threat Intelligence: CTFtime Prompt Injection

An original, investigative OSINT and telemetry study uncovering an active, in-the-wild **indirect prompt injection operation** embedded inside CTFtime writeup pages targeting AI web scrapers.

- **Threat Vector**: Hidden prompt injection instructions instructing AI scraping agents to execute bash commands dumping `/proc/self/environ` and internal hostnames to `ctfti.me/llm-exp/?tid=<id>`.
- **Methodology**: Automated User-Agent cloaking tests (`test-ua-cloaking.ps1`), cross-referenced against Russian infrastructure registrations, VirusTotal mirrors, and live canary response telemetry (`ua-test-results.csv`).
- **Reports**:
  - [`FINDINGS.md`](01-Threat-Intelligence/ctftime-prompt-injection/FINDINGS.md) — Technical telemetry, network requests, WHOIS infrastructure traces, and live payload analysis.
  - [`CONCLUSIONS.md`](01-Threat-Intelligence/ctftime-prompt-injection/CONCLUSIONS.md) — Threat actor motivation modeling (Anti-AI scraping retaliation, credential harvesting, agent fingerprinting).

---

## 02. Vulnerable Training Arenas & Exploit Proof-of-Concepts

Full challenge architecture, vulnerable web application source code, and step-by-step penetration testing walkthroughs created for **Cyberium Arena** and **Hack The Grid**.

### A. CorpLink PHP Exploitation Suite
*Comprehensive multi-stage PHP application exploitation.*
- **Challenge 01 — Unrestricted File Upload**: File extension validation bypasses, MIME-type spoofing, webshell execution, and Remote Code Execution (RCE).
  - *Report*: [`c1-file-upload.pdf`](02-Vulnerable-Lab-Arenas/php-exploitation-corplink/Challenge%201/c1-file-upload.pdf)
- **Challenge 02 — OS Command Injection**: Input sanitization bypasses, argument separators, and shell breakout.
  - *Report*: [`c2-command-injection.pdf`](02-Vulnerable-Lab-Arenas/php-exploitation-corplink/Challenge%202/c2-command-injection.pdf)
- **Challenge 03 — Local File Inclusion (LFI)**: Path traversal techniques (`../../etc/passwd`), null-byte injection, and PHP wrapper filters.
  - *Report*: [`c3-lfi.pdf`](02-Vulnerable-Lab-Arenas/php-exploitation-corplink/Challenge%203/c3-lfi.pdf)
- **Challenge 04 — Cookie Manipulation**: Session tampering, role privilege escalation to administrator.
  - *Report*: [`c4-cookie.pdf`](02-Vulnerable-Lab-Arenas/php-exploitation-corplink/Challenge%204/c4-cookie.pdf)
- *Lab Code*: [`htg-php.zip`](02-Vulnerable-Lab-Arenas/php-exploitation-corplink/htg-php.zip)

### B. CorpNet SQL Injection Arena
*Structured relational database exploitation.*
- Authentication bypass via tautology injection.
- Column discovery via `ORDER BY` clause fuzzing.
- `UNION`-based exfiltration of credentials and database schema.
- Error-based information disclosure and mitigation design.
- *Report*: [`walkthrough-v3.pdf`](02-Vulnerable-Lab-Arenas/sql-injection-corpnet/walkthrough-v3.pdf)
- *Lab Code*: [`htg-sqli.zip`](02-Vulnerable-Lab-Arenas/sql-injection-corpnet/htg-sqli.zip)

### C. BrightBoard Cross-Site Scripting (XSS)
*Full-spectrum client-side exploitation.*
- Reflected XSS input vector discovery and payload evasion.
- Stored XSS persistent cookie hijacking.
- DOM-based execution sinks and browser contextual encoding bypasses.
- *Report*: [`BrightBoard-XSS-Walkthrough.pdf`](02-Vulnerable-Lab-Arenas/xss-exploitation-brightboard/BrightBoard-XSS-Walkthrough.pdf)
- *Report*: [`c1-reflected-xss.pdf`](02-Vulnerable-Lab-Arenas/xss-exploitation-brightboard/Challenge%201/c1-reflected-xss.pdf)
- *Lab Code*: [`htg-xss.zip`](02-Vulnerable-Lab-Arenas/xss-exploitation-brightboard/htg-xss.zip)

---

## Technical Standards & Verification

All vulnerability walkthroughs follow formal assessment methodologies, provide reproducible proofs-of-concept, and include root-cause remediation guidance aligned with the **OWASP Top 10** standard.
