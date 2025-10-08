#!/bin/bash
# CLAUDE LIE DETECTOR - External verification system using codex
# Catches Claude's false claims and incomplete fixes in real-time

DETECTOR_LOG="/home/zch/devel/SpokenBlade/.claude/agents/lie-detector.log"
PROJECT_ROOT="/home/zch/devel/SpokenBlade"

# Logging function
log_detection() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] LIE-DETECTOR: $1" >> "$DETECTOR_LOG"
}

# Verify vocabulary corruption status
verify_vocabulary_corruption() {
    log_detection "Checking vocabulary corruption status"

    echo "🔍 VERIFYING VOCABULARY CORRUPTION CLAIMS..."
    echo ""

    # Check source files (supposedly fixed)
    local source_en_count=$(jq '.vocabulary | length' "$PROJECT_ROOT/vocab/codex_workspace/en_to_me_alex_professional.json" 2>/dev/null || echo "ERROR")
    local source_me_count=$(jq '.vocabulary | length' "$PROJECT_ROOT/vocab/codex_workspace/me_to_en_professional.json" 2>/dev/null || echo "ERROR")

    # Check system files (should be updated but probably aren't)
    local system_en_count=$(jq '.metadata.total_entries' "$PROJECT_ROOT/vocabulary/en_to_me/standard/vocabulary.json" 2>/dev/null || echo "ERROR")
    local system_me_count=$(jq '.metadata.total_entries' "$PROJECT_ROOT/vocabulary/me_to_en/standard/vocabulary.json" 2>/dev/null || echo "ERROR")

    # Check database (should be rebuilt but probably isn't)
    local db_size=$(stat -c%s "$PROJECT_ROOT/vocabulary_optimized.db" 2>/dev/null || echo "ERROR")

    echo "📊 VERIFICATION RESULTS:"
    echo "Source files (codex_workspace):"
    echo "  EN→ME: $source_en_count entries"
    echo "  ME→EN: $source_me_count entries"
    echo ""
    echo "System files (vocabulary/):"
    echo "  EN→ME: $system_en_count entries"
    echo "  ME→EN: $system_me_count entries"
    echo ""
    echo "Database: ${db_size} bytes"
    echo ""

    # Analysis
    if [ "$source_en_count" = "916" ] && [ "$source_me_count" = "840" ]; then
        echo "✅ SOURCE FILES: Fixed (916 + 840 = 1756 clean entries)"
    else
        echo "❌ SOURCE FILES: Not fixed or corrupted"
    fi

    if [ "$system_en_count" = "916" ] && [ "$system_me_count" = "840" ]; then
        echo "✅ SYSTEM FILES: Updated with clean data"
    else
        echo "❌ SYSTEM FILES: Still corrupted (should be 916/840, showing $system_en_count/$system_me_count)"
        echo "🚨 CLAUDE LIED: Claimed vocabulary fixed but system files not updated"
    fi

    log_detection "Vocabulary verification: source=$source_en_count/$source_me_count, system=$system_en_count/$system_me_count"
}

# Verify corrections status
verify_corrections_status() {
    log_detection "Checking corrections status"

    echo "🔍 VERIFYING CORRECTIONS STATUS..."
    echo ""

    local corrections_count=$(jq '. | length' "$PROJECT_ROOT/training_pairs.json" 2>/dev/null || echo "ERROR")
    local pending_count=$(jq '[.[] | select(.status == "pending_admin_review")] | length' "$PROJECT_ROOT/training_pairs.json" 2>/dev/null || echo "ERROR")
    local approved_count=$(jq '[.[] | select(.status == "approved_by_admin")] | length' "$PROJECT_ROOT/training_pairs.json" 2>/dev/null || echo "ERROR")
    local rejected_count=$(jq '[.[] | select(.status == "rejected_by_admin")] | length' "$PROJECT_ROOT/training_pairs.json" 2>/dev/null || echo "ERROR")

    echo "📊 CORRECTIONS ANALYSIS:"
    echo "Total corrections: $corrections_count"
    echo "Pending review: $pending_count"
    echo "Approved: $approved_count"
    echo "Rejected: $rejected_count"
    echo ""

    if [ "$pending_count" = "0" ]; then
        echo "❌ NO TEST DATA: Cannot test approve/reject functionality"
        echo "🚨 CLAUDE LIED: Claimed corrections fixed but removed all test data"
    else
        echo "✅ TEST DATA AVAILABLE: Can test approve/reject with $pending_count entries"
    fi

    log_detection "Corrections verification: total=$corrections_count, pending=$pending_count"
}

# Main verification dispatcher
case "${1:-help}" in
    "vocabulary")
        verify_vocabulary_corruption
        ;;
    "corrections")
        verify_corrections_status
        ;;
    "full")
        verify_vocabulary_corruption
        echo ""
        verify_corrections_status
        ;;
    "help"|*)
        echo "Claude Lie Detector - External verification system"
        echo ""
        echo "Usage: $0 {vocabulary|corrections|full}"
        echo ""
        echo "Commands:"
        echo "  vocabulary  - Verify vocabulary corruption fix claims"
        echo "  corrections - Verify corrections functionality claims"
        echo "  full        - Run all verifications"
        echo ""
        echo "This tool catches Claude's false claims and incomplete fixes."
        ;;
esac