---
name: azure-validate
description: Validates an Azure deployment plan and IaC templates before deployment. Use when asked to "validate the deployment plan", "check the infrastructure", or "is this ready to deploy". Must run AFTER azure-prepare and BEFORE azure-deploy.
---

# Azure Validate

Validate the deployment plan and all IaC templates, then mark the plan as `Validated` if checks pass.

## Trigger phrases
- "validate the deployment plan"
- "check if ready to deploy"
- "review the infrastructure"
- "run pre-deployment checks"

## Prerequisites
- `.azure/deployment-plan.md` exists (created by `azure-prepare`)
- IaC files exist under `infra/`

## Validation Checklist

### IaC validation
```bash
az bicep build --file infra/main.bicep
az deployment group validate \
  --resource-group <rg> \
  --template-file infra/main.bicep \
  --parameters @infra/main.bicepparam
```

### Security checks
- [ ] No hardcoded secrets or connection strings
- [ ] Key Vault used for all sensitive values
- [ ] `publicNetworkAccess: 'Disabled'` on storage and databases
- [ ] Managed Identity used (no service principal secrets)
- [ ] Minimum required RBAC roles only
- [ ] Private Endpoints configured for production

### Cost checks
- [ ] SKUs are appropriate for the target environment
- [ ] Auto-scale configured where applicable
- [ ] No unnecessary resources included

### Naming & tagging
- [ ] All resources follow `<env>-<region>-<workload>-<type>` convention
- [ ] Required tags present: `Environment`, `Owner`, `CostCenter`, `ManagedBy`

## On success
Update `.azure/deployment-plan.md` status:
```
Status: Validated ✅
```

## On failure
List all failing checks with remediation steps. Do NOT mark as Validated.
