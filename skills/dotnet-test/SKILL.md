---
name: dotnet-test
description: Runs unit and integration tests for a .NET solution using xUnit, MSTest, or NUnit. Generates coverage reports and identifies test gaps. Use when asked to "run tests", "check coverage", "verify changes", "test the build", or "run dotnet test". Requires dotnet-build to have completed (build plan Status: Built).
---

# .NET Test

Execute the test suite, measure coverage, and report results.

## Trigger phrases
- "run tests"
- "dotnet test"
- "check test coverage"
- "verify changes"
- "test the build"

## Prerequisites
- `.dotnet/build-plan.md` shows `Status: Built ✅`
- Test projects present under `tests/`

⛔ If build plan is not `Built`, stop and run `dotnet-build` first.

## Workflow

### 1. Discover test projects
```bash
dotnet sln list | grep -i test
```

### 2. Run tests with coverage
```bash
dotnet test --no-build --configuration Release \
  --collect:"XPlat Code Coverage" \
  --results-directory ./TestResults \
  --logger "trx;LogFileName=test-results.trx"
```

### 3. Generate coverage report
```bash
dotnet tool install --global dotnet-reportgenerator-globaltool
reportgenerator \
  -reports:"TestResults/**/coverage.cobertura.xml" \
  -targetdir:"TestResults/coverage-report" \
  -reporttypes:"Html;TextSummary"
```

### 4. Analyse results
| Metric | Target |
|---|---|
| Line coverage | ≥ 80% on Application + Domain layers |
| Branch coverage | ≥ 70% |
| Test execution | < 60s for unit tests |

### 5. Report
```markdown
## Test Results
- ✅ Passed: <n>
- ❌ Failed: <n>
- ⏭️ Skipped: <n>
- 📊 Line coverage: <pct>%
- 📊 Branch coverage: <pct>%

## Coverage gaps
- <file>:<line> — uncovered branch
```

Follow `instructions/dotnet-testing.instructions.md` for naming and structure conventions.
