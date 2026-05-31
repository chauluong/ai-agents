---
name: dotnet-scaffold
description: Scaffolds a new .NET solution following clean architecture, sets up projects, references, NuGet packages, and produces a build plan saved to .dotnet/build-plan.md. Use when asked to "create a new .NET project", "scaffold a solution", "start a new C# app", or "set up clean architecture". Always runs BEFORE dotnet-build.
---

# .NET Scaffold

Generate a new .NET solution with the requested architecture and produce a build plan.

## Trigger phrases
- "create a new .NET project"
- "scaffold a clean architecture solution"
- "start a new C# Web API"
- "set up an ASP.NET project"

## Workflow

### 1. Confirm requirements
- Target framework (default: latest LTS — .NET 9)
- Architecture style: clean / vertical-slice / minimal
- Project type: webapi, worker, blazor, library, console

### 2. Generate solution
Use `tools/dotnet/scaffold.ps1` if available, otherwise:
```bash
dotnet new sln -n <Name>
dotnet new <type> -n <Name>.<Project> -o src/<Name>.<Project>
dotnet sln add src/<Name>.<Project>
```

### 3. Apply conventions from instructions
- `instructions/dotnet.instructions.md` for code style, async rules, EF Core
- Enable `<Nullable>enable</Nullable>` and `<ImplicitUsings>enable</ImplicitUsings>`
- Add `.editorconfig` enforcing project conventions

### 4. Set up NuGet packages
Default starter packs:
| Project | Packages |
|---|---|
| Api | `Microsoft.AspNetCore.OpenApi`, `Serilog.AspNetCore`, `FluentValidation.AspNetCore` |
| Application | `MediatR`, `FluentValidation`, `Mapster` |
| Infrastructure | `Microsoft.EntityFrameworkCore`, `Microsoft.EntityFrameworkCore.Design` |
| Tests | `xunit`, `Moq`, `FluentAssertions`, `Microsoft.AspNetCore.Mvc.Testing` |

### 5. Write build plan
Save to `.dotnet/build-plan.md`:
```markdown
# Build Plan
Status: Draft   ← only dotnet-build may set this to Built

## Projects
...

## Test projects
...

## Required NuGet packages
...

## Architecture
...
```

⛔ DO NOT set status to `Built` yourself — that is done by `dotnet-build`.
