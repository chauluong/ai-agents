# Plugin: Python Development

Bundles all Python agents, instructions, and skills into one installable unit.

## Included Agents
| Agent | File | Description |
|---|---|---|
| Python & FastAPI Developer | `.github/agents/python-fastapi.agent.md` | FastAPI, data science, AI integrations |
| python (Claude) | `.claude/agents/python.md` | General Python tasks via Claude Code |

## Included Instructions (shared)
- `instructions/python.instructions.md` — core Python conventions
- `instructions/python-fastapi.instructions.md` — FastAPI routing, Pydantic v2

## Included Skills
- `skills/code-review/` — Python code review with ruff/pytest conventions
- `skills/scaffold/` — FastAPI router and project scaffolding

## Shared Tools
- `tools/python/setup-env.ps1` — bootstrap a new Python project with uv

## Installation
Copy or reference agent files from `.github/agents/` and `.claude/agents/`.
