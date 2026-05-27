# Plugin: Azure Cloud Development

Bundles all Azure agents, instructions, and skills into one installable unit.

## Included Agents
| Agent | File | Description |
|---|---|---|
| Azure IaC Generator | `.github/agents/azure-iac-generator.agent.md` | Bicep / ARM / Terraform generation |
| Azure DevOps Engineer | `.github/agents/azure-devops.agent.md` | Pipelines and CI/CD |
| Azure (Claude) | `.claude/agents/azure.md` | General Azure tasks via Claude Code |

## Included Instructions (shared)
- `instructions/azure.instructions.md` — core Azure conventions
- `instructions/azure-bicep.instructions.md` — Bicep authoring rules
- `instructions/azure-aks.instructions.md` — AKS and Kubernetes

## Included Skills
- `skills/security-review/` — IaC and pipeline security audit
- `skills/scaffold/` — Azure resource scaffolding

## Shared Tools
- `tools/azure/check-context.ps1` — show current subscription
- `tools/azure/validate-bicep.ps1` — validate Bicep before deploy

## Hooks
- `.github/hooks/secrets-scanner/` — scan for leaked secrets at session end
- `.github/hooks/validate-azure-cmd/` — block destructive az commands

## Installation
Copy or reference the agent files from `.github/agents/` and `.claude/agents/`.
Instructions and skills are already at repo root — no additional setup needed.
