# Plugin: Azure Cloud Development

Bundles all Azure agents, skills, instructions, MCP config, and hooks into one installable unit.

## Deployment Pipeline Skills
The Azure skills follow a structured pipeline:

```
azure-prepare → azure-validate → azure-deploy
```
Always run in this order. `azure-deploy` will not proceed without a `Validated` plan.

## All Skills
| Skill | Trigger | Description |
|---|---|---|
| `azure-prepare` | "prepare for deployment" | Analyse app, select services, generate IaC + deployment plan |
| `azure-validate` | "validate deployment plan" | Validate IaC and security checks, mark plan as Validated |
| `azure-deploy` | "deploy to Azure" | Execute validated deployment plan |
| `azure-diagnostics` | "why is my app failing" | Diagnose resource and application issues |
| `azure-cost` | "reduce Azure costs" | Analyse spend and recommend optimisations |
| `azure-kubernetes` | "create AKS cluster" | Plan and deploy AKS clusters and workloads |
| `azure-ai` | "add AI to my app" | Integrate Azure OpenAI, AI Search, Speech, Doc Intelligence |
| `azure-storage` | "store files in Azure" | Configure Blob Storage, Queue, Data Lake |
| `azure-compliance` | "check Azure compliance" | Audit security posture and policy violations |

## Included Agents
| Agent | File | Description |
|---|---|---|
| Azure IaC Generator | `.github/agents/azure-iac-generator.agent.md` | Bicep / ARM / Terraform generation |
| Azure DevOps Engineer | `.github/agents/azure-devops.agent.md` | Pipelines and CI/CD |
| Azure (Claude) | `.claude/agents/azure.md` | General Azure tasks via Claude Code |

## Shared Instructions
- `instructions/azure.instructions.md`
- `instructions/azure-bicep.instructions.md`
- `instructions/azure-aks.instructions.md`

## MCP Server
`.mcp.json` — wires `@azure/mcp@latest` for live Azure resource access via MCP tools.

## Shared Tools
- `tools/azure/check-context.ps1`
- `tools/azure/validate-bicep.ps1`

## Hooks
- `.github/hooks/secrets-scanner/` — scan for leaked secrets
- `.github/hooks/validate-azure-cmd/` — block destructive az commands
