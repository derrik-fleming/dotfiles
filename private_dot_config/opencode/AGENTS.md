## MCP

### MCP servers live behind the mcp server named proxy
- dart
- git
- kagi
- context7
- cavemem

### Other MCP servers you can call directly
- proxy
- serena
- headroom


### Loop Guardrails
  *~50,050 tokens/session saved*
  - Never issue `read` with ambiguous target (`read: ?`); always provide an explicit file path.
  - If output is truncated, fetch full content in one controlled retry (higher limit or chunked ranges) instead of repeated re-reads.

### Shell/Runtime Environment
*~3,200 tokens/session saved*
- In this environment, prefer `rtk`-wrapped filesystem commands (`rtk ls`, `rtk cat`/`rtk read`, `rtk find`) over raw `ls/cat/find` to avoid unknown-command failures.
- Treat direct `git` calls as unreliable here; avoid retry loops unless repo access is explicitly confirmed.

### File Paths & Search Scope
*~1,800 tokens/session saved*
- Scope config exploration to `/Users/derrik.fleming/.config/opencode/` first, then targeted subdirs (`agent/`, `commands/`, `plugins/`, `skills/`) rather than broad root/global scans.

### MCP Tool Invocation
*~1,200 tokens/session saved*
- Use fully qualified MCP tool names (`server:tool`, e.g., `cavemem:list_sessions`, `dart:list_devices`, `context7:resolve-library-id`) instead of unscoped tool names.
