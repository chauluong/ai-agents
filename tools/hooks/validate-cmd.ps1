# Shared hook: validates tool calls before execution
# Used by: .claude/settings.json (Claude Code) + .github/hooks/validate-azure-cmd/hooks.json (Copilot)
# Receives tool input via CLAUDE_TOOL_INPUT env var (JSON) for Claude Code

$toolInput = $env:CLAUDE_TOOL_INPUT | ConvertFrom-Json -ErrorAction SilentlyContinue
$cmd = if ($toolInput) { $toolInput.command } else { $env:TOOL_COMMAND }
if (-not $cmd) { exit 0 }

# Block destructive Azure commands without --yes flag
if ($cmd -match "az\s+.*(delete|remove|purge)" -and $cmd -notmatch "--yes") {
    Write-Error "BLOCKED: Destructive Azure command requires --yes flag: $cmd"
    exit 1
}

# Warn on subscription context switches
if ($cmd -match "az\s+account\s+set") {
    Write-Host "[HOOK] Switching Azure subscription: $cmd" -ForegroundColor Yellow
}

exit 0
