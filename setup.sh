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
    # Remove fisher-managed files so fisher can reinstall them cleanly
    fish -c '
        set fisher_managed \
            functions/fisher.fish \
            completions/fisher.fish \
            functions/_nvm_index_update.fish \
            functions/_nvm_list.fish \
            functions/_nvm_version_activate.fish \
            functions/_nvm_version_deactivate.fish \
            functions/nvm.fish \
            conf.d/nvm.fish \
            completions/nvm.fish \
            completions/asdf.fish \
            conf.d/homebrew-apple-silicon.fish \
            conf.d/github-copilot-cli.fish \
            conf.d/wakatime.fish

        for f in $fisher_managed
            set -l path ~/.config/fish/$f
            if test -f $path
                rm $path
            end
        end

        curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
        fisher update
    '
    echo "Done! Restart your shell."
else
    echo "Fish not installed. Install fish first, then run: fisher update"
fi
