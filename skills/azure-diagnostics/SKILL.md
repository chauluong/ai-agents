---
name: azure-diagnostics
description: Diagnoses Azure resource issues, deployment failures, and application errors. Use when asked to "why is my Azure app failing", "diagnose deployment errors", "check Azure logs", "why is my resource unhealthy", or any Azure troubleshooting request.
---

# Azure Diagnostics

Systematically diagnose and resolve Azure resource and application issues.

## Trigger phrases
- "why is my Azure app failing"
- "diagnose deployment errors"
- "check Azure logs"
- "resource is unhealthy"
- "deployment failed"
- "app keeps crashing"

## Diagnostic Workflow

### 1. Identify the scope
Determine what is failing:
- Resource provisioning failure
- Application startup failure
- Runtime / performance issue
- Network / connectivity issue

### 2. Check resource health
```bash
# Resource group deployment errors
az deployment group list --resource-group <rg> --query "[?properties.provisioningState=='Failed']"

# Specific resource state
az resource show --ids <resource-id> --query "properties.provisioningState"

# Activity log for errors (last 1 hour)
az monitor activity-log list --resource-group <rg> --status Failed --offset 1h
```

### 3. Check application logs
```bash
# Container Apps
az containerapp logs show --name <app> --resource-group <rg> --follow

# App Service
az webapp log tail --name <app> --resource-group <rg>

# AKS pod logs
kubectl logs <pod> --namespace <ns> --previous
```

### 4. Check Application Insights
```bash
# Recent exceptions
az monitor app-insights query --app <ai-name> --resource-group <rg> \
  --analytics-query "exceptions | order by timestamp desc | take 20"
```

### 5. Common fixes
| Symptom | Likely cause | Fix |
|---|---|---|
| `ImagePullBackOff` | Wrong image tag or ACR auth | Check ACR role assignment on managed identity |
| `KeyVaultSecretNotFound` | Missing secret or wrong reference | Verify secret name and Key Vault access policy |
| `403 Forbidden` | Missing RBAC role | Assign correct role to managed identity |
| `ECONNREFUSED` | Private endpoint not configured | Check DNS resolution and private endpoint |
| High response time | Missing scale-out rule | Configure auto-scale trigger |
