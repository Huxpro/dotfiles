#!/usr/bin/env zsh

# ------------------------------------------------------------------------------
#
# Pure - A minimal and beautiful theme for oh-my-zsh
#
# Based on the custom Zsh-prompt of the same name by Sindre Sorhus. A huge
# thanks goes out to him for designing the fantastic Pure prompt in the first
# place! I'd also like to thank Julien Nicoulaud for his "nicoulaj" theme from
# which I've borrowed both some ideas and some actual code. You can find out
# more about both of these fantastic two people here:
#
# Sindre Sorhus
#   Github:   https://github.com/sindresorhus
#   Twitter:  https://twitter.com/sindresorhus
#
# Julien Nicoulaud
#   Github:   https://github.com/nicoulaj
#   Twitter:  https://twitter.com/nicoulaj
#
# ------------------------------------------------------------------------------

# Set required options
#
setopt prompt_subst

# Load required modules
#
autoload -Uz vcs_info add-zsh-hook
zmodload zsh/datetime  # $EPOCHSECONDS, so timing a command needs no `date` fork

# Set vcs_info parameters
#
zstyle ':vcs_info:*' enable hg git
zstyle ':vcs_info:*:*' unstagedstr '!'
zstyle ':vcs_info:*:*' stagedstr '+'
zstyle ':vcs_info:*:*' formats "$FX[bold]%r$FX[no-bold]/%S" "%s/%b" "%%u%c"
zstyle ':vcs_info:*:*' actionformats "$FX[bold]%r$FX[no-bold]/%S" "%s/%b" "%u%c (%a)"
zstyle ':vcs_info:*:*' nvcsformats "%~" "" ""

# Fastest possible way to check if repo is dirty.
# vcs_info already knows whether we're in a git repo, so outside of one this
# costs nothing, and inside one it's a single `git diff` (no subshells).
#
_refined_lambda_git_dirty() {
    REPLY=
    [[ $vcs_info_msg_1_ == git/* ]] || return
    command git diff --quiet --ignore-submodules HEAD &>/dev/null
    (( $? == 1 )) && REPLY="*"
}

# Get the initial timestamp for the exec time of the last command
#
_refined_lambda_preexec() {
    cmd_timestamp=$EPOCHSECONDS
}

# Output additional information about paths, repos and exec time
#
_refined_lambda_precmd() {
    vcs_info # Get version control info before we start outputting stuff

    local elapsed=$(( EPOCHSECONDS - ${cmd_timestamp:-$EPOCHSECONDS} ))
    local exec_time=
    (( elapsed > 5 )) && exec_time="${elapsed}s"
    unset cmd_timestamp

    local REPLY
    _refined_lambda_git_dirty

    print -P "\n%F{blue}${vcs_info_msg_0_%%/.} %F{8}$vcs_info_msg_1_$REPLY $vcs_info_msg_2_%f %F{yellow}$exec_time%f"
}

add-zsh-hook preexec _refined_lambda_preexec
add-zsh-hook precmd _refined_lambda_precmd

# Define prompts
#
#PROMPT="%(?.%F{magenta}.%F{red})❯%f " # Display a red prompt char on failure
PROMPT="%(?.%F{magenta}.%F{red})λ%f " # Display a red prompt char on failure
RPROMPT="%F{8}${SSH_TTY:+%n@%m}%f"    # Display username if connected via SSH

# ------------------------------------------------------------------------------
#
# List of vcs_info format strings:
#
# %b => current branch
# %a => current action (rebase/merge)
# %s => current version control system
# %r => name of the root directory of the repository
# %S => current path relative to the repository root directory
# %m => in case of Git, show information about stashes
# %u => show unstaged changes in the repository
# %c => show staged changes in the repository
#
# List of prompt format strings:
#
# prompt:
# %F => color dict
# %f => reset color
# %~ => current path
# %* => time
# %n => username
# %m => shortname host
# %(?..) => prompt conditional - %(condition.true.false)
#
# ------------------------------------------------------------------------------
