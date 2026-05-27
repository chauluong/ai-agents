---
name: azure-prepare
description: Prepares an Azure deployment by analysing the codebase, selecting the right Azure services, generating a deployment plan, and producing IaC (Bicep or Terraform). Use when asked to "set up Azure for this app", "prepare for deployment", "create infrastructure", or "what Azure services do I need". Always runs BEFORE azure-deploy.
---

# Azure Prepare

Analyse the project and produce a complete, validated deployment plan saved to `.azure/deployment-plan.md`.

## Trigger phrases
- "prepare for Azure deployment"
- "set up Azure infrastructure"
- "what Azure services do I need"
- "create a deployment plan"

## Workflow

### 1. Analyse the codebase
- Detect language, framework, and runtime
- Identify external dependencies (databases, caches, queues, storage, AI)
- Check for existing `.azure/` folder or IaC files

### 2. Select Azure services
| Need | Recommended service |
|---|---|
| Web API / app | Azure Container Apps or App Service |
| Background jobs | Azure Container Jobs or Functions |
| Relational DB | Azure Database for PostgreSQL Flexible |
| Cache | Azure Cache for Redis |
| Queue / messaging | Azure Service Bus |
| Storage | Azure Blob Storage |
| Secrets | Azure Key Vault |
| AI / LLM | Azure OpenAI Service |
| Container registry | Azure Container Registry |

### 3. Generate IaC
- Use Bicep by default (`infra/main.bicep` + modules)
- Apply `instructions/azure-bicep.instructions.md` conventions
- Include required tags: `Environment`, `Owner`, `CostCenter`, `ManagedBy`

### 4. Write deployment plan
Save to `.azure/deployment-plan.md`:
```markdown
# Deployment Plan
Status: Draft   ← only azure-validate may set this to Validated

## Services
...

## IaC files
...

## Environment variables required
...
```

⛔ DO NOT set plan status to `Validated` yourself — that is done by the `azure-validate` skill.
