
  - .devdata/current_state.md: Honest assessment (no more
  "deployment ready" BS)
  - .issues/: Corrected agent overclaims, accurate fix status
  - SESSION-HANDOFF-2025-10-07-1800-PRECOMPACT.md:
  Comprehensive 35-min unfuck plan

  Next Session Instructions 🎯

  1. FIRST ACTION: Query memory-keeper session a73e16e2 channel
   urgent-fixes
  2. READ: SESSION-HANDOFF-2025-10-07-1800-PRECOMPACT.md
  3. EXECUTE: Test corrections + vocabulary system fixes (35
  minutes)

  Issues Clearly Documented ❌

  - Corrections: Working but no test data (agent removed all
  entries)
  - Vocabulary: Source files clean, system integration
  incomplete (25-31% corruption remains)

  Ready for /compact - all state preserved to prevent goldfish
  memory syndrome. The memory-keeper should maintain continuity
   across context loss.

  Your RDS research timing is perfect - this memory system
  integration could solve the recurring handoff failures.

> /mcp 
  ⎿  (no content)

> ready for compact?

● Yes, ready for /compact.

  State preservation complete:
  - Memory-keeper session a73e16e2 active with 5 critical items
   saved
  - All documentation updated with honest status (no more false
   "deployment ready" claims)
  - Comprehensive handoff document created with specific
  35-minute unfuck plan
  - Agent's half-completed work clearly documented

  Next session will start with:
  1. Query memory-keeper session a73e16e2 channel urgent-fixes
  2. Read SESSION-HANDOFF-2025-10-07-1800-PRECOMPACT.md
  3. Execute the unfuck plan: add test corrections + complete
  vocabulary system integration

  The memory-keeper integration should prevent the goldfish
  memory syndrome that's been plaguing handoffs. All critical
  state is preserved outside the context window.














Plan to Address Claude Code Context Loss and Enforce Safe Workflow

1. Set up a Persistent Memory MCP Server

Install an MCP “memory” server to persist context beyond Claude’s session window. The official reference Memory server or the community-built Memory Keeper provide a persistent knowledge graph/SQLite store to save conversation state
github.com
github.com
. For example, use Memory Keeper via Claude CLI:

claude mcp add memory-keeper npx mcp-memory-keeper


This one-line command fetches the latest server and registers it with Claude
github.com
. If using Claude Desktop, add it in Settings → Developer → Model Context Protocol with:

{
  "mcpServers": {
    "memory-keeper": {
      "command": "npx",
      "args": ["mcp-memory-keeper"]
    }
  }
}


Restart Claude to load the new server
github.com
github.com
. The memory server will create a SQLite database (e.g. context.db) to store context items
github.com
. Tip: set the DATA_DIR environment variable to a project path (e.g. ./.devdata/memory-keeper/) to keep the memory DB within your workspace
github.com
. Verify the server is running with claude mcp list and test saving a key/value:

mcp_memory_save({ key: "test", value: "Hello Memory!" })


Once configured, Claude can use commands like mcp_context_save and mcp_context_recall to persist important details. This ensures that even after compaction or a new session, the agent can retrieve prior context from the memory store
github.com
github.com
.

2. Enforce a Patch-Only Coding Workflow

Adopt a diff-driven approach to restrict the AI from making uncontrolled edits. In your project’s CLAUDE.md/AGENTS.md (see below), instruct Claude to output only unified diff patches rather than full file content
cc.deeptoai.com
. Define which files it is allowed to modify (whitelisting) to prevent scope creep
cc.deeptoai.com
. For example, include a rule: “IMPORTANT: All code changes must be provided as a unified diff patch, modifying only whitelisted files, not by directly rewriting whole files.” During a coding task, have Claude produce a patch (e.g. saved as change.patch). Use a shell script to apply and test the patch:

#!/bin/bash
patch_file="$1"
git apply --check "$patch_file" && git apply "$patch_file" && npm test || echo "Patch failed or tests failed."


This ensures the diff is valid and that tests pass before committing. If the patch doesn’t apply cleanly or tests fail, you can revert and prompt Claude for corrections, rather than letting it blindly mutate code. This patch-only workflow simplifies rollbacks and code review: you only need to review diffs against the plan, and can easily undo changes via version control
cc.deeptoai.com
cc.deeptoai.com
. Pitfalls: LLM-generated diffs can sometimes be inconsistent with the latest code or omit context, causing apply failures. Mitigate this by keeping changes small and in sync with the repository, using git apply --3way (which attempts fuzzy matching), and always running a dry-run (git apply --check) to catch invalid diffs quickly. Over time, refine your prompt instructions or use templates (e.g. a PLAN.md with explicit “Definition of Done”) so Claude produces minimal, accurate patches that apply cleanly
cc.deeptoai.com
cc.deeptoai.com
.

3. Maintain a Lightweight Memory Bank (AGENTS.md and STATE.md)

Create an AGENTS.md at your repository root (or update the existing CLAUDE.md) to give the AI persistent background on your project. This is essentially a README for AI, where you list essential setup commands, coding conventions, and project context
agents.md
agents.md
. Include sections like:

Build & Test – how to install dependencies and run tests (e.g. build with pnpm install, run tests with pnpm test)
agents.md
.

Code Style – language or framework-specific style rules (e.g. “TypeScript strict mode; use single quotes; no semicolons”
agents.md
).

Project Conventions – key architecture notes, directory structure, or data flow overview.

Workflow & Etiquette – e.g. “commit messages should follow X format; always run linting before commit.”
Keep this file concise (on the order of 1–2 kB). As one expert notes, “Keep it small and clear. You can grow it later.” AI agents thrive on clear guidelines, so compile a list of do’s and don’ts that reflect your preferences
builder.io
. By autoloading this file in each session, Claude won’t waste tokens re-discovering project basics – it will know your environment and standards up front
builder.io
builder.io
. (If Claude Code doesn’t yet natively load AGENTS.md, consider symlinking it to CLAUDE.md for compatibility
pnote.eu
.)

Use a STATE.md as a living project log that the assistant updates and reads on resume. This file acts as the AI’s short-term memory of what’s been done and what’s next. After each significant change or at session end, ask Claude to append a brief update to STATE.md covering:
Current task/status, Last completed action, Upcoming TODOs, and any blockers or decisions.
For example, the AI might write:

**Last completed:** Integrated OAuth2 login (commit `abc123`).  
**Next:** Write unit tests for `AuthService`; add token refresh logic.  
**Blockers:** OAuth library lacks feature X – need workaround.


Keeping this summary up-to-date (favor bullet points over long prose
medium.com
) lets you restart a session by simply prompting Claude: “Read STATE.md and continue where we left off.” The assistant will regain context quickly by parsing these notes
medium.com
. Best practices: Treat STATE.md as an ephemeral memory – if it grows too large, have the AI summarize or archive older entries to keep it concise. The “Long-Term Context Management Protocol” approach shows that having the AI automatically maintain files like state/decision logs after each work block dramatically improves continuity
medium.com
medium.com
. Even if you update it manually, this discipline ensures critical context isn’t lost when the session resets.

4. Use Hooks to Preserve and Reload Context Across Sessions

Leverage Claude Code’s hooks to automate context saving and restoration at key events. In particular, configure a PreCompact hook to snapshot the session state right before Claude compacts its context buffer, and a SessionStart hook to re-inject saved state when a session (or agent process) begins
suiteinsider.com
suiteinsider.com
. For example:

PreCompact: Trigger a Python hook that reads recent conversation highlights or the STATE.md file and calls the memory server’s API (e.g. mcp_context_save(...)) or writes to a local log. You could also use this moment to commit the current work-in-progress to a git branch (as a backup) along with a summary message. This ensures nothing important is lost when compaction happens
reddit.com
reddit.com
.

SessionStart: Trigger a hook that, on new session, fetches saved context from the memory store or loads STATE.md and presents it to Claude (for instance, by programmatically sending a system message or using Claude’s /init command). This primes the new session with the last known state.

Tools like Context Forge implement a similar idea: a hooks manager listens for the preCompact event and re-injects the right context files so the model retains important info
medium.com
medium.com
. The key is to inject only distilled, relevant memory – e.g. the STATE.md summary or specific facts – rather than the entire raw transcript, thus avoiding token bloat. By combining a memory server and hooks, you can automate this workflow: on compaction, push a concise summary of progress to long-term storage; on session start, pull that summary back in. This prevents the AI from “forgetting” earlier instructions or code without resorting to huge prompts. Make sure to test your hooks in a safe setting (they should fail gracefully, not hang Claude)
reddit.com
reddit.com
. A quick validation is to intentionally trigger a compaction (fill the context) and confirm that after compaction Claude can still summarize the project – indicating your summary injection worked.

Key Resources (why these matter):

Anthropic Model Context Protocol Servers (GitHub) – Official reference implementations for MCP connectors. Notably includes a built-in Memory server (for persistent knowledge storage) and even a community Claude Thread Continuity plugin for maintaining full context across sessions
github.com
github.com
.

MCP Memory Keeper Repository – Community-driven MCP server tailored for Claude Code’s context loss issue. The README highlights features like saving/restoring context across sessions and fast SQLite storage, and provides a one-command install for local use
github.com
github.com
.

“From Random Conversations to Reproducible Production” (Workflow Guide) – An advanced Claude Code guide advocating a diff-driven, document-first methodology. It demonstrates how using PLAN.md and unified diffs (instead of live edits) yields easy rollbacks and predictable results, with the AI confined to patching code rather than free-form mutation
cc.deeptoai.com
cc.deeptoai.com
.

AGENTS.md Official Site – Describes the emerging standard for AI context files. Explains what to include (build steps, code style, testing, etc.) and how one AGENTS.md works across many tools. Also notes you can use nested AGENTS.md in subdirectories for monorepos, with the nearest file applying to that part of the project
agents.md
agents.md
.

“How I Solved the Biggest Problem with AI Coding Assistants” – Medium post introducing the LCMP (Long-term Context Management Protocol). It shows how an AI assistant can automatically maintain files like state.md (current project status) after each task, and then quickly regain context by reading those logs in new sessions
medium.com
medium.com
. This underscores the value of an external memory bank.

“How I Solved Claude’s Context Loss Problem” – Medium post by an engineer who built Context Forge. Confirms the effectiveness of using Claude Code’s hooks: it tackles compaction by reinjecting scoped memory via a PreCompact hook, and uses structured prompt files (PRPs and docs) to keep sessions consistent
medium.com
medium.com
. This real-world example validates the hook-based approach to persistent state.

All of the above solutions are doable on Linux/WSL without Docker. The Claude CLI/Desktop and MCP servers run natively (Node or Python), and hooks are just local scripts. By implementing these steps, you’ll create a more resilient Claude Code workflow that preserves state across sessions and confines code changes to safe, reviewable patches – achievable with a couple hours of setup and testing.
github.com
cc.deeptoai.com