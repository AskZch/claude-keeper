#!/bin/bash
# HOOK ORCHESTRATOR - Coordinates all hooks and memory-keeper integration
# Part of integrated auto-compact system

ORCHESTRATOR_LOG="/home/zch/.claude/hooks/orchestrator.log"
PROJECT_ROOT="/home/zch/devel/SpokenBlade"
MEMORY_SESSION="a73e16e2-8512-4af7-9970-5c1047858b5c"

# Logging function
log_event() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ORCHESTRATOR: $1" >> "$ORCHESTRATOR_LOG"
}

# Check if we need to throttle context injection (prevent spam)
should_inject_context() {
    local last_inject_file="/tmp/spokenblade-orchestrator-last-inject"
    if [ -f "$last_inject_file" ]; then
        local last_inject=$(cat "$last_inject_file")
        local now=$(date +%s)
        local diff=$((now - last_inject))
        # Only inject every 3 minutes (180 seconds) to avoid spam
        if [ $diff -lt 180 ]; then
            return 1  # Don't inject
        fi
    fi
    echo "$(date +%s)" > "$last_inject_file"
    return 0  # Do inject
}

# Query memory-keeper for current session state
query_memory_keeper() {
    log_event "Querying memory-keeper session $MEMORY_SESSION"

    # Since we can't directly call MCP tools from bash, we'll update project files
    # based on known memory-keeper content from previous sessions

    if should_inject_context; then
        echo ""
        echo "🧠 MEMORY-KEEPER SESSION: $MEMORY_SESSION"
        echo "📋 Urgent fixes tracked: corrections + vocabulary corruption"
        echo "🔄 Last handoff: SESSION-HANDOFF-2025-10-07-1800-PRECOMPACT.md"
        echo ""
    fi
}

# Inject critical project context
inject_project_context() {
    if should_inject_context; then
        echo "🎯 SPOKENBLADE PROJECT STATUS"
        echo "• Server: Running on port 8000 (start_server.sh)"
        echo "• Auth: admin/AskZch2025! (use test_admin_login.py)"
        echo "• Issues: Corrections need test data, vocabulary partially fixed"
        echo "• Branch: fix/vocabulary-export-sqlite-integration"
        echo ""
    fi
}

# Check context health and trigger actions
check_and_manage_context() {
    local context_usage=0

    # Run context health monitor
    if [ -f "$PROJECT_ROOT/.claude/hooks/context-health-monitor.sh" ]; then
        context_usage=$("$PROJECT_ROOT/.claude/hooks/context-health-monitor.sh")
        log_event "Context usage: ${context_usage}%"
    fi

    # Show context health to user
    if [ $context_usage -ge 70 ]; then
        echo "⚠️ Context Usage: ${context_usage}% - Consider /compact soon"
    fi
}

# Anti-idling enforcement
enforce_anti_idle() {
    # Check for pending todos
    local pending_todos=$(find ~/.claude/todos/ -name "*.json" -mtime -1 2>/dev/null | xargs grep -l "pending\|in_progress" 2>/dev/null | wc -l)

    if [ $pending_todos -gt 0 ]; then
        echo "🚫 ANTI-IDLE: $pending_todos pending todos - CONTINUE WORKING!"
        log_event "Anti-idle triggered: $pending_todos pending todos"
    fi
}

# Main orchestration function
orchestrate_hooks() {
    log_event "Hook orchestration started"

    # Step 1: Query memory-keeper for session continuity
    query_memory_keeper

    # Step 2: Inject critical project context
    inject_project_context

    # Step 3: Check context health and manage usage
    check_and_manage_context

    # Step 4: Enforce anti-idling
    enforce_anti_idle

    log_event "Hook orchestration completed"
}

# Execute orchestration
orchestrate_hooks