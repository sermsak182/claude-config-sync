#!/bin/bash
# Sync config with GitHub (macOS/Linux)
# Usage: ./scripts/sync.sh [--pull-only] [--push-only]

REPO_PATH="$(cd "$(dirname "$0")/.." && pwd)"
PULL_ONLY=false
PUSH_ONLY=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --pull-only) PULL_ONLY=true; shift ;;
        --push-only) PUSH_ONLY=true; shift ;;
        *) shift ;;
    esac
done

HOSTNAME=$(hostname -s)

echo ""
echo "========================================"
echo "  Config Sync - $HOSTNAME"
echo "========================================"
echo ""

cd "$REPO_PATH" || exit 1

# Pull latest
if ! $PUSH_ONLY; then
    echo "[INFO] Pulling latest from GitHub..."
    if git pull --rebase; then
        echo "[OK] Pull complete"
    else
        echo "[WARN] Pull had issues, check manually"
    fi
fi

if $PULL_ONLY; then
    echo ""
    echo "[INFO] Pull-only mode, skipping export/push"
    exit 0
fi

# Export current config
echo ""
echo "[INFO] Exporting current config..."
bash "$REPO_PATH/scripts/export.sh" "$REPO_PATH"

# Check for changes
if [ -z "$(git status --porcelain)" ]; then
    echo ""
    echo "[INFO] No changes to sync"
    exit 0
fi

# Commit and push
echo ""
echo "[INFO] Committing changes..."
git add .
git commit -m "sync($HOSTNAME): $(date '+%Y-%m-%d %H:%M')"

echo ""
echo "[INFO] Pushing to GitHub..."
if git push; then
    echo ""
    echo "========================================"
    echo "  Sync Complete!"
    echo "========================================"
else
    echo "[ERROR] Push failed"
fi
