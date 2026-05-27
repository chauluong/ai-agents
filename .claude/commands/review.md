Review the code changes in the current working directory or the specified file/path: $ARGUMENTS

Perform a structured review covering:
1. **Correctness** — logic errors, off-by-one, null handling
2. **Security** — injection risks, secrets in code, overly broad permissions
3. **Performance** — N+1 queries, blocking calls, unnecessary allocations
4. **Conventions** — naming, formatting, project-specific patterns from CLAUDE.md

Output findings as a markdown checklist grouped by severity: Critical / Warning / Suggestion.
For each finding include the file path and line number.
