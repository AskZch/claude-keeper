#!/bin/bash
# Auto Context Monitor and Compact
# Runs periodically to check context and auto-compact when needed

THRESHOLD=85  # Compact when context hits 85%
PROJECT_DIR="/home/zch/devel/SpokenBlade"

# Function to get current context percentage
get_context_usage() {
    # This would need to parse /context output
    # For now, return a dummy value - Claude Code would need to provide this
    echo "76"  # Placeholder
}

# Check if we should compact
CURRENT_USAGE=$(get_context_usage)

if [ "$CURRENT_USAGE" -ge "$THRESHOLD" ]; then
    echo "⚠️  Context at ${CURRENT_USAGE}% - Auto-compacting..."
    
    # Run preservation script
    $PROJECT_DIR/.claude/hooks/manual-compact-prep.sh
    
    echo "✅ Context preserved, ready for compact"
    echo "🔄 Triggering compact..."
    
    # Signal to Claude Code that we want to compact
    # This file will be checked by post-response hook
    touch $PROJECT_DIR/.claude/.needs-compact
    
else
    echo "✓ Context at ${CURRENT_USAGE}% - within limits"
fi
