---
name: azure-compliance
description: Audits Azure resources for security compliance, policy violations, and governance gaps. Use when asked to "check Azure compliance", "audit security posture", "what's not compliant", "review Azure governance", or "apply Azure Policy".
---

# Azure Compliance & Governance

Audit Azure resources against security baselines and governance policies.

## Trigger phrases
- "check Azure compliance"
- "audit security posture"
- "what resources are not compliant"
- "apply Azure Policy"
- "review governance"
- "security baseline check"

## Compliance Audit Workflow

### 1. Check Azure Policy compliance
```bash
# Get non-compliant resources
az policy state list \
  --filter "complianceState eq 'NonCompliant'" \
  --query "[].{Resource:resourceId, Policy:policyDefinitionName, Reason:complianceReasonCode}" \
  --output table
```

### 2. Microsoft Defender for Cloud
```bash
# Get security recommendations
az security assessment list \
  --query "[?properties.status.code=='Unhealthy'].{Name:displayName, Severity:properties.metadata.severity}" \
  --output table
```

### 3. Key compliance checks
| Area | Check | Command |
|---|---|---|
| Storage | Public access disabled | `az storage account list --query "[?allowBlobPublicAccess==true]"` |
| Key Vault | Soft delete enabled | `az keyvault list --query "[?properties.enableSoftDelete!=true]"` |
| SQL | TDE enabled | `az sql db tde show` |
| VMs | Disk encryption | `az vm encryption show` |
| RBAC | Owner assignments | `az role assignment list --role Owner` |

### 4. Apply remediation policies
```bash
# Assign built-in security policy initiative (Azure Security Benchmark)
az policy assignment create \
  --name "azure-security-benchmark" \
  --policy-set-definition "1f3afdf9-d0c9-4c3d-847f-89da613e70a8" \
  --scope /subscriptions/<sub-id>
```

### 5. Output compliance report
Produce a report with:
- **Critical** — must fix immediately (public storage, exposed secrets)
- **High** — fix within sprint (missing encryption, broad RBAC)
- **Medium** — fix this quarter (missing tags, logging gaps)
- **Low** — best practice (lifecycle policies, cost tags)
