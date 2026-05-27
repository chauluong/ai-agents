---
name: Scaffold Component
description: Scaffolds a new domain component following project conventions
---

Scaffold a new component for the domain and type specified.

Format: `<domain> <type> <name>`
Examples:
- `azure bicep storage-account`
- `dotnet api WeatherService`
- `python fastapi users-router`

Steps:
1. Load the relevant `instructions/<domain>.instructions.md`
2. Use the appropriate `tools/<domain>/` script if one exists
3. Generate files following domain conventions
4. Print a summary of created files and suggested next steps
