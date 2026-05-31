---
name: dotnet-upgrade
description: Upgrades .NET solutions to a newer target framework (e.g., net6 → net8, net8 → net9, .NET Framework → .NET 8+). Handles breaking changes, package updates, API replacements, and produces a migration report. Use when asked to "upgrade .NET version", "migrate from .NET Framework", "move to .NET 9", or "modernise legacy code".
---

# .NET Upgrade

Upgrade target framework safely with a tracked, reversible migration.

## Trigger phrases
- "upgrade to .NET 9"
- "migrate from .NET Framework to .NET 8"
- "move from net6 to net8"
- "modernise this legacy app"

## Workflow

### 1. Baseline
```bash
git status                          # ensure clean tree
dotnet build /warnaserror           # capture current warnings
dotnet test                         # capture passing tests
```
Create branch: `upgrade/net<from>-to-net<to>`

### 2. Install upgrade assistant
```bash
dotnet tool install --global upgrade-assistant
upgrade-assistant upgrade <solution.sln>
```

For interactive guidance, also install:
```bash
dotnet tool install --global Microsoft.DotNet.UpgradeAssistant
```

### 3. Update target framework
In each `.csproj`:
```xml
<TargetFramework>net9.0</TargetFramework>
```

For libraries, prefer multi-targeting:
```xml
<TargetFrameworks>net8.0;net9.0</TargetFrameworks>
```

### 4. Update packages
```bash
dotnet list package --outdated
dotnet add package <Pkg> --version <new>
```

Prioritise upgrading: `Microsoft.*`, `EntityFrameworkCore`, `Serilog`, test frameworks.

### 5. Handle breaking changes
Common areas:
- **Newtonsoft.Json → System.Text.Json** (different default behaviour for property casing, polymorphism)
- **ASP.NET Core middleware order** changes between major versions
- **Minimal hosting model** for net6+ (`Program.cs` no longer has `Startup`)
- **EF Core query translation** stricter in newer versions

Check release notes:
- https://learn.microsoft.com/dotnet/core/compatibility/<version>

### 6. Verify
```bash
dotnet build /warnaserror   # zero new warnings vs baseline
dotnet test                 # all tests pass
```

### 7. Migration report
Save to `.dotnet/upgrade-report.md`:
```markdown
# Upgrade Report
From: net6.0 → To: net9.0

## Packages updated
| Package | Old | New |
...

## Breaking changes addressed
- ...

## Manual changes required
- ...

## Test results
- Before: ✅ 245 passed
- After:  ✅ 245 passed
```

⛔ Do not merge until all warnings/tests match or improve over baseline.
