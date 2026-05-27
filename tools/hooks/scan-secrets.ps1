# Shared hook: scans modified files for leaked secrets
# Used by: .github/hooks/secrets-scanner/hooks.json (Copilot) + .claude/settings.json (Claude Code)

$scanMode  = $env:SCAN_MODE  ?? "warn"
$scanScope = $env:SCAN_SCOPE ?? "diff"
$logDir    = $env:SECRETS_LOG_DIR ?? "logs/sessions"
$allowList = ($env:SECRETS_ALLOWLIST ?? "") -split "," | Where-Object { $_ }

$patterns = @{
    "AWS Access Key"       = "AKIA[0-9A-Z]{16}"
    "Azure Client Secret"  = "(?i)client.?secret['\"]?\s*[:=]\s*['\"]?[A-Za-z0-9~_\-\.]{30,}"
    "GitHub PAT"           = "gh[pousr]_[A-Za-z0-9_]{36,}"
    "Private Key"          = "-----BEGIN (RSA |EC |OPENSSH )?PRIVATE KEY"
    "Connection String"    = "(?i)(connection.?string|data.?source)['\"]?\s*[:=]\s*['\"]?[^'\"\s]{20,}"
    "Bearer Token"         = "(?i)bearer\s+[A-Za-z0-9\-_\.]{20,}"
    "Generic API Key"      = "(?i)api[_\-]?key['\"]?\s*[:=]\s*['\"]?[A-Za-z0-9]{20,}"
}

$files = if ($scanScope -eq "staged") {
    git diff --cached --name-only 2>$null
} else {
    git diff --name-only 2>$null
}

$files = $files | Where-Object { $_ -and (Test-Path $_) -and -not ($_ -match "\.(lock|png|jpg|gif|ico|woff|ttf|eot)$") }

if (-not $files) {
    Write-Host "✅ No modified files to scan" -ForegroundColor Green
    exit 0
}

$findings = @()
foreach ($file in $files) {
    $content = Get-Content $file -ErrorAction SilentlyContinue
    if (-not $content) { continue }
    foreach ($name in $patterns.Keys) {
        $matches = $content | Select-String -Pattern $patterns[$name]
        foreach ($m in $matches) {
            $skip = $allowList | Where-Object { $m.Line -match $_ }
            if (-not $skip) {
                $findings += [PSCustomObject]@{ File = $file; Line = $m.LineNumber; Pattern = $name }
            }
        }
    }
}

if ($findings.Count -eq 0) {
    Write-Host "✅ No secrets detected in $($files.Count) scanned file(s)" -ForegroundColor Green
    exit 0
}

Write-Host "`n⚠️  Potential secrets detected:" -ForegroundColor Yellow
$findings | Format-Table File, Line, Pattern -AutoSize

New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$logFile = Join-Path $logDir "secrets-$(Get-Date -Format 'yyyyMMdd-HHmmss').jsonl"
$findings | ForEach-Object { $_ | ConvertTo-Json -Compress | Add-Content $logFile }

if ($scanMode -eq "block") {
    Write-Error "Session blocked: secrets detected. Review findings above."
    exit 1
}
exit 0
