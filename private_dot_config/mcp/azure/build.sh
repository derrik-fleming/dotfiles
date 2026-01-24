#!/bin/bash
# Build the Azure DevOps MCP Docker image

set -e

echo "🐳 Building Azure DevOps MCP Docker image..."
echo ""

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Build the image
docker build -t mcp/azure-devops "$SCRIPT_DIR"

echo ""
echo "✅ Docker image 'mcp/azure-devops' built successfully!"
echo ""
echo "📝 Next steps:"
echo "   1. Apply chezmoi changes: chezmoi apply"
echo "   2. Restart OpenCode"
echo "   3. Use @azuredevops agent (work context only)"
echo ""
