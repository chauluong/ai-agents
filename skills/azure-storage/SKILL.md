---
name: azure-storage
description: Configures and uses Azure Blob Storage, Queue Storage, and Azure Data Lake. Use when asked to "store files in Azure", "set up blob storage", "upload to Azure", "configure storage account", or any Azure storage task.
---

# Azure Storage

Configure and use Azure Blob Storage, Queue Storage, and Data Lake Storage.

## Trigger phrases
- "store files in Azure"
- "set up blob storage"
- "upload to Azure Storage"
- "configure storage account"
- "Azure Data Lake"

## Storage Account Setup

```bash
az storage account create \
  --name <name> --resource-group <rg> \
  --sku Standard_LRS --kind StorageV2 \
  --min-tls-version TLS1_2 \
  --allow-blob-public-access false \
  --public-network-access Disabled \
  --enable-hierarchical-namespace false  # set true for Data Lake
```

## Blob Storage

### Python SDK (with Managed Identity)
```python
from azure.storage.blob import BlobServiceClient
from azure.identity import DefaultAzureCredential

client = BlobServiceClient(
    account_url=f"https://{account}.blob.core.windows.net",
    credential=DefaultAzureCredential()
)
container = client.get_container_client("mycontainer")

# Upload
container.upload_blob(name="file.txt", data=data, overwrite=True)

# Download
blob = container.download_blob("file.txt")
content = blob.readall()
```

### RBAC roles
| Role | Use |
|---|---|
| `Storage Blob Data Contributor` | Read + write blobs |
| `Storage Blob Data Reader` | Read-only |
| `Storage Queue Data Contributor` | Read + write queues |

Always assign to **Managed Identity** — never use storage account keys in app code.

## Lifecycle management
```bash
# Auto-tier blobs older than 30 days to Cool, delete after 365
az storage account management-policy create \
  --account-name <name> --resource-group <rg> \
  --policy @lifecycle-policy.json
```

## Security checklist
- [ ] Public blob access disabled
- [ ] Public network access disabled (use Private Endpoint)
- [ ] Minimum TLS 1.2
- [ ] Soft delete enabled for blobs and containers
- [ ] Storage account keys rotated or disabled
- [ ] Diagnostic logs enabled
