# Plugin: .NET Development

Bundles all .NET agents, instructions, and skills into one installable unit.

## Included Agents
| Agent | File | Description |
|---|---|---|
| .NET Architect | `.github/agents/dotnet-architect.agent.md` | Architecture, scaffolding, EF Core |
| dotnet (Claude) | `.claude/agents/dotnet.md` | General .NET tasks via Claude Code |

## Included Instructions (shared)
- `instructions/dotnet.instructions.md` — core .NET / C# conventions
- `instructions/dotnet-testing.instructions.md` — xUnit, Moq, FluentAssertions

## Included Skills
- `skills/code-review/` — .NET code review with C# conventions
- `skills/scaffold/` — Clean architecture solution scaffolding

## Shared Tools
- `tools/dotnet/scaffold.ps1` — bootstrap a clean architecture solution

## Installation
Copy or reference agent files from `.github/agents/` and `.claude/agents/`.
