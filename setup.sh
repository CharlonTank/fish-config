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

# Remove fisher-managed files so fisher can reinstall them cleanly
echo "Removing fisher-managed files before reinstall..."
rm -f "$FISH_DIR/functions/fisher.fish"
rm -f "$FISH_DIR/completions/fisher.fish"
rm -f "$FISH_DIR/functions/_nvm_index_update.fish"
rm -f "$FISH_DIR/functions/_nvm_list.fish"
rm -f "$FISH_DIR/functions/_nvm_version_activate.fish"
rm -f "$FISH_DIR/functions/_nvm_version_deactivate.fish"
rm -f "$FISH_DIR/functions/nvm.fish"
rm -f "$FISH_DIR/conf.d/nvm.fish"
rm -f "$FISH_DIR/completions/nvm.fish"
rm -f "$FISH_DIR/completions/asdf.fish"
rm -f "$FISH_DIR/conf.d/homebrew-apple-silicon.fish"
rm -f "$FISH_DIR/conf.d/github-copilot-cli.fish"
rm -f "$FISH_DIR/conf.d/wakatime.fish"

# Install fisher + plugins if fish is available
if command -v fish >/dev/null 2>&1; then
    echo "Installing fisher and plugins..."
    fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source; fisher update'
    echo "Done! Restart your shell."
else
    echo "Fish not installed. Install fish first, then run: fisher update"
fi
