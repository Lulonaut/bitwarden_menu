#!/bin/sh

ITEM_PATH=~/applications/bitwarden_items
master_password=$(secret-tool lookup bitwarden password)

selection=$(jq '.[].name' -M -r "$ITEM_PATH" | dmenu)


function sync_bw() {
    bw sync
    bw list items > "$ITEM_PATH"
    exit 0
}
[ "$1" == "sync" ] && sync_bw


export BW_SESSION=$(bw unlock "$master_password" --raw)
target="password"
[ "$1" == "username" ] && target="username"


[ -z "$selection" ] && exit 1

password=$(bw get "$target" "$selection" | tr -d '\n')
[ $? -eq 0 ] && (printf "%s" "$password" | xclip -sel clip && xdotool key --clearmodifiers Shift+Insert  && notify-send "Success!" "$selection $target pasted & copied to clipboard!" --icon=task-past-due) || notify-send "Error!" "$selection doesn't exist!" --icon=dialog-error

sync_bw
