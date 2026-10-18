# Security Policy

## Supported Versions

| Version | Supported |
| :--- | :--- |
| `main` (Latest) | :white_check_mark: |

## Scope & Vulnerability Research Clarification

This repository houses both:
1. **Empirical Threat Intelligence**: Live prompt injection and HTTP User-Agent cloaking telemetry (`01-Threat-Intelligence/ctftime-prompt-injection/`).
2. **Intentional Vulnerable Challenge Arenas**: The containerized applications under `02-Cyberium-Tournament-Arenas/` (`CorpLink PHP`, `CorpNet SQLi`, `BrightBoard XSS`) are deliberately vulnerable educational environments built for the Cyberium Hack The Grid CTF and intended strictly for isolated laboratory practice.

## Reporting a Vulnerability

If you identify an unintended vulnerability in the host-level isolation, Docker container boundary escapes, or an unverified exploit vector in published research:

1. **Do not file a public issue** disclosing container escape primitives or operational zero-days.
2. **Email the report directly** to:
   **albindeniswork@gmail.com**
3. **Please provide**:
   - Affected module or container specification
   - Step-by-step reproduction steps or Proof of Concept
   - Impact assessment
   - Recommended remediation or patch (if identified)

### Response SLA & Incident Timeline

- **Initial Acknowledgment**: Within 48 hours of receipt.
- **Triage & Reproduction**: Within 5 business days.
- **Remediation & Patch**: Pushed directly to `main` with public attribution upon release.

### Safe Harbor Commitment

Good-faith security research and vulnerability discovery conducted within authorized environments and reported via responsible disclosure will receive full safe harbor protection.
