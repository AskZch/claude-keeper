#!/bin/bash
# PRE-RESPONSE HOOK - Forces critical context before every Claude response

echo "=== MANDATORY SPOKENBLADE CONTEXT ==="
echo ""

# Current project state
echo "## PROJECT STATE"
if [ -f ".devdata/current_state.md" ]; then
    cat .devdata/current_state.md | head -20
else
    echo "SpokenBlade translation system - Montenegrin<->English"
    echo "Status: Past deadline, deployment critical"
fi
echo ""

# Critical rules
echo "## CRITICAL RULES (NEVER VIOLATE)"
echo "- NEVER work in DEPLOYMENT-* folders"
echo "- Database (SQLite) is canonical source, not JSON"
echo "- Test after EVERY change"
echo "- admin_dashboard.html = PROFESSIONAL (correct one)"
echo "- admin_dashboard_old_emoji_monstrosity.html = BACKUP (wrong one)"
echo ""

# Active TODO
echo "## ACTIVE TODO"
TODO_FILE=$(ls -t .plan/*.md 2>/dev/null | head -1)
if [ -f "$TODO_FILE" ]; then
    echo "File: $(basename $TODO_FILE)"
    grep -E "status.*pending|status.*in_progress" "$TODO_FILE" 2>/dev/null | head -5
else
    echo "⚠️ NO ACTIVE TODO - CHECK TodoWrite TOOL"
fi
echo ""

# Known broken items
echo "## BROKEN COMPONENTS"
echo "❌ Force CPU checkbox - stays checked in GPU mode"
echo "❌ Some dashboard metrics need verification"
echo ""

# What works
echo "## WORKING COMPONENTS"
echo "✅ Translation engine (NLLB-200-1.3B)"
echo "✅ Export from SQLite (shows sqlite_v1.0)"
echo "✅ Professional dashboard active"
echo "✅ Auto Mode & Stress Test buttons"
echo ""

echo "=== CONTEXT INJECTION COMPLETE - FOLLOW ABOVE ==="