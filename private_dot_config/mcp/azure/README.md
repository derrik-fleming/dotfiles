# Azure DevOps MCP Server Setup

This directory contains the Azure DevOps MCP server configuration for use with OpenCode and other MCP-compatible tools.

## Quick Start with OpenCode

### 1. Configure Your Azure DevOps Organization

Edit your `~/.config/opencode/config.json` and set your Azure DevOps organization name:

```json
{
  "mcp": {
    "azure-devops": {
      "type": "local",
      "command": ["npx", "-y", "@azure-devops/mcp@next"],
      "args": ["YOUR_ORG_NAME"],
      "enabled": true
    }
  }
}
```

Replace `YOUR_ORG_NAME` with your actual Azure DevOps organization name.

### 2. Enable the Azure DevOps Agent

The `@azuredevops` agent is now available in OpenCode! Use it for:
- **Pull request reviews** - Review PRs with full Azure DevOps context
- **Backlog refinement** - Organize and refine work items
- **Sprint planning** - Analyze velocity and plan iterations
- **Work item management** - Query, create, and update work items

### 3. Usage Examples

```bash
# Review all open pull requests
@azuredevops Review all open PRs in the current project

# Refine upcoming sprint backlog
@azuredevops Help refine the backlog for the next sprint

# Analyze a specific PR
@azuredevops Review PR #1234 and provide detailed feedback

# Check sprint health
@azuredevops Check the current sprint progress and identify risks
```

## Authentication

The Azure DevOps MCP server will prompt for authentication on first use. You'll need:
- A valid Azure DevOps account
- Access to the organization you're configuring
- Appropriate permissions (read for queries, write for updates)

## Docker Deployment (Alternative)

If you prefer to run the MCP server in a container:

### Building the Image

```bash
cd ~/.config/mcp/azure
docker build -t ado-mcp-server .
```

### Running the Container

```bash
docker run -it --rm \
  -e ADO_ORG="your-org-name" \
  ado-mcp-server
```

### With Docker Compose

Create a `docker-compose.yml`:

```yaml
version: '3.8'

services:
  ado-mcp:
    build: .
    environment:
      - ADO_ORG=${ADO_ORG:-contoso}
    stdin_open: true
    tty: true
```

Run with:
```bash
ADO_ORG=your-org-name docker-compose up
```

## VS Code Integration

For VS Code integration with Claude Dev or other extensions, create `.vscode/mcp.json`:

```json
{
  "inputs": [
    {
      "id": "ado_org",
      "type": "promptString",
      "description": "Azure DevOps organization name (e.g. 'contoso')"
    }
  ],
  "servers": {
    "ado": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@azure-devops/mcp@next", "${input:ado_org}"]
    }
  }
}
```

## Available MCP Tools

The Azure DevOps MCP server provides tools for:
- **Pull Requests** - List, review, create, comment, approve/reject
- **Work Items** - Query, create, update, link
- **Repositories** - Browse repos, branches, commits
- **Pipelines** - Check build/release status
- **Boards** - Query and organize board items
- **Projects** - List and access project information

## Agent Capabilities

The `@azuredevops` agent specializes in:

### Pull Request Reviews
- Comprehensive code review with Azure DevOps context
- Work item validation and linking
- Constructive feedback with PR comments
- Branch policy verification
- CI/CD pipeline status checks

### Backlog Management
- Work item refinement and organization
- Acceptance criteria validation
- Sprint planning support
- Capacity and velocity analysis
- Dependency identification

### Process Optimization
- Review metrics and insights
- Team efficiency analysis
- Bottleneck identification
- Best practice recommendations

## Troubleshooting

### Authentication Issues
- Ensure you're logged into Azure DevOps in your browser
- Check organization name spelling
- Verify account permissions

### Connection Issues
- Test your internet connection
- Check if Azure DevOps is accessible
- Verify firewall/proxy settings

### MCP Server Not Found
- Run `npx -y @azure-devops/mcp@next` manually to test
- Check npm/npx installation
- Verify Node.js version (requires Node 18+)

## Features

- Uses Node.js 20 Alpine for minimal Docker image size
- Includes the nightly build (@next) for latest features
- Health check included for container monitoring
- Supports stdio communication protocol
- Seamless OpenCode agent integration

## Notes

- The MCP server uses stdio for communication (no network ports needed)
- Authentication is handled by the MCP server via Azure DevOps OAuth
- All data stays within your Azure DevOps organization
- The `@azuredevops` agent has write permissions to provide full functionality
