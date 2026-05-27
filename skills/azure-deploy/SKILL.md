---
name: azure-deploy
description: Deploys an Azure application that has been prepared and validated. Use when asked to "deploy to Azure", "run azd up", "push to production", "publish to Azure", or "execute deployment". Requires azure-prepare and azure-validate to have completed first.
---

# Azure Deploy

Execute the deployment for an application that has a validated deployment plan.

## Trigger phrases
- "deploy to Azure"
- "run azd up"
- "push to production"
- "publish to Azure"
- "execute deployment"
- "terraform apply"

## Do NOT use for
- "create and deploy" → use `azure-prepare` first
- "build and deploy" → use `azure-prepare` first
- "set up and deploy" → use `azure-prepare` first

## Prerequisites
- `.azure/deployment-plan.md` exists with `Status: Validated ✅`

⛔ If plan status is not `Validated`, stop and run `azure-validate` first.

## Deployment Workflow

### 1. Pre-deploy checks
```bash
# Confirm subscription context
az account show
# Check resource group exists or create it
az group show --name <rg> || az group create --name <rg> --location <region>
```

### 2. Deploy infrastructure
```bash
# Bicep
az deployment group create \
  --resource-group <rg> \
  --template-file infra/main.bicep \
  --parameters @infra/main.bicepparam

# OR azd
azd up
```

### 3. Post-deploy verification
- Check all resources are in `Succeeded` provisioning state
- Verify application endpoints are reachable
- Confirm Key Vault references resolve correctly
- Check application logs for startup errors

### 4. Report results
Always present endpoints as fully-qualified HTTPS URLs:
✅ `https://myapp.azurecontainerapps.io` — NOT `myapp.azurecontainerapps.io`

### 5. Update plan
```
Status: Deployed ✅
Deployed at: <timestamp>
Endpoints: <list>
```
