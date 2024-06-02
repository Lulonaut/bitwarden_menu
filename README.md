# Bitwarden Menu

Simple script to access bitwarden elements in the command line

## Setup

- Install the [Bitwarden CLI](https://bitwarden.com/help/cli/), dmenu and xdotool
- Store your bitwarden master password in your default keyring under the key `bitwarden`.
Alternatively, edit the line with the secret-tool lookup, eg: `master_password=mypassword`
- Edit `ITEM_PATH` to anything you see fit, but make sure to create the file. This is the cache for all available bitwarden items
- For the initial setup: `bitwarden_menu sync`

## Usage
To retreive a password or username: `bitwarden_menu password/username [copy]`

By default the result will be copied to the clipboard and pasted (by emulating Shift+Insert with xdotool). 
If you just want to copy the result to the clipboard, add `copy`, like shown above.