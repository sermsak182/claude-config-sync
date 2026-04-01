#!/bin/bash
# Export Claude Code and VS Code config from current machine (macOS/Linux)
# Usage: ./scripts/export.sh [repo_path]

REPO_PATH="${1:-$(cd "$(dirname "$0")/.." && pwd)}"
HOSTNAME=$(hostname -s)
MACHINE_PATH="$REPO_PATH/machines/$HOSTNAME"

echo ""
echo "========================================"
echo "  Config Export - $HOSTNAME ($(uname -s))"
echo "========================================"
echo ""

# Create machine folder
mkdir -p "$MACHINE_PATH"
echo "[OK] Machine folder: machines/$HOSTNAME"

# --- Claude config ---
CLAUDE_CONFIG="$HOME/.claude"
CLAUDE_DEST="$MACHINE_PATH/claude"

echo "[INFO] Exporting Claude config..."
if [ -d "$CLAUDE_CONFIG" ]; then
    mkdir -p "$CLAUDE_DEST"

    # Copy CLAUDE.md files
    for f in "$CLAUDE_CONFIG"/*.md; do
        [ -f "$f" ] || continue
        cp "$f" "$CLAUDE_DEST/"
        echo "[OK] Exported: $(basename "$f")"
    done

    # Copy settings.json (skip if contains secrets)
    if [ -f "$CLAUDE_CONFIG/settings.json" ]; then
        if ! grep -qiE 'api[_-]?key|secret|token|password' "$CLAUDE_CONFIG/settings.json"; then
            cp "$CLAUDE_CONFIG/settings.json" "$CLAUDE_DEST/"
            echo "[OK] Exported: settings.json"
        else
            echo "[SKIP] settings.json contains sensitive data"
        fi
    fi

    # Copy commands/ (custom skills)
    if [ -d "$CLAUDE_CONFIG/commands" ]; then
        mkdir -p "$CLAUDE_DEST/commands"
        cp -R "$CLAUDE_CONFIG/commands/"* "$CLAUDE_DEST/commands/" 2>/dev/null
        CMD_COUNT=$(find "$CLAUDE_CONFIG/commands" -type f | wc -l | tr -d ' ')
        echo "[OK] Exported: commands/ ($CMD_COUNT skills)"
    fi
else
    echo "[INFO] No Claude config found at $CLAUDE_CONFIG"
fi

# --- VS Code config ---
echo ""
echo "[INFO] Exporting VS Code config..."
VSCODE_DEST="$MACHINE_PATH/vscode"
mkdir -p "$VSCODE_DEST"

# macOS VS Code paths
VSCODE_USER="$HOME/Library/Application Support/Code/User"

if [ -f "$VSCODE_USER/settings.json" ]; then
    cp "$VSCODE_USER/settings.json" "$VSCODE_DEST/"
    echo "[OK] Exported: settings.json"
fi

if [ -f "$VSCODE_USER/keybindings.json" ]; then
    cp "$VSCODE_USER/keybindings.json" "$VSCODE_DEST/"
    echo "[OK] Exported: keybindings.json"
fi

if [ -d "$VSCODE_USER/snippets" ]; then
    mkdir -p "$VSCODE_DEST/snippets"
    cp -R "$VSCODE_USER/snippets/"* "$VSCODE_DEST/snippets/" 2>/dev/null
    echo "[OK] Exported: snippets/"
fi

# --- Extensions list ---
echo ""
echo "[INFO] Exporting extensions list..."
EXT_FILE="$MACHINE_PATH/extensions.txt"
if command -v code &>/dev/null; then
    code --list-extensions > "$EXT_FILE"
    EXT_COUNT=$(wc -l < "$EXT_FILE" | tr -d ' ')
    echo "[OK] Exported: extensions.txt ($EXT_COUNT extensions)"
else
    echo "[WARN] VS Code CLI (code) not found, skipping extensions"
fi

# --- Machine info ---
INFO_FILE="$MACHINE_PATH/machine-info.json"
cat > "$INFO_FILE" <<EOF
{
  "hostname": "$HOSTNAME",
  "os": "$(uname -s)",
  "arch": "$(uname -m)",
  "exported_at": "$(date '+%Y-%m-%d %H:%M:%S')"
}
EOF
echo "[OK] Exported: machine-info.json"

echo ""
echo "========================================"
echo "  Export Complete!"
echo "========================================"
echo ""
echo "Location: machines/$HOSTNAME/"
echo "Next: git add . && git commit && git push"
