---
applyTo: "**/*.bicep,**/*.json,**/azure-*,**/*-azure*"
---

# Azure Domain Instructions

## Subscription & Context
- Always run `az account show` before resource operations
- Use `az account set --subscription <name-or-id>` to switch contexts
- Store subscription IDs in environment variables, never hardcode them

## IaC Conventions
- Prefer Bicep (`.bicep`) over ARM JSON for all new templates
- Use `az deployment group validate` before `az deployment group create`
- Organize Bicep modules under `infra/modules/`; main entry point is `infra/main.bicep`
- Required resource tags: `Environment`, `Owner`, `CostCenter`, `ManagedBy`

## RBAC
- Always assign the minimum required role
- Prefer built-in roles over custom roles
- Scope assignments to resource group or resource level, never subscription unless required

## Naming Convention
`<env>-<region-short>-<workload>-<resource-type>`
Examples: `prod-eus-api-rg` (resource group), `prod-eus-api-kv` (key vault)

## Common Patterns
- Use Managed Identity instead of service principal secrets where possible
- Store secrets in Azure Key Vault; reference via Key Vault references in App Config
- Use Private Endpoints for PaaS services in production
