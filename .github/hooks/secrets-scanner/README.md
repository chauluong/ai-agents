# Secrets Scanner Hook

Scans files modified during an agent session for accidentally leaked secrets, credentials, API keys, and other sensitive data before they are committed.

## Trigger
`sessionEnd` — runs automatically when a Copilot coding agent session concludes.

## Script
Shared script: `tools/hooks/scan-secrets.ps1`

## Configuration

| Variable | Options | Default | Purpose |
|---|---|---|---|
| `SCAN_MODE` | `warn`, `block` | `warn` | Warn only or block the session |
| `SCAN_SCOPE` | `diff`, `staged` | `diff` | Which files to scan |
| `SECRETS_ALLOWLIST` | comma-separated patterns | unset | Known false positives to skip |

## Detected patterns
AWS keys, Azure client secrets, GitHub PATs, npm tokens, private keys, database connection strings, bearer tokens, JWTs, and more.

## Usage
Copy `hooks.json` to your project's `.github/hooks/secrets-scanner/` folder. The shared script in `tools/hooks/` is invoked automatically.
