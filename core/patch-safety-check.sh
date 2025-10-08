#!/bin/bash
# PATCH SAFETY CHECK - Implements diff-driven workflow from RDS recommendations
# Prevents uncontrolled edits and enforces safe patch application

PATCH_LOG="/home/zch/devel/SpokenBlade/.claude/hooks/patch-safety.log"
PROJECT_ROOT="/home/zch/devel/SpokenBlade"

# Logging
log_patch() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] PATCH-SAFETY: $1" >> "$PATCH_LOG"
}

# Whitelist of files allowed for modification
ALLOWED_FILES=(
    "training_pairs.json"
    "vocabulary/en_to_me/standard/vocabulary.json"
    "vocabulary/me_to_en/standard/vocabulary.json"
    "vocabulary_optimized.db"
    ".devdata/current_state.md"
    ".issues/*.md"
    "templates/admin_dashboard_new.html"
    "vocab/codex_workspace/*.json"
    ".claude/hooks/*.sh"
    ".claude/agents/*.md"
)

# Check if file is whitelisted for modification
is_file_allowed() {
    local file_path="$1"
    local relative_path

    # Convert to relative path from project root
    if [[ "$file_path" == "$PROJECT_ROOT"* ]]; then
        relative_path="${file_path#$PROJECT_ROOT/}"
    else
        relative_path="$file_path"
    fi

    # Check against whitelist patterns
    for pattern in "${ALLOWED_FILES[@]}"; do
        if [[ "$relative_path" == $pattern ]]; then
            return 0  # Allowed
        fi
    done

    return 1  # Not allowed
}

# Validate a patch before application
validate_patch() {
    local patch_file="$1"

    if [ ! -f "$patch_file" ]; then
        echo "❌ Patch file not found: $patch_file"
        return 1
    fi

    log_patch "Validating patch: $patch_file"

    # Check if patch applies cleanly (dry run)
    if git apply --check "$patch_file" 2>/dev/null; then
        log_patch "Patch validation: PASSED"
        echo "✅ Patch validation: PASSED"
        return 0
    else
        log_patch "Patch validation: FAILED"
        echo "❌ Patch validation: FAILED - would not apply cleanly"
        return 1
    fi
}

# Apply patch with safety checks
apply_patch_safely() {
    local patch_file="$1"

    log_patch "Applying patch safely: $patch_file"

    # Step 1: Validate patch
    if ! validate_patch "$patch_file"; then
        echo "🚫 PATCH REJECTED: Failed validation"
        return 1
    fi

    # Step 2: Create backup
    local backup_dir="/tmp/spokenblade-patch-backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$backup_dir"

    # Extract files that would be modified from patch
    local modified_files
    modified_files=$(grep "^+++" "$patch_file" | sed 's/^+++ b\///' | head -20)

    echo "📋 Files to be modified:"
    for file in $modified_files; do
        # Check if file is whitelisted
        if is_file_allowed "$PROJECT_ROOT/$file"; then
            echo "  ✅ $file (allowed)"
            # Create backup
            if [ -f "$PROJECT_ROOT/$file" ]; then
                cp "$PROJECT_ROOT/$file" "$backup_dir/" 2>/dev/null || true
            fi
        else
            echo "  🚫 $file (NOT ALLOWED - not in whitelist)"
            log_patch "REJECTED: Attempt to modify non-whitelisted file: $file"
            return 1
        fi
    done

    # Step 3: Apply patch
    if git apply "$patch_file"; then
        log_patch "Patch applied successfully"
        echo "✅ Patch applied successfully"
        echo "💾 Backup created: $backup_dir"
        return 0
    else
        log_patch "Patch application failed"
        echo "❌ Patch application failed"
        return 1
    fi
}

# Create a patch from current changes
create_patch() {
    local patch_name="$1"

    if [ -z "$patch_name" ]; then
        patch_name="spokenblade-changes-$(date +%Y%m%d-%H%M%S).patch"
    fi

    local patch_file="/tmp/$patch_name"

    log_patch "Creating patch: $patch_file"

    # Create patch of current changes
    if git diff > "$patch_file"; then
        if [ -s "$patch_file" ]; then
            echo "📄 Patch created: $patch_file"
            echo "📋 Review the patch before applying"
            return 0
        else
            echo "ℹ️  No changes to create patch from"
            rm "$patch_file"
            return 1
        fi
    else
        log_patch "Failed to create patch"
        echo "❌ Failed to create patch"
        return 1
    fi
}

# Usage function
show_usage() {
    echo "Patch Safety Check - Diff-driven workflow enforcement"
    echo ""
    echo "Usage: $0 {validate|apply|create} [patch_file|patch_name]"
    echo ""
    echo "Commands:"
    echo "  validate <patch_file>  - Check if patch can be applied safely"
    echo "  apply <patch_file>     - Apply patch with safety checks"
    echo "  create [patch_name]    - Create patch from current changes"
    echo ""
    echo "Whitelisted file patterns:"
    for pattern in "${ALLOWED_FILES[@]}"; do
        echo "  • $pattern"
    done
}

# Main dispatcher
case "${1:-help}" in
    "validate")
        validate_patch "$2"
        ;;
    "apply")
        apply_patch_safely "$2"
        ;;
    "create")
        create_patch "$2"
        ;;
    "help"|*)
        show_usage
        ;;
esac