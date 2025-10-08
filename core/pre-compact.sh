#!/bin/bash
# PRE-COMPACT HOOK - Re-inject critical context before compaction

echo "⚠️ CONTEXT COMPACTION DETECTED - PRESERVING CRITICAL STATE"
echo ""
echo "## SPOKENBLADE PROJECT ESSENTIALS"
echo "- admin_dashboard.html = PROFESSIONAL (correct)"
echo "- Database = SQLite canonical source"
echo "- Export working: sqlite_v1.0 format"
echo "- BROKEN: Force CPU checkbox sync"
echo ""

# Save current TODO state
echo "## ACTIVE WORK"
if [ -f ".plan/TODO-ACTIVE.md" ]; then
    echo "Current TODO items:"
    grep -E "pending|in_progress" .plan/TODO-ACTIVE.md 2>/dev/null | head -5
fi

echo ""
echo "## CRITICAL RULES"
echo "- NEVER work in DEPLOYMENT-* folders"
echo "- Test after every change"
echo "- Complete todos before idling"
echo ""
echo "⚠️ CONTEXT PRESERVATION COMPLETE"