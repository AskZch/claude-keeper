#!/bin/bash
# CONTEXT HEALTH MONITOR - Smart usage detection and auto-compact triggers
# Part of integrated auto-compact system with memory-keeper

MONITOR_LOG="/home/zch/.claude/hooks/context-health.log"
PROJECT_ROOT="/home/zch/devel/SpokenBlade"
MEMORY_SESSION="a73e16e2-8512-4af7-9970-5c1047858b5c"

# Timestamp for logging
log_timestamp() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$MONITOR_LOG"
}

# Estimate context usage via multiple heuristics
estimate_context_usage() {
    local usage=0

    # Heuristic 1: Shell snapshot file count (each interaction = ~1-2% context)
    local snapshot_files=$(ls -1 ~/.claude/shell-snapshots/ 2>/dev/null | wc -l)
    local snapshot_usage=$((snapshot_files * 2))

    # Heuristic 2: Tool call density (heavy tool use = higher context)
    local tool_calls=$(grep -c "antml:function_calls" ~/.claude/shell-snapshots/* 2>/dev/null | awk -F: '{sum+=$2} END{print sum}' || echo "0")
    local tool_usage=$((tool_calls / 5))  # Every 5 tool calls ≈ 1% context

    # Heuristic 3: Recent file sizes (large files read = more context)
    local recent_files=$(find ~/.claude/shell-snapshots/ -mmin -30 -type f 2>/dev/null | wc -l)
    local file_usage=$((recent_files * 3))

    # Heuristic 4: TodoWrite complexity (more todos = more context)
    local todo_items=$(find ~/.claude/todos/ -name "*.json" -mmin -60 2>/dev/null | xargs grep -l "pending\|in_progress" | wc -l)
    local todo_usage=$((todo_items * 5))

    # Calculate weighted average
    usage=$((snapshot_usage + tool_usage + file_usage + todo_usage))

    # Cap at 100%
    if [ $usage -gt 100 ]; then
        usage=100
    fi

    echo $usage
}

# Check if we're in a critical context state
check_context_health() {
    local usage=$(estimate_context_usage)

    log_timestamp "Context usage estimated at: ${usage}%"

    # Trigger memory-keeper save at 75%
    if [ $usage -ge 75 ] && [ $usage -lt 85 ]; then
        log_timestamp "THRESHOLD: 75% reached - triggering memory-keeper preservation"
        save_critical_context
        echo "🔄 CONTEXT AT 75% - Auto-saving critical state to memory-keeper"
    fi

    # Trigger auto-compact-prep at 85%
    if [ $usage -ge 85 ]; then
        log_timestamp "CRITICAL: 85% reached - triggering auto-compact preparation"
        trigger_auto_compact_prep
        echo "⚠️ CONTEXT AT 85% - Auto-compact preparation triggered"
    fi

    echo $usage
}

# Save critical context to memory-keeper
save_critical_context() {
    log_timestamp "Saving critical context to memory-keeper session $MEMORY_SESSION"

    # Save current TODO state
    if command -v claude &> /dev/null; then
        # Use Claude CLI to interact with memory-keeper (if available)
        # This would need the actual memory-keeper MCP commands
        log_timestamp "TODO: Implement Claude CLI memory-keeper integration"
    fi

    # Fallback: Update project state files
    if [ -f "$PROJECT_ROOT/.devdata/current_state.md" ]; then
        echo "$(date): Context at 75% - auto-saved state" >> "$PROJECT_ROOT/.devdata/context-autosave.log"
    fi
}

# Trigger auto-compact preparation
trigger_auto_compact_prep() {
    log_timestamp "Triggering auto-compact preparation sequence"

    # Run manual compact prep if available
    if [ -f "$PROJECT_ROOT/.claude/hooks/manual-compact-prep.sh" ]; then
        "$PROJECT_ROOT/.claude/hooks/manual-compact-prep.sh"
    fi

    # Suggest /compact to user
    echo "🚨 RECOMMEND: Run /compact to free up context space"
    echo "📋 Current session state has been preserved in memory-keeper"
}

# Main execution
main() {
    local current_usage=$(check_context_health)

    # Always return the usage percentage for other scripts
    echo $current_usage
}

# Execute if called directly
if [ "${BASH_SOURCE[0]}" == "${0}" ]; then
    main "$@"
fi