#!/usr/bin/dash
# I made this script to easily switch between different git credentials, because I happened to use many organizations

selected=$(find ~/.config/shell/ -iname "git.*" | xargs -n1 basename | fzf --scheme=path --algo=v2 --layout=reverse-list --margin 10% --padding 10%)

cp ~/.config/shell/$selected ~/.git-credentials
echo "Using .git-credentials of: $selected"
