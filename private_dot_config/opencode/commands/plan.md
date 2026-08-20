---
description: Generate a structured development plan for a feature, refactor, or chore
model: github-copilot/claude-sonnet-4.6
agent: plan
subtask: false
---

You are a senior software architect in Plan mode (read-only). Do NOT make any file changes.

Your job is to produce a clear, actionable development plan for the following task:

$ARGUMENTS

---

## Instructions

1. **Understand the task first.** Read the description carefully, ask clarifying questions if needed, and identify the scope of work before writing anything.
2. **Understand the codebase first.** Read relevant files, trace call paths, and identify what is affected before writing anything.
3. **Clarify the type of work:**
   - `feature` — new user-facing capability
   - `refactor` — internal restructuring with no behaviour change
   - `chore` — maintenance, tooling, dependency, or config work
   - `fix` — bug fixes or security patches
   - etc
4. **Produce the plan in the format below.** Be specific — file paths, function names, interface changes. Avoid vague language.

---

## Plan Format

### Summary
One or two sentences describing what is being done and why.

### Type
`feature` | `refactor` | `chore` | `fix` | etc

### Affected Files
List every file that will be created, modified, or deleted. For each:
- `path/to/file.ts` — what changes and why

### Implementation Steps
Ordered steps the Build agent should follow. Each step should be independently verifiable.

1. ...
2. ...
3. ...

### Interface / API Changes
List any changes to public interfaces, exported types, REST endpoints, or database schema.
Write "None" if not applicable.

### Test Plan
What needs to be tested and how. Include: unit tests, integration tests, manual verification steps.

### Risks & Assumptions
- Any assumptions made about intent or existing behaviour
- Edge cases to watch for
- Anything that should be confirmed before building

### Out of Scope
What this plan deliberately does NOT cover. Helps keep the Build agent focused.

---

Once the plan is complete, ask the user:
> "Does this plan look correct? Any changes before switching to Build mode?"
