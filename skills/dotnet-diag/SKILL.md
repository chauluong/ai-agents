---
name: dotnet-diag
description: Diagnoses .NET application performance, memory issues, GC pressure, and runtime problems using dotnet-counters, dotnet-trace, dotnet-dump, and PerfView. Use when asked to "diagnose performance", "find memory leak", "why is my app slow", "high CPU usage", or "analyse production dump".
---

# .NET Diagnostics

Diagnose runtime issues using dotnet diagnostic tools without restarting the process.

## Trigger phrases
- "why is my .NET app slow"
- "find the memory leak"
- "high CPU in production"
- "diagnose this dump file"
- "analyse GC pressure"

## Triage flow

### 1. Identify symptom category
| Symptom | First tool |
|---|---|
| High CPU | `dotnet-counters` (Process.Runtime.cpu-usage) |
| High memory / leak | `dotnet-counters` (Process.Runtime.gc-heap-size, gen-*-size) |
| Slow requests | `dotnet-trace` collect, then PerfView |
| Crash / hang | `dotnet-dump collect` |
| Lock contention | `dotnet-counters` (monitor-lock-contention-count) |

### 2. Install tools (once)
```bash
dotnet tool install --global dotnet-counters
dotnet tool install --global dotnet-trace
dotnet tool install --global dotnet-dump
dotnet tool install --global dotnet-gcdump
```

### 3. Live monitoring (no restart)
```bash
# Find PID
dotnet-counters ps

# Monitor key counters
dotnet-counters monitor -p <pid> --counters System.Runtime,Microsoft.AspNetCore.Hosting
```

### 4. Capture trace
```bash
# CPU + GC trace (30s)
dotnet-trace collect -p <pid> --duration 00:00:30 --profile cpu-sampling

# Open in PerfView or speedscope.app
```

### 5. Capture heap dump
```bash
# Full process dump
dotnet-dump collect -p <pid>

# GC-only dump (smaller, faster)
dotnet-gcdump collect -p <pid>
```

Analyse with:
```bash
dotnet-dump analyze <file.dmp>
# > clrthreads
# > dumpheap -stat
# > gcroot <address>
```

## Common findings

| Pattern | Likely cause |
|---|---|
| Gen2 heap growing unbounded | Cached objects never evicted, static collections |
| High allocation rate, low retention | Hot path creating strings / closures — look for LINQ in hot paths |
| Many `System.Threading.Thread` instances | `Task.Run` overuse or blocking async (`.Result` / `.Wait()`) |
| CPU pegged at 100% on one core | Tight loop, missing `await Task.Yield()` in CPU-bound async |

Follow `instructions/dotnet.instructions.md` async rules to prevent these issues at code-review time.
