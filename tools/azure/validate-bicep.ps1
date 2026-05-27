# Validates a Bicep template against a resource group
# Usage: .\validate-bicep.ps1 -Template infra/main.bicep -ResourceGroup my-rg -ParamFile infra/main.bicepparam
param(
    [Parameter(Mandatory)][string]$Template,
    [Parameter(Mandatory)][string]$ResourceGroup,
    [string]$ParamFile
)

$args = @("deployment", "group", "validate",
    "--resource-group", $ResourceGroup,
    "--template-file", $Template)

if ($ParamFile) { $args += "--parameters", "@$ParamFile" }

Write-Host "Validating $Template against $ResourceGroup..." -ForegroundColor Cyan
az @args
