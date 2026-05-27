Scaffold a new component for the domain and type specified: $ARGUMENTS

Expected format: `<domain> <type> <name>`
Examples:
  - `azure bicep storage-account`
  - `dotnet api WeatherService`
  - `python fastapi users-router`

Steps:
1. Identify the domain (azure / dotnet / python) and load instructions from `instructions/<domain>/`
2. Use the appropriate shared tool from `tools/<domain>/` if one exists
3. Generate the files following the domain's conventions
4. Print a summary of what was created and next steps
