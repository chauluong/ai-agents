---
name: azure-cost
description: Analyses and optimises Azure resource costs. Use when asked to "reduce Azure costs", "optimise my Azure spend", "why is my Azure bill high", "cost review", or "right-size resources".
---

# Azure Cost Optimisation

Analyse Azure resource usage and provide actionable cost reduction recommendations.

## Trigger phrases
- "reduce Azure costs"
- "optimise my Azure spend"
- "why is my Azure bill high"
- "right-size resources"
- "cost review"

## Analysis Workflow

### 1. Get current spend
```bash
# Current month cost by resource group
az consumption usage list --billing-period-name <period> \
  --query "sort_by([].{Name:instanceName, Cost:pretaxCost, Currency:currency}, &Cost)" \
  --output table

# Cost by service type
az costmanagement query \
  --type ActualCost \
  --dataset-granularity Monthly
```

### 2. Identify waste
- [ ] Stopped VMs still incurring disk/IP costs
- [ ] Unused public IP addresses
- [ ] Over-provisioned SKUs (CPU/memory consistently < 20%)
- [ ] Old snapshots and unattached disks
- [ ] Dev/test resources running 24/7
- [ ] Unused App Service Plans with no apps

### 3. Right-sizing recommendations
```bash
# Check VM utilisation (requires Azure Monitor)
az monitor metrics list \
  --resource <vm-id> \
  --metric "Percentage CPU" \
  --interval PT1H \
  --start-time <7-days-ago>
```

### 4. Savings opportunities
| Opportunity | Typical saving |
|---|---|
| Reserved Instances (1yr) | Up to 40% |
| Azure Hybrid Benefit (Windows/SQL) | Up to 40% |
| Spot instances for batch jobs | Up to 90% |
| Dev/test pricing | Up to 55% |
| Right-size over-provisioned SKUs | 20-50% |
| Delete idle resources | 100% of that resource |

### 5. Output report
Produce a prioritised list:
1. Quick wins (delete/stop idle resources)
2. Right-sizing (change SKU)
3. Commitment discounts (Reserved Instances, Savings Plans)
4. Architectural changes (use managed services, consolidate)
