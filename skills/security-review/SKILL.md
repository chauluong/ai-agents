---
name: security-review
description: Performs a security-focused review of code, IaC templates, or pipeline configs. Use this skill when asked to check security, find vulnerabilities, audit permissions, review secrets handling, or assess risk. Goes deeper than a standard code review on security concerns.
---

Perform a focused security review of the specified files or recent changes.

## Review Areas

### Secrets & Credentials
- Hardcoded secrets, API keys, passwords, or connection strings in code or config
- Secrets committed to version control
- Overly broad access tokens or service account keys

### Authentication & Authorisation
- Missing auth checks on endpoints or operations
- Overly permissive RBAC roles or policies
- JWT/session token handling and expiry

### Input Validation & Injection
- SQL / NoSQL / command injection risks
- Missing input sanitisation on user-controlled data
- Path traversal or file inclusion vulnerabilities

### Infrastructure (IaC)
- Public endpoints on storage, databases, or Key Vault
- Missing encryption at rest or in transit
- Overly permissive NSG / firewall rules
- Subscription-scoped role assignments

### Dependencies
- Known-vulnerable package versions (flag for manual CVE check)
- Unpinned dependency versions

## Output Format
```
[CRITICAL|HIGH|MEDIUM|LOW] path/to/file:line
Finding description.
Recommended fix.
```

Always load `instructions/azure.instructions.md` when reviewing IaC.
