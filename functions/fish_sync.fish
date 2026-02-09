function fish_sync --description "Sync fish config with GitHub"
    set -l fish_dir ~/.config/fish

    switch $argv[1]
        case push
            git -C $fish_dir add -A
            git -C $fish_dir commit -m "sync: $(hostname) $(date '+%Y-%m-%d %H:%M')"
            git -C $fish_dir push
        case pull
            git -C $fish_dir pull --rebase
            # Reinstall fisher plugins if fish_plugins changed
            if git -C $fish_dir diff HEAD@{1} --name-only 2>/dev/null | grep -q fish_plugins
                echo "fish_plugins changed, running fisher update..."
                fisher update
            end
        case ''
            # Default: pull then push (full sync)
            fish_sync pull
            fish_sync push
        case '*'
            echo "Usage: fish_sync [pull|push]"
            echo "  (no args) = pull + push"
            echo "  pull      = pull latest from GitHub"
            echo "  push      = commit and push local changes"
    end
end
