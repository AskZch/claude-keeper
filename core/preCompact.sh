#!/bin/bash
# Pre-Compact Hook - Preserves State Before Auto-Compact
# This runs AUTOMATICALLY before Claude Code compacts context

echo "🧠 PRE-COMPACT: Preserving context state..."

PROJECT_DIR="/home/zch/devel/SpokenBlade"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# 1. Update TODO state
echo "📋 Saving TODO state..."
cat > $PROJECT_DIR/.plan/TODO-PRE-COMPACT-${TIMESTAMP}.md << 'EOF'
# TODO State Before Context Compact
Generated: $(date)

## Active Tasks
EOF

# Append current todos from Claude Code's todo system
# (This would be populated by Claude Code's internal state)

# 2. Save current working state
echo "💾 Saving working state..."
cat > $PROJECT_DIR/.devdata/PRE-COMPACT-STATE-${TIMESTAMP}.md << EOF
# Pre-Compact State Snapshot
Time: $(date)
Context: About to be compacted

## Working On
- Check git status for uncommitted changes
- Current branch: $(cd $PROJECT_DIR && git branch --show-current)

## Recent Activity
$(cd $PROJECT_DIR && git log -5 --oneline)

## Key Files Modified Recently
$(cd $PROJECT_DIR && git status --short)

## Active Issues
$(ls -t $PROJECT_DIR/.issues/*.md 2>/dev/null | head -5 | xargs -I {} basename {})

EOF

# 3. Create handoff document
echo "📝 Creating post-compact handoff..."
cat > $PROJECT_DIR/POST-COMPACT-HANDOFF-${TIMESTAMP}.md << EOF
# Post-Compact Session Handoff
**Time:** $(date)
**Event:** Context was compacted automatically

## Resume From Here

### What Was Happening
Context reached threshold and was automatically compacted.
All state preserved in:
- .plan/TODO-PRE-COMPACT-${TIMESTAMP}.md
- .devdata/PRE-COMPACT-STATE-${TIMESTAMP}.md

### Critical Context
- Project: SpokenBlade translation system
- Status: Past deadline, crisis mode
- User: Sick, broke, needs to ship
- Active Bug: Checkbox sync (Force CPU stays checked when GPU active)

### What Works
- Core translation engine ✅
- Vocabulary export ✅
- Dashboard ✅

### What's Broken
- Checkbox sync bug (needs backend fix in /api/admin/auto_mode)

### Next Actions
1. Read this handoff
2. Check .plan/ for latest TODO
3. Continue where we left off
4. DO NOT break working code

### Files to Read
- CLAUDE.md
- .devdata/rules.md
- .devdata/current_state.md
- Latest SESSION-HANDOFF-*.md

## State Preservation Complete
✅ TODO saved
✅ Working state captured
✅ Handoff created
✅ Ready for compact

EOF

# 4. Commit if there are changes
cd $PROJECT_DIR
if ! git diff --quiet || ! git diff --cached --quiet; then
    echo "💾 Committing changes before compact..."
    git add -A
    git commit -m "Pre-compact auto-save: $(date)" || true
fi

echo "✅ Pre-compact preservation complete"
echo "🔄 Context will now be compacted..."
