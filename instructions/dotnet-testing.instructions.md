---
applyTo: "**/*.Tests/**,**/*Tests.cs,**/*Spec.cs"
---

# .NET Testing Instructions

## Stack
- xUnit for all tests
- Moq for mocking interfaces
- FluentAssertions for readable assertions
- `WebApplicationFactory<Program>` for integration tests

## Naming Convention
`MethodName_Scenario_ExpectedResult`
Example: `CreateOrder_WhenStockIsEmpty_ThrowsInsufficientStockException`

## Unit Tests
- One assertion concept per test (can have multiple `Should()` chains on same subject)
- Mock only direct dependencies — not transitive ones
- Use `[Theory]` + `[InlineData]` for parameterized cases

## Integration Tests
- Use a real test database (Docker via Testcontainers, or SQLite for simplicity)
- Reset state between tests with `IAsyncLifetime`
- Test the full HTTP stack: request → controller → service → DB → response
- Never mock `HttpContext` or `IConfiguration` in integration tests

## Test Projects
```
tests/
  MyApp.Unit.Tests/       ← fast, no I/O
  MyApp.Integration.Tests/← real DB, real HTTP
  MyApp.Architecture.Tests/← NetArchTest rules
```
