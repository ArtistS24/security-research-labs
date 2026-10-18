# 01 — Threat Intelligence: In-The-Wild Research

[![Domain](https://img.shields.io/badge/Domain-Threat_Intelligence_%26_OSINT-e879f9?style=for-the-badge&logo=target&logoColor=white)](https://github.com/ArtistS24/security-research-labs)
[![Standard](https://img.shields.io/badge/Threat_Vector-LLM_Indirect_Prompt_Injection-10b981?style=for-the-badge&logo=openai&logoColor=white)](https://github.com/ArtistS24/security-research-labs)
[![Researcher](https://img.shields.io/badge/Lead_Researcher-Denis_Albin-38bdf8?style=for-the-badge&logo=github&logoColor=white)](https://github.com/ArtistS24)

This directory houses original empirical threat intelligence studies, adversary telemetry analysis, and defensive countermeasures conducted by **Denis Albin**.

---

## Active Case Study: CTFtime Indirect Prompt-Injection Trap

```yaml
case_study:
  target_platform: "https://ctftime.org"
  exfil_endpoint: "https://ctfti.me/llm-exp/?tid=<writeup_id>"
  threat_category: "Indirect Prompt Injection & Anti-Scraper Retaliation"
  mechanism: "Hidden HTML comments / untrusted markdown targeting automated AI agents"
  payload_objective: "Forces automated LLM fetchers to exfiltrate /proc/self/environ and hostnames"
```

### Research Artifacts & Evidence Files

- **[`FINDINGS.md`](ctftime-prompt-injection/FINDINGS.md)**: Full OSINT investigation report, WHOIS infrastructure mapping, discovery timeline, and raw HTTP payloads.
- **[`CONCLUSIONS.md`](ctftime-prompt-injection/CONCLUSIONS.md)**: Adversary motivation analysis, architectural takeaways, and strict sandboxing countermeasures.
- **[`test-ua-cloaking.ps1`](ctftime-prompt-injection/test-ua-cloaking.ps1)**: Automated PowerShell telemetry probing suite testing User-Agent cloaking behaviors across 51 HTTP client signatures.
- **[`ua-test-results.csv`](ctftime-prompt-injection/ua-test-results.csv)**: Empirical response matrix validating platform-level delivery stability.
- **[`screenshots/`](ctftime-prompt-injection/screenshots/)**: Telemetry logs, execution captures, and raw payload extracts.
