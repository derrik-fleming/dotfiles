#!/bin/bash
# Build the Context MCP Docker image

set -e

echo "🐳 Building Context MCP Docker image..."
echo ""

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Build the image
docker build -t mcp/context "$SCRIPT_DIR"

echo ""
echo "✅ Docker image 'mcp/context' built successfully!"
echo ""
echo "📝 Next steps:"
echo "   1. Run: docker run -d -p 8080:8080 mcp/context"
echo "   2. Or use: docker-compose up -d"
echo "   3. Configure your MCP client to use http://localhost:8080/mcp"
echo ""
