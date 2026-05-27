---
name: azure-ai
description: Implements Azure AI services including Azure OpenAI, AI Search, Speech, and Document Intelligence. Use when asked to "add AI to my Azure app", "use Azure OpenAI", "set up AI Search", "integrate speech recognition", or any Azure AI service integration request.
---

# Azure AI Services

Integrate Azure AI capabilities into applications using Azure OpenAI, AI Search, Speech, and Document Intelligence.

## Trigger phrases
- "add AI to my Azure app"
- "use Azure OpenAI"
- "set up AI Search / vector search"
- "integrate speech / transcription"
- "extract data from documents"

## Azure OpenAI

### Setup
```bash
# Create Azure OpenAI resource
az cognitiveservices account create \
  --name <name> --resource-group <rg> \
  --kind OpenAI --sku S0 --location eastus

# Deploy a model
az cognitiveservices account deployment create \
  --name <name> --resource-group <rg> \
  --deployment-name gpt-4o \
  --model-name gpt-4o --model-version "2024-11-20" \
  --model-format OpenAI --sku-capacity 10 --sku-name Standard
```

### Python SDK
```python
from openai import AzureOpenAI
from azure.identity import DefaultAzureCredential, get_bearer_token_provider

token_provider = get_bearer_token_provider(DefaultAzureCredential(), "https://cognitiveservices.azure.com/.default")
client = AzureOpenAI(azure_endpoint=os.environ["AZURE_OPENAI_ENDPOINT"], azure_ad_token_provider=token_provider, api_version="2024-10-21")
```
Always use **Managed Identity** (`DefaultAzureCredential`) — never API keys in production.

## Azure AI Search

### Setup
```bash
az search service create --name <name> --resource-group <rg> --sku basic
```

### Key capabilities
- **Full-text search** — BM25 relevance scoring
- **Vector search** — semantic/hybrid with embeddings
- **Integrated vectorisation** — auto-embed with Azure OpenAI

### Python SDK
```python
from azure.search.documents import SearchClient
from azure.identity import DefaultAzureCredential
client = SearchClient(endpoint, index_name, DefaultAzureCredential())
results = client.search(search_text="query", vector_queries=[...])
```

## Azure Speech
```python
import azure.cognitiveservices.speech as speechsdk
config = speechsdk.SpeechConfig(endpoint=f"wss://{region}.stt.speech.microsoft.com/...", auth_token=token)
recognizer = speechsdk.SpeechRecognizer(speech_config=config)
result = recognizer.recognize_once()
```

## Document Intelligence
```python
from azure.ai.documentintelligence import DocumentIntelligenceClient
client = DocumentIntelligenceClient(endpoint, DefaultAzureCredential())
poller = client.begin_analyze_document("prebuilt-invoice", url_source=doc_url)
result = poller.result()
```

## Security
- Always use Managed Identity — no API keys in code or config
- Assign `Cognitive Services OpenAI User` role to app identity
- Assign `Search Index Data Reader` for AI Search queries
