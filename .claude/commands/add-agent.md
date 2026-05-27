Add a new agent definition for the domain and name specified: $ARGUMENTS

Expected format: `<domain> <agent-name> "<short description>"`
Example: `azure azure-aks "AKS cluster management and workload deployment specialist"`

Steps:
1. Create `.claude/agents/<agent-name>.md` using the Claude sub-agent format
2. Create `.github/agents/<agent-name>.md` using the GitHub Copilot agent format
3. Add the agent entry to `registry.json`
4. Add domain-specific instructions stub to `instructions/<domain>/<agent-name>.md` if it doesn't exist
5. Print confirmation with the paths created
