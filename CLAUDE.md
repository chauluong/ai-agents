# AI Agents Catalog

Multi-domain AI agent catalog. Open with `claude` (Claude Code) or GitHub Copilot — both discover their agents automatically.

## Structure

```
.claude/                        ← Claude Code (agents, commands, hooks config)
  agents/                       ← Sub-agents auto-discovered by claude CLI
  commands/                     ← Slash commands (/review, /scaffold, /add-agent)
  settings.json                 ← Hook wiring → points to tools/hooks/

.github/                        ← GitHub Copilot
  agents/*.agent.md             ← Copilot agents (auto-discovered)
  hooks/*/hooks.json            ← Copilot hook config → points to tools/hooks/
  prompts/*.prompt.md           ← Reusable Copilot prompts
  copilot-instructions.md       ← Workspace-level context

instructions/                   ← SHARED domain knowledge (both tools load)
  azure.instructions.md
  azure-bicep.instructions.md
  azure-aks.instructions.md
  dotnet.instructions.md
  dotnet-testing.instructions.md
  python.instructions.md
  python-fastapi.instructions.md

skills/                         ← Anthropic SKILL.md plugins (Claude Code)
  code-review/SKILL.md
  scaffold/SKILL.md
  security-review/SKILL.md

plugins/                        ← Domain bundles (agents + skills + instructions)
  azure-cloud-development/
  dotnet-development/
  python-development/

tools/                          ← SHARED scripts (both tools invoke)
  azure/                        ← az CLI helpers
  dotnet/                       ← dotnet scaffold helpers
  python/                       ← uv/project setup
  hooks/                        ← Hook scripts shared by .claude/ and .github/
    validate-cmd.ps1
    scan-secrets.ps1
    session-logger.ps1
```

## Agents

| Domain | Claude Code | GitHub Copilot |
|--------|-------------|----------------|
| Azure  | `azure` | `azure-iac-generator`, `azure-devops` |
| .NET   | `dotnet` | `dotnet-architect` |
| Python | `python` | `python-fastapi` |

## Slash Commands (Claude Code)
| Command | Usage |
|---------|-------|
| `/review` | `/review src/MyService.cs` |
| `/scaffold` | `/scaffold azure bicep storage-account` |
| `/add-agent` | `/add-agent azure azure-aks "AKS specialist"` |

## Hooks — shared scripts, dual wiring

| Script | Claude Code event | Copilot event |
|--------|-------------------|---------------|
| `tools/hooks/validate-cmd.ps1` | `PreToolUse (Bash)` | `preToolCall` |
| `tools/hooks/session-logger.ps1` | `PostToolUse (Write\|Edit)` | `sessionEnd` |
| `tools/hooks/scan-secrets.ps1` | `Stop` | `sessionEnd` |

## Adding a New Domain
1. `/add-agent <domain> <name> "<desc>"` — creates both Claude + Copilot agent files, updates `registry.json`
2. Add instructions → `instructions/<domain>.instructions.md`
3. Add tools → `tools/<domain>/`
4. Add plugin bundle → `plugins/<domain>-development/README.md`
