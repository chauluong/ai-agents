---
applyTo: "**/routers/**,**/api/**,**/main.py"
---

# FastAPI Instructions

## Project Layout
```
src/<app>/
  main.py           ← app factory, mounts routers
  routers/
    users.py
    items.py
  models/           ← Pydantic v2 schemas
  services/         ← business logic
  db/               ← SQLAlchemy / async session
```

## Route Conventions
- Use `Annotated` for dependency injection and query param validation
- Set `response_model` and `status_code` on every route decorator
- Return Pydantic models — never raw dicts from endpoints
- Group related routes in a `APIRouter` with a `prefix` and `tags`

## Error Handling
- Raise `HTTPException` with specific status codes and detail messages
- Register custom exception handlers in `main.py` for domain exceptions
- Never let unhandled exceptions bubble to the client in production

## Performance
- Use `async def` for all routes that do any I/O
- Use `asyncpg` + SQLAlchemy async for database access
- Add `Cache-Control` headers on read-heavy endpoints
