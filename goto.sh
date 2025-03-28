#!/usr/bin/env dash
# I made this script to easily navigate to any of my git repositories

RECENT=~/.config/shell/recent_project

goto() {
	# ln -s $1 ~/.local/share/scripts/latest
	clear
	rm -rf $RECENT
	ln -s $1 $RECENT
	echo "-> $1"
	cd -P $1
}

if [[ $1 = "project" ]]; then
	selected=$({ find $GIT -mindepth 2 -maxdepth 2 -type d,l ; find ~/Documents/Godot -mindepth 1 -maxdepth 1 -type d,l ; } | fzf --scheme=path --algo=v2 --layout=reverse-list --margin 10% --padding 10%)
	if [[ -z $selected ]]; then
		return
	fi

	if [[ $(basename $selected) == +* || $selected == *.d ]]; then
		selected=$(find $selected -mindepth 1 -maxdepth 1 -type d,l | fzf --scheme=path --algo=v2 --layout=reverse-list --margin 10% --padding 10%)
	fi

	# Check if it's a bare repository
	if [[ -f $selected/HEAD ]]; then
		cd -P $selected
		branch=$(git worktree list | fzf --scheme=path --algo=v2 --layout=reverse-list --margin 10% --padding 10%)
		read -r first_argument _ <<< "$branch"
		goto $first_argument
	else
		goto $selected
	fi

	return
fi

if [[ $1 = "recent" ]]; then
	cd -P $RECENT
	return
fi

echo "Use one of the following commands: project, recent"
