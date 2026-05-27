---
name: scaffold
description: Scaffolds a new component, service, or project for a specified domain. Use this skill when asked to scaffold, bootstrap, generate, create a new project, create a new service, or stub out a new feature. Supports azure, dotnet, and python domains.
---

Scaffold a new component following domain conventions.

## Usage
Format: `<domain> <type> <name>`

Examples:
- `azure bicep storage-account` → generates Bicep module + param file
- `dotnet api WeatherService` → generates ASP.NET Core minimal API + tests
- `python fastapi users-router` → generates FastAPI router + Pydantic models + tests

## Steps
1. Parse domain, type, and name from the input
2. Load `instructions/<domain>.instructions.md` for conventions
3. Check `tools/<domain>/` for a scaffold script — prefer running it over generating manually
4. Generate files following the domain's structure and naming rules
5. Print a tree of created files and suggested next steps

## Defaults per domain
- **azure**: Bicep with modules, param file, README
- **dotnet**: Clean architecture slice, xUnit test class, registration snippet
- **python**: Router file, Pydantic v2 schema, pytest fixture, `__init__.py`
