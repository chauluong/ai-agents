# Agent Conventions

This document defines the standards for all agent files in this repository.

## File Format

### GitHub Copilot agents (`.github/agents/*.agent.md`)
```yaml
---
name: Human Readable Name        # required, title-cased
description: 'Single-quoted description explaining when to invoke this agent.'
argument-hint: What to pass when invoking the agent
tools: ['codebase', 'terminal', 'read', 'edit', 'search']
model: 'claude-sonnet-4-5'
---
```

### Claude Code agents (`.claude/agents/*.md`)
```yaml
---
name: kebab-case-name
description: Plain description of the agent's domain and trigger condition.
tools:
  - Bash
  - Read
  - Write
  - Edit
  - Glob
  - Grep
---
```

## Naming Rules
- File names: `lower-case-with-hyphens`
- Copilot files: must end in `.agent.md`
- Claude files: end in `.md`
- Descriptions: explain **when to invoke**, not just what the agent does

## Shared Resources
All agents should reference shared resources rather than duplicating content:
- Domain instructions → `instructions/<domain>.instructions.md`
- Shared scripts → `tools/<domain>/` or `tools/hooks/`
- Hooks wiring → `.claude/settings.json` (Claude) / `.github/hooks/*/hooks.json` (Copilot)

## Adding a New Agent
Run `/add-agent <domain> <name> "<description>"` — it creates both Claude and Copilot files,
updates `registry.json`, and stubs the instruction file.
