#!/bin/bash
# Import Claude Code and VS Code config to current machine (macOS/Linux)
# Usage: ./scripts/import.sh [--source shared|hostname] [--dry-run]

REPO_PATH="$(cd "$(dirname "$0")/.." && pwd)"
SOURCE="shared"
DRY_RUN=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --source|-s) SOURCE="$2"; shift 2 ;;
        --dry-run|-n) DRY_RUN=true; shift ;;
        *) shift ;;
    esac
done

HOSTNAME=$(hostname -s)

echo ""
echo "========================================"
echo "  Config Import - $HOSTNAME"
echo "  Source: $SOURCE"
$DRY_RUN && echo "  [DRY RUN MODE]"
echo "========================================"
echo ""

# Determine source path
if [ "$SOURCE" = "shared" ]; then
    SOURCE_PATH="$REPO_PATH/shared"
else
    SOURCE_PATH="$REPO_PATH/machines/$SOURCE"
fi

if [ ! -d "$SOURCE_PATH" ]; then
    echo "[ERROR] Source not found: $SOURCE_PATH"
    exit 1
fi

# Target paths
CLAUDE_CONFIG="$HOME/.claude"
VSCODE_USER="$HOME/Library/Application Support/Code/User"

# --- Import Claude config ---
CLAUDE_SOURCE="$SOURCE_PATH/claude"
if [ -d "$CLAUDE_SOURCE" ]; then
    echo "[INFO] Importing Claude config..."
    if ! $DRY_RUN; then
        mkdir -p "$CLAUDE_CONFIG"
    fi

    for f in "$CLAUDE_SOURCE"/*; do
        [ -f "$f" ] || continue
        FNAME=$(basename "$f")
        DEST="$CLAUDE_CONFIG/$FNAME"
        if $DRY_RUN; then
            echo "[DRY] Would copy: $FNAME -> $DEST"
        else
            # Backup existing
            [ -f "$DEST" ] && cp "$DEST" "$DEST.backup"
            cp "$f" "$DEST"
            echo "[OK] Imported: $FNAME"
        fi
    done
else
    echo "[INFO] No Claude config in source"
fi

# --- Import VS Code config ---
VSCODE_SOURCE="$SOURCE_PATH/vscode"
if [ -d "$VSCODE_SOURCE" ]; then
    echo ""
    echo "[INFO] Importing VS Code config..."

    if ! $DRY_RUN; then
        mkdir -p "$VSCODE_USER"
    fi

    # Settings
    if [ -f "$VSCODE_SOURCE/settings.json" ]; then
        DEST="$VSCODE_USER/settings.json"
        if $DRY_RUN; then
            echo "[DRY] Would copy: settings.json -> $DEST"
        else
            [ -f "$DEST" ] && cp "$DEST" "$DEST.backup" && echo "[OK] Backed up existing settings"
            cp "$VSCODE_SOURCE/settings.json" "$DEST"
            echo "[OK] Imported: settings.json"
        fi
    fi

    # Keybindings
    if [ -f "$VSCODE_SOURCE/keybindings.json" ]; then
        DEST="$VSCODE_USER/keybindings.json"
        if $DRY_RUN; then
            echo "[DRY] Would copy: keybindings.json -> $DEST"
        else
            [ -f "$DEST" ] && cp "$DEST" "$DEST.backup"
            cp "$VSCODE_SOURCE/keybindings.json" "$DEST"
            echo "[OK] Imported: keybindings.json"
        fi
    fi

    # Snippets
    if [ -d "$VSCODE_SOURCE/snippets" ]; then
        DEST="$VSCODE_USER/snippets"
        if $DRY_RUN; then
            echo "[DRY] Would copy: snippets/ -> $DEST"
        else
            mkdir -p "$DEST"
            cp -R "$VSCODE_SOURCE/snippets/"* "$DEST/" 2>/dev/null
            echo "[OK] Imported: snippets/"
        fi
    fi
else
    echo "[INFO] No VS Code config in source"
fi

# --- Install extensions ---
EXT_FILE="$SOURCE_PATH/extensions.txt"
if [ -f "$EXT_FILE" ] && command -v code &>/dev/null; then
    echo ""
    echo "[INFO] Installing extensions..."
    while IFS= read -r ext; do
        [ -z "$ext" ] && continue
        if $DRY_RUN; then
            echo "[DRY] Would install: $ext"
        else
            code --install-extension "$ext" --force >/dev/null 2>&1
            echo "[OK] Installed: $ext"
        fi
    done < "$EXT_FILE"
fi

echo ""
echo "========================================"
echo "  Import Complete!"
echo "========================================"
echo ""

if ! $DRY_RUN; then
    echo "Restart VS Code to apply changes"
fi
