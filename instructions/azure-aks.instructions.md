---
applyTo: "**/k8s/**,**/kubernetes/**,**/*.yaml,**/*.yml"
---

# Azure Kubernetes Service (AKS) Instructions

## Cluster Standards
- Enable OIDC issuer and Workload Identity on all clusters
- Use Azure CNI Overlay for networking (not kubenet)
- Enable Azure Policy add-on and restrict privileged containers
- Use system node pool (taint: `CriticalAddonsOnly`) + separate user node pools

## Workload Identity
- Never use pod-level service principal secrets
- Use Workload Identity Federation: annotate service accounts, create federated credentials
- Assign least-privilege Azure roles to managed identities

## Manifest Conventions
- Always set `resources.requests` and `resources.limits`
- Always set `readinessProbe` and `livenessProbe`
- Use `PodDisruptionBudget` for all production workloads
- Set `securityContext.runAsNonRoot: true` on all containers

## Deployment Flow
```
az aks get-credentials --resource-group <rg> --name <cluster>
kubectl apply --dry-run=client -f manifests/
kubectl apply -f manifests/
kubectl rollout status deployment/<name>
```
