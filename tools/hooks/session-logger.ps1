# Shared hook: logs a session summary of all files touched
# Used by: .claude/settings.json (Stop hook) + .github/hooks/session-logger/hooks.json (Copilot)

$logDir  = $env:LOG_DIR ?? "logs/sessions"
$logFile = ".claude\change-log.jsonl"

New-Item -ItemType Directory -Force -Path $logDir | Out-Null

if (-not (Test-Path $logFile)) {
    Write-Host "No changes recorded this session." -ForegroundColor Gray
    exit 0
}

$entries = Get-Content $logFile | ForEach-Object {
    $_ | ConvertFrom-Json -ErrorAction SilentlyContinue
} | Where-Object { $_ }

if ($entries.Count -eq 0) { exit 0 }

Write-Host "`n=== Session Summary ===" -ForegroundColor Cyan
$entries | Group-Object tool | ForEach-Object {
    Write-Host "  [$($_.Name)] $($_.Count) operation(s)" -ForegroundColor White
    $_.Group | ForEach-Object { Write-Host "    - $($_.path)" }
}

# Write session summary JSON
$summary = @{
    timestamp = (Get-Date -Format "o")
    operations = $entries.Count
    files = ($entries | Select-Object -ExpandProperty path -Unique)
} | ConvertTo-Json
$summaryFile = Join-Path $logDir "session-$(Get-Date -Format 'yyyyMMdd-HHmmss').json"
$summary | Set-Content $summaryFile

Write-Host "`nSummary saved to $summaryFile" -ForegroundColor Gray
exit 0
