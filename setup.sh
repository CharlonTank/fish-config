#!/bin/bash
# Setup fish config on a new machine
# Usage: curl -sL https://raw.githubusercontent.com/CharlonTank/fish-config/main/setup.sh | bash

set -e

FISH_DIR="$HOME/.config/fish"

# Backup existing config if present
if [ -d "$FISH_DIR" ] && [ ! -d "$FISH_DIR/.git" ]; then
    echo "Backing up existing fish config to $FISH_DIR.bak"
    mv "$FISH_DIR" "$FISH_DIR.bak"
fi

# Clone the repo
if [ ! -d "$FISH_DIR/.git" ]; then
    git clone https://github.com/CharlonTank/fish-config.git "$FISH_DIR"
else
    echo "Fish config repo already exists, pulling latest..."
    git -C "$FISH_DIR" pull --rebase
fi

# Install fisher + plugins if fish is available
if command -v fish >/dev/null 2>&1; then
    echo "Installing fisher and plugins..."
    fish -c '
        if not functions -q fisher
            curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
            fisher install jorgebucaran/fisher
        end
        fisher update
    '
    echo "Done! Restart your shell."
else
    echo "Fish not installed. Install fish first, then run: fisher update"
fi
