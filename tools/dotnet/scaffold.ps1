# Scaffolds a new .NET solution with clean architecture
# Usage: .\scaffold.ps1 -Name MyApp -Output ./src
param(
    [Parameter(Mandatory)][string]$Name,
    [string]$Output = "."
)

$root = Join-Path $Output $Name
New-Item -ItemType Directory -Force -Path $root | Out-Null

Push-Location $root

dotnet new sln -n $Name
foreach ($layer in @("Domain", "Application", "Infrastructure", "Api")) {
    dotnet new classlib -n "$Name.$layer" -o "src/$Name.$layer" --framework net9.0
    dotnet sln add "src/$Name.$layer"
}
dotnet new xunit -n "$Name.Tests" -o "tests/$Name.Tests" --framework net9.0
dotnet sln add "tests/$Name.Tests"

# Wire up references
dotnet add "src/$Name.Application" reference "src/$Name.Domain"
dotnet add "src/$Name.Infrastructure" reference "src/$Name.Application"
dotnet add "src/$Name.Api" reference "src/$Name.Application"
dotnet add "tests/$Name.Tests" reference "src/$Name.Application" "src/$Name.Domain"

Write-Host "Solution $Name scaffolded at $root" -ForegroundColor Green
Pop-Location
