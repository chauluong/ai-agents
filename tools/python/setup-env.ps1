# Sets up a Python project with uv, ruff, and pytest
# Usage: .\setup-env.ps1 -Name my-project -Output ./src
param(
    [Parameter(Mandatory)][string]$Name,
    [string]$Output = "."
)

$root = Join-Path $Output $Name
New-Item -ItemType Directory -Force -Path $root | Out-Null
Push-Location $root

uv init --name $Name
uv venv
uv pip install fastapi uvicorn httpx pydantic ruff pytest pytest-asyncio anthropic

# Create pyproject.toml ruff config
$ruffConfig = @"

[tool.ruff]
line-length = 100
target-version = "py311"

[tool.ruff.lint]
select = ["E", "F", "I", "UP", "B"]

[tool.pytest.ini_options]
asyncio_mode = "auto"
"@
Add-Content -Path "pyproject.toml" -Value $ruffConfig

New-Item -ItemType Directory -Force -Path "src/$Name", "tests" | Out-Null
New-Item -ItemType File -Force -Path "tests/conftest.py" | Out-Null

Write-Host "Python project $Name set up at $root" -ForegroundColor Green
Pop-Location
