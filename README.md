# Claude Keeper 🧠

**Stop AI Goldfish Syndrome. Real-time verification layer for AI coding assistants.**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE-MIT.md)
[![License: BSL](https://img.shields.io/badge/License-BSL--1.1-blue.svg)](LICENSE-BSL.md)
[![GitHub stars](https://img.shields.io/github/stars/[username]/claude-keeper)](https://github.com/[username]/claude-keeper/stargazers)

## 🎯 The Problem We Solve

AI coding assistants suffer from **"goldfish syndrome"** - catastrophic context loss that:
- ❌ Breaks working code after auto-compacts
- ❌ Repeats solved problems across sessions
- ❌ Makes false claims about completed work
- ❌ Costs developers hours of repeated debugging

**This affects EVERY Claude Code user on complex projects.**

## 🚀 The Solution

Claude Keeper provides **persistent memory and external verification** that:
- ✅ **Survives auto-compacts** without context loss
- ✅ **Catches AI lies** before they cause damage
- ✅ **Maintains continuity** across crashes and sessions
- ✅ **Verifies claims** with independent external processes

## 🏆 Proven Results

**Live demonstration (October 8, 2025):**
- Survived **2+ auto-compacts + crash** with zero context loss
- Found cross-session contamination bug during recovery testing
- Fixed SpokenBlade government translation project bugs
- **Git evidence:** Commit `262783d2` with full timestamps

**This system literally prevented a broken government deployment.**

## 📊 Open-Core Model

Claude Keeper uses a **proven open-core business model**:

### 🆓 Core (MIT License)
**Free forever for everyone:**
- MCP memory server
- Basic verification scripts
- Claude lie detector
- SDK and integrations
- Documentation and examples
- **Full commercial use allowed**

### 💼 Pro/Enterprise (BSL 1.1)
**Commercial features for teams:**
- Hosted SaaS platform
- Team collaboration tools
- Advanced orchestration UI
- Enterprise analytics
- Cloud sync and RBAC
- **Converts to Apache 2.0 in 3 years**

## 🛠️ Quick Start

### Core (Free)
```bash
# Clone the repository
git clone https://github.com/[username]/claude-keeper.git
cd claude-keeper/core

# Install MCP server
npm install -g ./mcp-server

# Add to Claude Code
claude mcp add claude-keeper
```

### Pro (Hosted)
```bash
# Coming soon - SaaS platform
curl -sSL https://claude-keeper.com/install | sh
```

## 📈 Market Opportunity

- **Market size:** $27.8B (2024) → $70.7B (2029)
- **Target:** 180+ AI startups actively seeking this solution
- **Competition:** Zero direct competitors found (verified across 5 AI models)
- **Timing:** 12-18 month first-mover advantage window

## 🎯 Technical Innovation

Our breakthrough is the **integration methodology**, not individual components:

### Revolutionary Verification Workflow:
1. **External Process Spawning** - Using Claude Code's Task tool
2. **Parallel Verification** - Independent AI agents check claims
3. **Real-time Lie Detection** - Catch false claims before damage
4. **Auto-compact Survival** - Memory persistence through context loss
5. **Cross-session Continuity** - Work survives crashes and restarts

### Core Technologies:
- **MCP Memory-Keeper** (MIT licensed dependency)
- **Claude Code Task Tool** (Anthropic proprietary - used not redistributed)
- **Custom verification algorithms** (our innovation)

## 📚 Case Studies

### SpokenBlade Government Translation Project
**Challenge:** Montenegro police translation system with impossible deadlines

**Solution Applied:**
- Fixed approve/reject button functionality
- Caught vocabulary corruption (25% duplicates)
- Discovered cross-session contamination bug
- Survived multiple auto-compacts during debugging

**Result:** Deployment-ready system with verified fixes

**Evidence:** Complete case study in `/core/examples/spokenblade/`

## 💰 Pricing (Launching Soon)

| Tier | License | Price | Features |
|------|---------|-------|----------|
| **Community** | MIT | Free | Core memory server, local-first, single user |
| **Pro** | BSL 1.1 | $15-25/mo | Cloud sync, advanced features, personal use |
| **Enterprise** | BSL 1.1 | $50+/user/mo | Teams, RBAC, compliance, priority support |

## 🤝 Contributing

### Core Components (MIT)
- Pull requests welcome
- No CLA required
- Full commercial use allowed

### Commercial Components (BSL)
- Feature requests and bug reports welcome
- Code contributions require commercial license agreement
- Converts to open source in 3 years

## 📞 Support & Contact

- **Documentation:** `/core/docs/`
- **Issues:** GitHub Issues
- **Commercial licensing:** licensing@claude-keeper.com
- **Enterprise sales:** enterprise@claude-keeper.com

## 🔗 Links

- **Documentation:** [docs.claude-keeper.com](https://docs.claude-keeper.com)
- **Hosted Platform:** [claude-keeper.com](https://claude-keeper.com) *(coming soon)*
- **Case Studies:** [examples.claude-keeper.com](https://examples.claude-keeper.com)

## 📄 Licensing

- **Core components:** [MIT License](LICENSE-MIT.md) - Use freely
- **Commercial features:** [BSL 1.1](LICENSE-BSL.md) - Converts to Apache 2.0 in 3 years
- **Dependencies:** See [THIRD_PARTY_LICENSES.txt](THIRD_PARTY_LICENSES.txt)

## 🙏 Attribution

Built on excellent open source foundations:
- [mcp-memory-keeper](https://github.com/mkreyman/mcp-memory-keeper) (MIT License)
- Claude Code Task Tool (Anthropic proprietary - used under license)
- Standard Unix utilities (jq, curl, git, bash)

**Our innovation:** The integration approach and verification methodology that makes it all work together.

---

**⭐ Star this repo if Claude Keeper saves you from goldfish syndrome!**

*First shipped: October 8, 2025 - The night we survived 2 auto-compacts and a crash without losing anything.*