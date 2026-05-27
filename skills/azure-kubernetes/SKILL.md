---
name: azure-kubernetes
description: Plans and deploys production-ready AKS clusters and Kubernetes workloads on Azure. Use when asked to "create an AKS cluster", "deploy to Kubernetes", "set up AKS", "configure k8s on Azure", or any AKS planning and deployment request.
---

# Azure Kubernetes Service (AKS)

Guide users through AKS cluster design, Day-0 decisions, and workload deployment.

## Trigger phrases
- "create an AKS cluster"
- "deploy to Kubernetes on Azure"
- "set up AKS"
- "configure AKS networking / security"
- "migrate workload to AKS"

## Day-0 Decisions (hard to change later)

### SKU choice
- **AKS Automatic** (default) — pre-configured best practices, managed node pools
- **AKS Standard** — full control, custom node pool configuration

### Networking (choose before cluster creation)
| Option | Use when |
|---|---|
| Azure CNI Overlay | Default — no VNet IP exhaustion, best for most workloads |
| Azure CNI | Need pod IPs routable from on-premises |
| Kubenet | Small clusters, cost-sensitive dev/test only |

- Enable **Cilium** dataplane for network policies and performance
- Configure **egress** via Azure Firewall or NAT Gateway

### API server access
- Use **private cluster** for production (API server not public)
- Enable **Authorised IP ranges** for non-private clusters

## Recommended cluster configuration
```bash
az aks create \
  --resource-group <rg> \
  --name <cluster> \
  --sku Automatic \
  --network-plugin azure \
  --network-plugin-mode overlay \
  --network-dataplane cilium \
  --enable-oidc-issuer \
  --enable-workload-identity \
  --enable-managed-identity \
  --node-resource-group <node-rg> \
  --zones 1 2 3 \
  --tier Standard
```

## Security standards
- Enable **Workload Identity** — never use pod-level service principal secrets
- Enable **Azure Policy** add-on — restrict privileged containers
- Use **Secrets Store CSI Driver** for Key Vault integration
- Set `securityContext.runAsNonRoot: true` on all containers

## Observability
```bash
# Enable Managed Prometheus + Container Insights
az aks enable-addons --addons monitoring --name <cluster> --resource-group <rg>
az aks update --name <cluster> --resource-group <rg> --enable-azure-monitor-metrics
```

Follow `instructions/azure-aks.instructions.md` for full manifest conventions.
