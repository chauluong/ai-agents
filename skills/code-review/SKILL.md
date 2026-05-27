---
name: code-review
description: Performs a structured code review on specified files or recent changes. Use this skill when asked to review, check, audit, or give feedback on code. Reports findings grouped by severity with file path and line number.
---

Review the specified code or recent changes.

## Review Checklist

### 🔴 Critical (must fix)
- Logic errors, incorrect conditionals, off-by-one bugs
- Security issues: injection risks, exposed secrets, overly broad permissions
- Data loss risks: missing transactions, unhandled errors in write paths

### 🟡 Warning (should fix)
- Missing null/error handling
- Blocking async calls (`.Result`, `.Wait()`)
- N+1 queries or missing pagination
- Hardcoded values that should be config

### 🔵 Suggestion (consider)
- Naming clarity
- Missing tests for new behaviour
- Opportunities to simplify or extract reusable logic

## Output Format
For each finding:
```
[SEVERITY] path/to/file.cs:42
Description of the issue and recommended fix.
```

Load the relevant `instructions/<domain>.instructions.md` to apply domain-specific standards.
