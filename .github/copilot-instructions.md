# GitHub Copilot Workspace Instructions

This repository is a multi-domain AI agent catalog supporting both GitHub Copilot and Claude Code.

## Available Agents
| Agent | File | Invoke |
|---|---|---|
| Azure IaC Generator | `.github/agents/azure-iac-generator.agent.md` | `@azure-iac-generator` |
| Azure DevOps Engineer | `.github/agents/azure-devops.agent.md` | `@azure-devops` |
| .NET Architect | `.github/agents/dotnet-architect.agent.md` | `@dotnet-architect` |
| Python & FastAPI | `.github/agents/python-fastapi.agent.md` | `@python-fastapi` |

## Shared Resources
- **Instructions** — `instructions/*.instructions.md` — domain knowledge referenced by all agents
- **Tools/Scripts** — `tools/<domain>/` — shared PowerShell scripts
- **Hook scripts** — `tools/hooks/` — used by both `.github/hooks/*/hooks.json` and `.claude/settings.json`
- **Skills** — `skills/*/SKILL.md` — reusable Claude Code plugins
- **Plugins** — `plugins/<domain>/` — bundled agent+skill+instruction sets

## Conventions
- Agent files: `*.agent.md` in `.github/agents/`
- Instructions: `*.instructions.md` in `instructions/` (root, shared)
- Prompts: `*.prompt.md` in `.github/prompts/`
- Hook config: `hooks.json` in `.github/hooks/<hook-name>/`
- Scripts: `tools/hooks/*.ps1` (shared with Claude Code)
