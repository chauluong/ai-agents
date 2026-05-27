---
name: Code Review
description: Performs a structured code review on the selected files or recent changes
---

Review the specified code for:

1. **Correctness** — logic errors, null handling, edge cases
2. **Security** — injection risks, exposed secrets, overly broad permissions
3. **Performance** — N+1 queries, blocking async calls, unnecessary allocations
4. **Conventions** — naming, formatting, patterns defined in `instructions/`

Output findings as a markdown checklist grouped by severity:
- 🔴 Critical — must fix before merge
- 🟡 Warning — should fix
- 🔵 Suggestion — consider improving

Include file path and line number for every finding.
