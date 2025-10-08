#!/bin/bash
# SPOKENBLADE PROJECT HOOK - Memory-keeper integrated context injection

# Use hook orchestrator for coordinated context management
HOOK_ORCHESTRATOR="/home/zch/devel/SpokenBlade/.claude/hooks/hook-orchestrator.sh"

if [ -f "$HOOK_ORCHESTRATOR" ]; then
    # Let the orchestrator handle context injection
    "$HOOK_ORCHESTRATOR"
else
    # Fallback: Basic context injection
    echo ""
    echo "🧠 SPOKENBLADE MEMORY-KEEPER INTEGRATION"
    echo "• Session: a73e16e2-8512-4af7-9970-5c1047858b5c"
    echo "• Channel: urgent-fixes"
    echo "• Status: Corrections + vocabulary fixes in progress"
    echo "• Auth: test_admin_login.py (admin/AskZch2025!)"
    echo ""
    echo "📋 CRITICAL: Use memory-orchestrator subagent for context preservation"
    echo ""
fi

# Auto-sync current todo state to plan files
TODO_SYNC_FILE="/home/zch/devel/SpokenBlade/.plan/AUTO-TODO-SYNC.md"
cat > "$TODO_SYNC_FILE" << 'EOF'
# Auto-Generated TODO Sync - $(date)

## Current TodoWrite State:
**Last Update:** $(date '+%Y-%m-%d %H:%M:%S')

### COMPLETED ✅
- Export lemmatized vocabulary files → ZIP ready for Codex
- Verify translation bugs fixed → Git commits confirmed
- Certificate generator → Full HTTPS deployment system
- Fix checkbox sync bug → Redesigned with toggle buttons
- Create /refresh command → Verbose memberberry protocol

### IN PROGRESS 🔄
- Import cleaned vocabulary files → Waiting for Codex processing

### PENDING 📋
- Test full export/import workflow → Ready after Codex returns

## Next Session Priorities:
1. Import Codex-cleaned vocabulary files
2. Test complete workflow end-to-end
3. Final deployment package for Highlander

**Status:** Vocabulary cleanup is final deployment blocker
EOF

echo "📋 TODO state auto-synced to .plan/AUTO-TODO-SYNC.md"
echo ""

# Anti-idling enforcement
echo "⚠️ ANTI-IDLING CHECK:"
echo "- Codex processing vocabulary: Continue other tasks"
echo "- Pending end-to-end testing: Prepare test scripts"
echo "- Multiple servers running: Clean up background processes"
echo "- NO IDLING ALLOWED - Always work on available tasks!"
echo ""