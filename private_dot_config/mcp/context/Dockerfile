# Neuledge Context MCP Server Dockerfile
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Install system dependencies including git (needed for context add)
RUN apk add --no-cache git curl

# Install the Context MCP package globally
RUN npm install -g @neuledge/context

# Create directory for data persistence
RUN mkdir -p /root/.context/packages

# Add Flutter documentation during build
RUN context add https://docs.flutter.dev/llms.txt --name flutter --pkg-version latest

# Environment variables for HTTP server
ENV CONTEXT_PORT=8080
ENV CONTEXT_HOST=0.0.0.0

# Expose the port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
  CMD curl -f http://localhost:8080/mcp || exit 1

# Default command - serve on HTTP for multi-client access
CMD ["context", "serve", "--http", "8080", "--host", "0.0.0.0"]