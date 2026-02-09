if status is-interactive
    git -C ~/.config/fish pull --rebase &>/dev/null &
    disown
end
