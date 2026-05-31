---
name: dotnet-ef
description: Designs Entity Framework Core data access — DbContexts, entities, migrations, query optimisation, and repository patterns. Use when asked to "add a database", "create EF migration", "design entities", "fix N+1 query", or "set up DbContext".
---

# .NET Entity Framework Core

Design data access following EF Core best practices and avoid common performance traps.

## Trigger phrases
- "add a database to my .NET app"
- "create an EF Core migration"
- "design entity model"
- "fix N+1 query problem"
- "set up DbContext"

## DbContext Setup

```csharp
services.AddDbContextPool<AppDbContext>(opt =>
    opt.UseNpgsql(connStr, npg => npg.EnableRetryOnFailure())
       .UseSnakeCaseNamingConvention());
```

Use **`AddDbContextPool`** not `AddDbContext` for high-throughput APIs (~30% perf gain).

## Entity Rules

- Use `record` types only for DTOs, NOT entities (entities need EF tracking)
- Configure relationships explicitly via `IEntityTypeConfiguration<T>` (one file per entity)
- Always set `OnDelete(DeleteBehavior.Restrict)` for foreign keys unless cascade is intentional
- Use `RowVersion` for optimistic concurrency on aggregate roots

## Query Rules

### Always use AsNoTracking for reads
```csharp
return await _db.Users.AsNoTracking().Where(...).ToListAsync(ct);
```

### Project explicitly — never return entity graphs from repositories
```csharp
return await _db.Orders
    .Where(o => o.UserId == userId)
    .Select(o => new OrderDto(o.Id, o.Total, o.CreatedAt))
    .ToListAsync(ct);
```

### Avoid N+1 — use `Include` or projection
```csharp
// Bad
foreach (var u in users) { var orders = await _db.Orders.Where(o => o.UserId == u.Id).ToListAsync(); }

// Good
var users = await _db.Users.Include(u => u.Orders).ToListAsync();
```

## Migrations

### Generate
```bash
dotnet ef migrations add <Name> --project src/Infrastructure --startup-project src/Api
```

### Review BEFORE applying
- Check generated SQL with `--verbose` flag
- Never apply destructive operations (drop column, rename table) without a backfill strategy
- Use `migrationBuilder.Sql(...)` for data migrations alongside schema changes

### Apply
```bash
dotnet ef database update --project src/Infrastructure --startup-project src/Api
```

⛔ Never use `EnsureCreated()` in production code paths.

Follow `instructions/dotnet.instructions.md` for repository patterns and clean architecture references.
