---
name: dotnet-blazor
description: Builds Blazor UI components and full applications using Blazor Web App (.NET 8+) with server, WebAssembly, or auto render modes. Covers component patterns, state management, and interop. Use when asked to "create a Blazor component", "build a Blazor page", "add interactive UI in .NET", or "convert from Razor Pages to Blazor".
---

# .NET Blazor

Build Blazor components and pages following Blazor Web App (.NET 8+) patterns.

## Trigger phrases
- "create a Blazor component"
- "build a Blazor page"
- "add interactive UI in .NET"
- "convert from Razor Pages to Blazor"

## Choose render mode

| Mode | Use when |
|---|---|
| **Static SSR** (default) | Marketing pages, forms with full page reloads |
| **InteractiveServer** | Internal tools, no offline support needed, low latency to server |
| **InteractiveWebAssembly** | Public apps, offline support, heavy client-side logic |
| **InteractiveAuto** | Best of both — server-first then download WASM |

Set per-component:
```razor
@rendermode InteractiveServer
```

Set per-page in App.razor:
```razor
<Routes @rendermode="InteractiveAuto" />
```

## Component Rules

### Use `<Component Param="@value" />` always
Never use HTML-style passing of complex types as strings.

### Cancellation
`OnInitializedAsync` should respect `ComponentBase.DisposeAsync`:
```razor
@implements IAsyncDisposable

@code {
    private CancellationTokenSource _cts = new();

    protected override async Task OnInitializedAsync()
    {
        _data = await Service.LoadAsync(_cts.Token);
    }

    public async ValueTask DisposeAsync()
    {
        _cts.Cancel();
        _cts.Dispose();
        await Task.CompletedTask;
    }
}
```

### State containers (not singletons)
For shared state across components, use scoped `StateContainer` services with `OnChange` event:
```csharp
public class CartState
{
    private List<CartItem> _items = [];
    public event Action? OnChange;
    public IReadOnlyList<CartItem> Items => _items;
    public void Add(CartItem item) { _items.Add(item); OnChange?.Invoke(); }
}
```

In component: subscribe in `OnInitialized`, unsubscribe in `Dispose`.

### Forms — use EditForm + DataAnnotations OR FluentValidation
```razor
<EditForm Model="@_model" OnValidSubmit="HandleSubmit">
    <DataAnnotationsValidator />
    <ValidationSummary />
    <InputText @bind-Value="_model.Email" />
    <button type="submit">Save</button>
</EditForm>
```

## Performance

- Use `@key` on list items to preserve component state across re-renders
- Implement `ShouldRender()` for pure-display components that re-render often
- Use `Virtualize` component for lists > 50 items
- For WASM: lazy-load assemblies via `BlazorWebAssemblyLoadAssembliesIntoRuntime`

## Interop with JS
```csharp
@inject IJSRuntime JS

await JS.InvokeVoidAsync("scrollToTop");
```

Module-based pattern (preferred for non-trivial JS):
```csharp
var module = await JS.InvokeAsync<IJSObjectReference>("import", "./Pages/MyPage.razor.js");
await module.InvokeVoidAsync("doSomething");
```

Follow `instructions/dotnet.instructions.md` for code style and async patterns.
