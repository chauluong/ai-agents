---
applyTo: "**/*.cs,**/*.csproj,**/*.sln"
---

# .NET / C# Instructions

## Project Structure
- Clean architecture: `Domain`, `Application`, `Infrastructure`, `Api` layers
- Reference direction: Api → Application → Domain (Infrastructure implements Application interfaces)
- Top-level folders: `src/` and `tests/`

## Code Style
- C# 12+: primary constructors, collection expressions, pattern matching
- Enable `<Nullable>enable</Nullable>` and `<ImplicitUsings>enable</ImplicitUsings>`
- Use `record` types for DTOs and value objects
- Never use `var` for non-obvious types; always use `var` for LINQ results

## Async Rules
- All I/O must be async — never `.Result`, `.Wait()`, or `Task.Run` to wrap sync code
- Pass `CancellationToken` through every async method signature
- Use `ConfigureAwait(false)` in library projects

## EF Core
- Always use migrations; never `EnsureCreated` in production
- Use `AsNoTracking()` for read-only queries
- Project queries explicitly — never return `IQueryable` from repositories
