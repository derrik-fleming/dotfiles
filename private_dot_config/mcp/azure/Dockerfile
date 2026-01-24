# Azure DevOps MCP Server Dockerfile
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Install the Azure DevOps MCP package globally
# Using the nightly build (@next) for latest features
RUN npm install -g @azure-devops/mcp@next

# Set environment variable for Azure DevOps organization
# This MUST be overridden at runtime
ENV ADO_ORG=""

# Health check (optional - checks if node is responsive)
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD node -e "console.log('healthy')" || exit 1

# Use shell form to allow environment variable expansion
# The ADO_ORG environment variable will be passed at runtime
ENTRYPOINT ["/bin/sh", "-c", "npx @azure-devops/mcp@next \"$ADO_ORG\""]

