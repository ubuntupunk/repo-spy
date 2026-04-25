#!/usr/bin/env bash

# Copyright (c) 2024 @ubuntupunk. All rights reserved.
# Install repo-spy: collector + dashboard

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BIN_DIR="$HOME/.local/bin"
DATA_DIR="$HOME/.repo-spy"

echo "repo-spy installer"
echo "──────────────────"

mkdir -p "$BIN_DIR"
mkdir -p "$DATA_DIR"

echo "Installing repo-spy collector → $BIN_DIR/repo-spy"
cp "$SCRIPT_DIR/repo-spy" "$BIN_DIR/repo-spy"
chmod +x "$BIN_DIR/repo-spy"

echo "Installing repo-spy-dashboard → $BIN_DIR/repo-spy-dashboard"
cp "$SCRIPT_DIR/repo-spy-dashboard" "$BIN_DIR/repo-spy-dashboard"
chmod +x "$BIN_DIR/repo-spy-dashboard"

echo "Installing dashboard UI → $DATA_DIR/index.html"
cp "$SCRIPT_DIR/index.html" "$DATA_DIR/index.html"

if [ ! -f "$DATA_DIR/config" ]; then
    if [ -f "$SCRIPT_DIR/config" ]; then
        echo "Installing config → $DATA_DIR/config"
        cp "$SCRIPT_DIR/config" "$DATA_DIR/config"
    else
        cat > "$DATA_DIR/config" << 'EXAMPLE'
# repo-spy config — one repo path per line
# $HOME/Projects/my-repo
# $HOME/Projects/another-repo
EXAMPLE
        echo ""
        echo "⚠  No repos configured yet!"
        echo "   Edit $DATA_DIR/config and add your repo paths."
        echo ""
    fi
fi

echo "Done! Commands available:"
echo "  repo-spy            — collect repo data"
echo "  repo-spy-dashboard  — collect + serve dashboard on :7777"
echo ""
echo "Next steps:"
echo "  1. Add repos to $DATA_DIR/config"
echo "  2. Run: repo-spy-dashboard"
