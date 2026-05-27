---
applyTo: "**/*.py,**/pyproject.toml"
---

# Python Instructions

## Environment & Packaging
- Use `uv` for virtual environments and package management
- Define all dependencies in `pyproject.toml` with version pins
- Never commit `.venv/` or `__pycache__/`

## Code Style
- Python 3.11+; use `match` statements, `Self` type, `tomllib`
- Type hints on all function signatures
- `ruff` for linting and formatting (replaces black + flake8 + isort)
- Max line length: 100

## Testing
- `pytest` with `pytest-asyncio` for async tests
- Use `httpx.AsyncClient` for FastAPI integration tests
- Fixtures in `conftest.py`; scope appropriately

## AI / Anthropic SDK
- Enable prompt caching on all system prompts (`cache_control` breakpoint)
- Use streaming for responses > 1000 tokens
- Always pass `max_tokens`
- Store API keys in environment variables; load with `python-dotenv` in dev
