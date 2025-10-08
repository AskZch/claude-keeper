#!/bin/bash
# Claude Goldfish Prevention System - One-Click Installation
# Installs the revolutionary AI verification system

set -e

echo "🧠 Installing Claude Goldfish Prevention System..."
echo ""

# Check prerequisites
echo "📋 Checking prerequisites..."

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Error: Must be run in a git repository"
    exit 1
fi

# Check for Claude Code environment
if [ ! -d ".claude" ]; then
    echo "📁 Creating .claude directory..."
    mkdir -p .claude/{agents,hooks}
else
    echo "✅ .claude directory exists"
fi

# Check for memory-keeper
echo "🧠 Checking for memory-keeper MCP..."
if command -v claude &> /dev/null; then
    echo "✅ Claude CLI available"
else
    echo "⚠️  Warning: Claude CLI not found - memory-keeper integration may be limited"
fi

# Check for external AI tools
echo "🤖 Checking for external AI tools..."
EXTERNAL_TOOLS=0

if command -v codex &> /dev/null; then
    echo "✅ Codex CLI found"
    EXTERNAL_TOOLS=$((EXTERNAL_TOOLS + 1))
fi

if command -v python3 &> /dev/null; then
    echo "✅ Python3 found"
    EXTERNAL_TOOLS=$((EXTERNAL_TOOLS + 1))
fi

if command -v curl &> /dev/null; then
    echo "✅ curl found"
    EXTERNAL_TOOLS=$((EXTERNAL_TOOLS + 1))
fi

if [ $EXTERNAL_TOOLS -eq 0 ]; then
    echo "❌ Error: No external AI tools found (need codex, python3, or curl)"
    exit 1
else
    echo "✅ $EXTERNAL_TOOLS external verification tools available"
fi

echo ""
echo "🔧 Installing system components..."

# Copy verification scripts
echo "📄 Installing verification scripts..."
cp claude-lie-detector.sh .claude/agents/
chmod +x .claude/agents/claude-lie-detector.sh

# Copy subagents
echo "🤖 Installing specialized subagents..."
cp goldfish-prevention.md .claude/agents/ 2>/dev/null || echo "⚠️  goldfish-prevention.md not found"
cp memory-orchestrator.md .claude/agents/ 2>/dev/null || echo "⚠️  memory-orchestrator.md not found"

# Copy hook system
echo "🔗 Installing enhanced hooks..."
cp context-health-monitor.sh .claude/hooks/ 2>/dev/null || echo "⚠️  context-health-monitor.sh not found"
cp hook-orchestrator.sh .claude/hooks/ 2>/dev/null || echo "⚠️  hook-orchestrator.sh not found"
cp memory-keeper-integration.sh .claude/hooks/ 2>/dev/null || echo "⚠️  memory-keeper-integration.sh not found"
cp patch-safety-check.sh .claude/hooks/ 2>/dev/null || echo "⚠️  patch-safety-check.sh not found"

# Make all scripts executable
chmod +x .claude/hooks/*.sh 2>/dev/null || true

# Update CLAUDE.md
echo "📝 Updating CLAUDE.md..."
if [ ! -f "CLAUDE.md" ]; then
    echo "📄 Creating CLAUDE.md..."
    cat > CLAUDE.md << 'EOF'
# Project Context

## Claude Goldfish Prevention System

**Memory-Keeper Session**: [CONFIGURE-YOUR-SESSION-ID]

### External Verification Workflow
```bash
# Before major changes:
Task: .claude/agents/claude-lie-detector.sh save-state

# After Claude claims success:
Task: .claude/agents/claude-lie-detector.sh verify-claims
```

### Auto-Compact Integration
- Context monitoring active with smart thresholds
- Memory preservation at 75% usage
- Auto-compact preparation at 85% usage

### Goldfish Prevention Protocol
- Use external verification for all major claims
- Challenge "deployment ready" statements
- Verify file changes independently
- Maintain accurate project status

EOF
else
    echo "✅ CLAUDE.md exists - manual integration required"
fi

# Create memory-keeper session (if possible)
echo "🧠 Setting up memory-keeper integration..."
if command -v claude &> /dev/null; then
    echo "📋 Memory-keeper CLI commands:"
    echo "   mcp__memory-keeper__context_session_start"
    echo "   mcp__memory-keeper__context_save"
    echo "   mcp__memory-keeper__context_get"
else
    echo "⚠️  Manual memory-keeper setup required"
fi

echo ""
echo "✅ Installation complete!"
echo ""
echo "🚀 Quick Start:"
echo "1. Configure memory-keeper session ID in CLAUDE.md"
echo "2. Test verification: .claude/agents/claude-lie-detector.sh --help"
echo "3. Enable auto-compact in Claude Code: /config"
echo "4. Start catching Claude's lies in real-time!"
echo ""
echo "📖 Full documentation: README.md"
echo "🆘 Support: Create issue on GitHub"
echo ""
echo "🎉 Welcome to goldfish-free AI development!"