---
name: dotnet-webapi
description: Builds ASP.NET Core Web APIs using minimal APIs or controllers, with OpenAPI, validation, auth, and proper error handling. Use when asked to "create an API endpoint", "add a controller", "build a Web API", "expose REST endpoints", or "add minimal API".
---

# .NET Web API

Generate production-quality ASP.NET Core API endpoints following modern minimal API patterns.

## Trigger phrases
- "create an API endpoint"
- "add a controller for X"
- "build a Web API for X"
- "expose REST endpoints"

## Endpoint Style
Prefer **Minimal APIs** for new code. Use Controllers only when:
- Endpoint count > 30 (organisational complexity)
- Action filters required across many endpoints
- Server-side views with MVC needed

## Required per Endpoint

### 1. Route group with tags
```csharp
var users = app.MapGroup("/api/v1/users")
    .WithTags("Users")
    .WithOpenApi();
```

### 2. Validation via FluentValidation
```csharp
.AddEndpointFilter<ValidationFilter<CreateUserRequest>>()
```

### 3. Typed results
```csharp
users.MapPost("/", async (CreateUserRequest req, IUserService svc, CancellationToken ct)
    => TypedResults.Created($"/api/v1/users/{user.Id}", user))
    .Produces<UserResponse>(StatusCodes.Status201Created)
    .ProducesValidationProblem();
```

### 4. Async + CancellationToken
Every handler must be `async` and accept `CancellationToken ct`.

## Cross-cutting setup

### Error handling
Register `IExceptionHandler` for domain exceptions. Map to ProblemDetails:
```csharp
builder.Services.AddExceptionHandler<DomainExceptionHandler>();
builder.Services.AddProblemDetails();
```

### Auth
JWT bearer auth as default:
```csharp
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(opt => { ... });
```

### OpenAPI
Use `Microsoft.AspNetCore.OpenApi` (built-in for .NET 9+):
```csharp
builder.Services.AddOpenApi();
app.MapOpenApi();
```

### Versioning
URL-based (`/api/v1/...`) — simplest and explicit.

Follow `instructions/dotnet.instructions.md` for project structure and async rules.
