# Context MCP Server Setup

This directory contains the Neuledge Context MCP server configuration for use with OpenCode and other MCP-compatible tools.

## Quick Start with OpenCode

### 1. Build and Start the Container

```bash
cd ~/.config/mcp/context
./build.sh
docker-compose up -d
```

### 2. Configure Your MCP Client

For OpenCode, add to your `~/.config/opencode/opencode.json`:

```json
{
  "mcp": {
    "context": {
      "transport": {
        "type": "http",
        "url": "http://localhost:8080/mcp"
      },
      "enabled": true
    }
  }
}
```

### 3. Use Flutter Documentation

The Context MCP comes pre-loaded with Flutter documentation from [docs.flutter.dev/llms.txt](https://docs.flutter.dev/llms.txt). Ask your AI agent Flutter questions and it will have access to the latest official documentation.

## Features

- **Pre-loaded Flutter docs** - Flutter documentation baked into the Docker image
- **Community registry** - Access to 100+ popular library docs
- **Local-first** - All docs stored locally for fast access
- **HTTP transport** - Multi-client access over network
- **Persistent storage** - Additional packages survive container restarts

## Docker Deployment

### Building the Image

```bash
cd ~/.config/mcp/context
docker build -t mcp/context .
```

### Running with Docker Compose (Recommended)

```bash
docker-compose up -d
```

### Running with Docker directly

```bash
docker run -d \
  -p 8080:8080 \
  -v context-packages:/root/.context/packages \
  --name context-mcp \
  mcp/context
```

## Adding More Documentation

Connect to the running container to add more documentation sources:

```bash
# Access the container shell
docker exec -it context-mcp /bin/sh

# Add documentation from the community registry
context install npm/react
context install npm/nextjs
context install npm/tailwindcss

# Add from custom sources
context add https://svelte.dev
context add https://github.com/vercel/next.js

# List all installed packages
context list

# Exit the container
exit
```

## Available Documentation Sources

The Context MCP supports multiple documentation sources:

### Community Registry
```bash
context install npm/react          # React framework
context install npm/nextjs         # Next.js framework  
context install npm/tailwindcss    # Tailwind CSS
context install pip/fastapi        # FastAPI (Python)
context install maven/spring-boot  # Spring Boot (Java)
```

### Website LLMs.txt
```bash
context add https://svelte.dev     # Svelte framework
context add https://nuxt.com       # Nuxt framework
```

### Git Repositories
```bash
context add https://github.com/vercel/next.js
context add https://github.com/vuejs/vue
```

## Available MCP Tools

The Context MCP server provides:
- **Documentation search** - Query any installed documentation package
- **Package management** - Install, list, and remove documentation packages
- **Registry browsing** - Search community registry for available packages

## Client Configurations

### VS Code Integration
Create `.vscode/mcp.json`:
```json
{
  "servers": {
    "context": {
      "type": "http",
      "url": "http://localhost:8080/mcp"
    }
  }
}
```

### Claude Desktop
Add to `~/Library/Application Support/Claude/claude_desktop_config.json`:
```json
{
  "mcpServers": {
    "context": {
      "transport": {
        "type": "http",
        "url": "http://localhost:8080/mcp"
      }
    }
  }
}
```

### Cursor
Add to `~/.cursor/mcp.json`:
```json
{
  "mcpServers": {
    "context": {
      "transport": {
        "type": "http", 
        "url": "http://localhost:8080/mcp"
      }
    }
  }
}
```

## Container Management

```bash
# View container status
docker-compose ps

# View logs
docker-compose logs -f

# Restart service
docker-compose restart

# Stop service  
docker-compose down

# Remove all data and start fresh
docker-compose down -v
docker-compose up -d --build
```

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `CONTEXT_PORT` | `8080` | HTTP server port |
| `CONTEXT_HOST` | `0.0.0.0` | HTTP server host |
| `NODE_ENV` | `production` | Node.js environment |

## Troubleshooting

### Port Already in Use
```bash
# Change port in docker-compose.yml
ports:
  - "8081:8080"  # Use different host port
```

### Container Fails to Start
```bash
# Check logs
docker-compose logs

# Rebuild image
docker-compose build --no-cache
```

### No Documentation Available
```bash
# Verify packages are installed
docker exec context-mcp context list

# Check server response
curl -I http://localhost:8080/mcp
```

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    Docker Container                      │
│                                                         │
│  ┌──────────────────┐    ┌────────────────────────────┐ │
│  │   Context MCP    │    │     /root/.context/        │ │
│  │     Server       │───▶│       packages/            │ │
│  │   (Port 8080)    │    │                            │ │
│  └────────┬─────────┘    │  ├── flutter@latest.db     │ │
│           │              │  ├── react@18.db           │ │
│           │              │  └── ...                   │ │
│           │              └────────────────────────────┘ │
└───────────┼─────────────────────────────────────────────┘
            │ HTTP MCP Protocol
            ▼
   ┌─────────────────┐
   │   MCP Clients   │
   │ (OpenCode, etc) │
   └─────────────────┘
```

## Notes

- Uses Node.js 20 Alpine for minimal Docker image size
- Flutter documentation is built into the image (no runtime download needed)
- Additional packages can be added at runtime and persist in Docker volumes
- Health checks included for container monitoring
- Supports HTTP MCP protocol for multi-client access

## Source

Based on [Neuledge Context](https://github.com/neuledge/context) with Flutter documentation from [docs.flutter.dev/llms.txt](https://docs.flutter.dev/llms.txt).