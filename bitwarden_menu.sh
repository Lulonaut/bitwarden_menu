#!/bin/sh

ITEM_PATH=~/applications/bitwarden_items
master_password=$(secret-tool lookup bitwarden password)

selection=$(cat "$ITEM_PATH" | dmenu)


function sync_bw() {
    bw sync
    bw list items | jq '.[].name' -M -r > "$ITEM_PATH"
    exit 0
}

export BW_SESSION=$(bw unlock "$master_password" --raw)
[ "$1" == "sync" ] && sync_bw

target="$1"
[ -z "$target" ] && exit 1
[ -z "$selection" ] && exit 1

password=$(bw get "$target" "$selection" | tr -d '\n')
[ $? -eq 0 ] && printf "%s" "$password" | xclip -sel clip

[ "$2" == "copy" ] && (notify-send "Success!" "$selection $target copied to clipboard") || (xdotool key --clearmodifiers Shift+Insert  && notify-send "Success!" "$selection $target pasted & copied to clipboard!" --icon=task-past-due) || notify-send "Error!" "$selection doesn't exist!" --icon=dialog-error

sync_bw
