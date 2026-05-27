---
applyTo: "**/*.bicep,**/*.bicepparam"
---

# Azure Bicep Instructions

## Module Structure
```
infra/
  main.bicep           ← entry point, calls modules
  main.bicepparam      ← parameter file per environment
  modules/
    network.bicep
    compute.bicep
    storage.bicep
```

## Authoring Rules
- Always declare `targetScope` at the top of every file
- Use `param` with `@description()` decorator for every parameter
- Use `@allowed()` to constrain environment and SKU parameters
- Prefer `existing` resource references over hard-coded resource IDs
- Use `output` to expose resource IDs and endpoints needed by callers

## Validation
Always run before deploying:
```
az bicep build --file infra/main.bicep
az deployment group validate --resource-group <rg> --template-file infra/main.bicep --parameters @infra/main.bicepparam
```

## Security Defaults
- Set `publicNetworkAccess: 'Disabled'` on storage, Key Vault, and databases
- Enable `enableSoftDelete` and `enablePurgeProtection` on Key Vault
- Use `'TLS1_2'` as minimum TLS version on all storage and web resources
