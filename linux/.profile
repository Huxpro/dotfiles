# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Keymap (X11 desktop sessions only; skip over ssh / on headless servers)
if [ -n "$DISPLAY" ] && command -v setxkbmap >/dev/null 2>&1; then
    setxkbmap -option 'caps:ctrl_modifier'
    setxkbmap -option 'ctrl:swap_lalt_lctl_lwin'

    command -v xcape >/dev/null 2>&1 && xcape -e 'Caps_Lock=Escape;Control_L=Escape;Control_R=Escape'
fi
