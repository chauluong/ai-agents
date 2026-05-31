---
name: dotnet-build
description: Builds a .NET solution, restores packages, runs analyzers, and validates the build plan. Use when asked to "build the solution", "compile", "restore packages", or "check for warnings". Marks build plan as Built so dotnet-test can run. Runs AFTER dotnet-scaffold and BEFORE dotnet-test.
---

# .NET Build

Build the solution cleanly, surface warnings, and mark the build plan as `Built`.

## Trigger phrases
- "build the solution"
- "dotnet build"
- "compile the project"
- "restore packages"
- "check for analyzer warnings"

## Prerequisites
- `.dotnet/build-plan.md` exists with `Status: Draft` or no plan needed for existing solution
- `dotnet --version` returns a supported SDK version

## Workflow

### 1. Restore
```bash
dotnet restore --locked-mode
```
If lock file is missing, run `dotnet restore` once then commit `packages.lock.json`.

### 2. Build with warnings as errors
```bash
dotnet build --no-restore --configuration Release /warnaserror
```

### 3. Run analyzers
Required analyzer packages (add if missing):
- `Microsoft.CodeAnalysis.NetAnalyzers`
- `StyleCop.Analyzers`
- `Roslynator.Analyzers` (optional)

### 4. Report findings
For each warning/error:
```
[SEVERITY] <file>(<line>,<col>): <ruleId>: <message>
```

### 5. Update plan
On clean build:
```
Status: Built ✅
Built at: <timestamp>
SDK version: <version>
Warnings: <count>
```

⛔ If any analyzer error remains, do NOT mark as Built. Surface findings and stop.
