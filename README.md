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
- Survived **3+ auto-compacts** with perfect memory retention
- **Multi-model verification:** 3/3 AI consensus caught critical field mapping bug
- Fixed UI endpoint issues with external verification (commit `3fe2b195`)
- Found data corruption: 3,511 duplicate entries (100% duplication rate)
- **Zero amnesia:** Seamless workflow continuation post-compaction

**Evidence:** Real git commits, verification logs, before/after screenshots

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

### Pilot Program: Offline Document Translation
**Challenge:** Air-gapped sensitive document processing with strict security requirements

**Solution Applied:**
- **Multi-model consensus:** 3/3 AI models agreed on field mapping bug diagnosis
- **External verification:** Caught API endpoint issues before deployment
- **Data integrity analysis:** Discovered systematic duplication patterns in critical datasets
- **Secure workflow preservation:** Maintained operational continuity through multiple system resets
- **Cryptographic verification:** Hash-based validation confirmed data corruption patterns

**Result:**
- **Mission-critical reliability:** Zero-failure deployment validation
- **Data integrity restored:** Systematic corruption patterns identified and isolated
- **Operational continuity:** Seamless workflow across air-gapped environment constraints
- **Development acceleration:** 4x velocity improvement with verification-driven development

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
- **Commercial licensing:** licensing@askzch.com
- **Enterprise sales:** enterprise@askzch.com

## 🔗 Links

- **Documentation:** [askzch.com/claude-keeper](https://askzch.com/claude-keeper)
- **Hosted Platform:** [askzch.com](https://askzch.com) *(launching soon)*
- **Case Studies:** [askzch.com/examples/claude-keeper](https://askzch.com/examples/claude-keeper)

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