# Chruby is automatically loaded via Fish vendor directories
# The following files are loaded automatically:
# /opt/homebrew/share/fish/vendor_functions.d/chruby*.fish
# /opt/homebrew/share/fish/vendor_conf.d/chruby_auto.fish
abbr -a gst git status
abbr -a gc git commit -am
abbr -a p git push
abbr -a pf git push --force
abbr -a dif git diff
abbr -a mast git checkout master
abbr -a main git checkout main
abbr -a stag 'git checkout public/styles.css; git checkout staging'
abbr -a l ls -la
abbr -a g git checkout
abbr -a gb 'git pull && git checkout -b'
abbr -a stash git stash
abbr -a pop 'git checkout public/styles.css; git stash pop'
abbr -a amend git commit --amend -a
abbr -a pl 'git checkout public/styles.css; git pull'
abbr -a gm 'git checkout public/styles.css; git merge'
abbr -a c 'claude --dangerously-skip-permissions'
abbr -a lm 'lamdera make src/Frontend.elm src/Backend.elm'
abbr -a et 'elm-test-rs --compiler /opt/homebrew/bin/lamdera'
abbr -a cpush 'claude --dangerously-skip-permissions "push"'
abbr -a bs 'killall lamdera; bun start'
abbr -a /qwe 'claude --dangerously-skip-permissions /qwe'
abbr -a /poi 'claude --dangerously-skip-permissions /poi'
abbr -a /qwe-fast 'claude --dangerously-skip-permissions /qwe-fast'
abbr -a /commit 'claude --dangerously-skip-permissions /commit'
abbr -a auto 'git checkout public/styles.css && git pull --rebase --autostash origin staging'
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

fish_add_path ~/.local/bin
fish_add_path $HOME/.local/bin

# Added by Antigravity
fish_add_path $HOME/.antigravity/antigravity/bin

function cfs
    switch $argv[1]
        case use ''
            cf-switch $argv | source
        case '*'
            cf-switch $argv
    end
end
