#!/bin/bash
# Quick setup - Clone and import in one command (macOS/Linux)
# Usage: curl -sL https://raw.githubusercontent.com/sermsak182/claude-config-sync/master/scripts/quick-setup.sh | bash
# Or:    ./scripts/quick-setup.sh [--source shared|hostname] [--export-after]

SOURCE="shared"
EXPORT_AFTER=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --source|-s) SOURCE="$2"; shift 2 ;;
        --export-after) EXPORT_AFTER=true; shift ;;
        *) shift ;;
    esac
done

REPO_URL="https://github.com/sermsak182/claude-config-sync.git"
INSTALL_PATH="$HOME/claude-config-sync"

echo ""
echo "========================================"
echo "  Quick Setup - Claude Config Sync"
echo "========================================"
echo ""

# Clone if not exists
if [ -d "$INSTALL_PATH" ]; then
    echo "[INFO] Repository exists, pulling latest..."
    cd "$INSTALL_PATH" && git pull
else
    echo "[INFO] Cloning repository..."
    git clone "$REPO_URL" "$INSTALL_PATH"
fi

# Import
echo ""
echo "[INFO] Importing config from: $SOURCE"
bash "$INSTALL_PATH/scripts/import.sh" --source "$SOURCE"

# Export if requested
if $EXPORT_AFTER; then
    echo ""
    echo "[INFO] Exporting current machine config..."
    bash "$INSTALL_PATH/scripts/export.sh" "$INSTALL_PATH"

    cd "$INSTALL_PATH" || exit 1
    HOSTNAME=$(hostname -s)
    git add .
    git commit -m "feat: add $HOSTNAME config"
    git push
fi

echo ""
echo "========================================"
echo "  Setup Complete!"
echo "========================================"
echo ""
echo "Location: $INSTALL_PATH"
echo "Restart VS Code to apply changes"
