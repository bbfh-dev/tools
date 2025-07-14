#!/usr/bin/bash

selected=$(ls ~/Public/junction/ | nl -w1 -s'. ' | fzf --margin 10% --padding 10% --style=minimal --layout=reverse-list)
if [[ -z $selected ]]; then
    return
fi
selected=${selected#*'. '}

~/Public/junction/$selected
