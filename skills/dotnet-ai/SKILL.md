---
name: dotnet-ai
description: Integrates LLMs and AI capabilities into .NET applications using Microsoft.Extensions.AI, Semantic Kernel, or the Anthropic SDK. Covers chat completion, embeddings, tool calling, RAG, and streaming. Use when asked to "add AI to my .NET app", "use Claude in C#", "build a chatbot in .NET", or "implement RAG".
---

# .NET AI Integration

Add LLM-powered features to .NET applications using the official Microsoft.Extensions.AI abstractions.

## Trigger phrases
- "add AI to my .NET app"
- "integrate Claude in C#"
- "build a chatbot in .NET"
- "implement RAG in .NET"
- "use Semantic Kernel"

## Choose the right library

| Goal | Library |
|---|---|
| Provider-agnostic chat / embeddings | **Microsoft.Extensions.AI** (recommended default) |
| Complex agent orchestration, plugins | **Semantic Kernel** |
| Anthropic-specific features (extended thinking, prompt caching) | **Anthropic.SDK** (Claudia) |
| Azure OpenAI only | `Azure.AI.OpenAI` |

## Setup with Microsoft.Extensions.AI

```bash
dotnet add package Microsoft.Extensions.AI
dotnet add package Microsoft.Extensions.AI.OpenAI  # or AzureAIInference, Ollama, etc.
```

```csharp
IChatClient client = new ChatClientBuilder(
        new OpenAIClient(apiKey).AsChatClient("gpt-4o-mini"))
    .UseFunctionInvocation()
    .UseLogging()
    .Build();

builder.Services.AddSingleton(client);
```

## Patterns

### Streaming chat
```csharp
await foreach (var update in client.GetStreamingResponseAsync(messages, ct: ct))
    Console.Write(update);
```

### Tool calling
```csharp
[Description("Look up customer by email")]
async Task<Customer?> LookupCustomer(string email) => ...;

var tools = AIFunctionFactory.Create(LookupCustomer);
var response = await client.GetResponseAsync(prompt,
    new ChatOptions { Tools = [tools] });
```

### Embeddings + vector search
```csharp
IEmbeddingGenerator<string, Embedding<float>> embed = ...;
var vector = await embed.GenerateEmbeddingAsync(text);
// Store in Qdrant, Azure AI Search, pgvector, etc.
```

## Production hardening

### Always set
- `MaxTokens` (never rely on provider defaults)
- `Temperature` (0.0–0.3 for extraction, 0.7+ for creative)
- `CancellationToken` on every call
- Retry policy via `IHttpClientFactory` + Polly

### Cost & latency
- Enable **prompt caching** on long system prompts (Anthropic SDK: `CacheControl.Ephemeral`)
- Stream responses > 1000 tokens
- Track token usage via `OnUsage` callback → emit OpenTelemetry metrics

### Safety
- Never log full prompts containing user PII
- Add content filtering on input AND output
- Set per-user rate limits at the API layer

Follow `instructions/dotnet.instructions.md` for async patterns and DI conventions.
