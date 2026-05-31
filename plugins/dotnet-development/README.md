# Plugin: .NET Development

Bundles all .NET agents, skills, instructions, and hooks into one installable unit.

## Build Pipeline Skills
The core .NET skills follow a structured pipeline:

```
dotnet-scaffold → dotnet-build → dotnet-test
```
Always run in order. `dotnet-test` will not proceed without a `Built` plan from `dotnet-build`.

## All Skills
| Skill | Trigger | Description |
|---|---|---|
| `dotnet-scaffold` | "create a new .NET project" | Scaffold solution, projects, NuGet packs, build plan |
| `dotnet-build` | "build the solution" | Restore, build with analyzers, mark plan as Built |
| `dotnet-test` | "run tests" | Run xUnit/MSTest/NUnit + coverage report |
| `dotnet-webapi` | "create an API endpoint" | Minimal API patterns, OpenAPI, validation, auth |
| `dotnet-ef` | "add a database" | EF Core DbContext, entities, migrations, query rules |
| `dotnet-diag` | "why is my app slow" | dotnet-counters, trace, dump, GC analysis |
| `dotnet-upgrade` | "upgrade to .NET 9" | Framework migration with breaking-change handling |
| `dotnet-ai` | "add AI to my .NET app" | Microsoft.Extensions.AI, SK, Anthropic SDK |
| `dotnet-blazor` | "create a Blazor component" | Blazor Web App render modes, state, forms, interop |

## Included Agents
| Agent | File | Description |
|---|---|---|
| .NET Architect | `.github/agents/dotnet-architect.agent.md` | Architecture, scaffolding, EF Core |
| dotnet (Claude) | `.claude/agents/dotnet.md` | General .NET tasks via Claude Code |

## Shared Instructions
- `instructions/dotnet.instructions.md`
- `instructions/dotnet-testing.instructions.md`

## Shared Tools
- `tools/dotnet/scaffold.ps1` — bootstrap clean architecture solution

## Plugin Manifest
`plugin.json` — declares skills, agents, and instructions for plugin-aware tools (Copilot, Cursor, etc.)
