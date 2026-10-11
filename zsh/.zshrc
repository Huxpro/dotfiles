# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

# bullet-like, but it handle git sync-ly and becomes condiferably slow.
# ZSH_THEME="agnoster"

# a fork of <https://github.com/sindresorhus/pure>
ZSH_THEME="refined-lambda"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-syntax-highlighting
  # zsh-autosuggestions
  zsh-completions
)

# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# https://github.com/zsh-users/zsh-completions
#plugins=(zsh-completions)

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

FPATH="/opt/homebrew/share/zsh/site-functions:${FPATH}"

source $ZSH/oh-my-zsh.sh
# source ~/.oh-my-zsh/plugins/incr/incr*.zsh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

HISTSIZE=10000
HISTFILESIZE=10000

#####################################
# alias
#####################################

# highlight dir from file
alias ls='ls -FHG'

# vim
export EDITOR=vim
export GIT_EDITOR=vim

# grep (recursive, linenum)
alias greprn='grep -rn'

# echo $PATH line by line
alias echopath='tr ":" "\n" <<< "$PATH"'


# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# permission
alias sudolocalbin='sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/sbin'

# =============================================
# Agent aliases
# cc/cx/tt = 裸跑（全权限，当前 shell）
# *x       = tmux 版（iTerm native 窗口）
# *a       = attach, *ls = list, *k = kill
# =============================================

# --- Claude Code ---
alias cc='claude --dangerously-skip-permissions'
alias yolo='claude --dangerously-skip-permissions'

# ccx [name] — 开新 CC tmux session
function ccx {
  local name="${1:-$(basename $(pwd))}"
  shift 2>/dev/null
  tmux -CC new-session -s "cc-${name}" "claude --dangerously-skip-permissions $*"
}

# cca [name] — attach 已有 CC session
function cca {
  if [[ -n "$1" ]]; then
    tmux -CC attach -d -t "cc-$1"
  else
    local s=$(tmux ls -F '#{session_name}' 2>/dev/null | grep '^cc-' | fzf --prompt="attach> ")
    [[ -n "$s" ]] && tmux -CC attach -d -t "$s"
  fi
}

alias ccls='tmux ls 2>/dev/null | grep "^cc-" || echo "no cc sessions"'

function cck {
  if [[ -n "$1" ]]; then
    tmux kill-session -t "cc-$1"
  else
    local s=$(tmux ls -F '#{session_name}' 2>/dev/null | grep '^cc-' | fzf --prompt="kill> ")
    [[ -n "$s" ]] && tmux kill-session -t "$s"
  fi
}

# Back-compat for older muscle memory.
alias ccxa=cca
alias ccxls=ccls
alias ccxk=cck

# --- Codex ---
alias cx='codex -a never -s danger-full-access'

# cxx [name] — 开新 Codex tmux session
function cxx {
  local name="${1:-$(basename $(pwd))}"
  shift 2>/dev/null
  tmux -CC new-session -s "cx-${name}" "codex -a never -s danger-full-access $*"
}

function cxa {
  if [[ -n "$1" ]]; then
    tmux -CC attach -d -t "cx-$1"
  else
    local s=$(tmux ls -F '#{session_name}' 2>/dev/null | grep '^cx-' | fzf --prompt="attach> ")
    [[ -n "$s" ]] && tmux -CC attach -d -t "$s"
  fi
}

alias cxls='tmux ls 2>/dev/null | grep "^cx-" || echo "no cx sessions"'

function cxk {
  if [[ -n "$1" ]]; then
    tmux kill-session -t "cx-$1"
  else
    local s=$(tmux ls -F '#{session_name}' 2>/dev/null | grep '^cx-' | fzf --prompt="kill> ")
    [[ -n "$s" ]] && tmux kill-session -t "$s"
  fi
}

# Back-compat for older muscle memory.
alias cxxa=cxa
alias cxxls=cxls
alias cxxk=cxk

# --- Trae ---
alias tt='traecli -y'

# ttx [name] — 开新 Trae tmux session
function ttx {
  local name="${1:-$(basename $(pwd))}"
  shift 2>/dev/null
  tmux -CC new-session -s "tt-${name}" "traecli -y $*"
}

function tta {
  if [[ -n "$1" ]]; then
    tmux -CC attach -d -t "tt-$1"
  else
    local s=$(tmux ls -F '#{session_name}' 2>/dev/null | grep '^tt-' | fzf --prompt="attach> ")
    [[ -n "$s" ]] && tmux -CC attach -d -t "$s"
  fi
}

alias ttls='tmux ls 2>/dev/null | grep "^tt-" || echo "no tt sessions"'

function ttk {
  if [[ -n "$1" ]]; then
    tmux kill-session -t "tt-$1"
  else
    local s=$(tmux ls -F '#{session_name}' 2>/dev/null | grep '^tt-' | fzf --prompt="kill> ")
    [[ -n "$s" ]] && tmux kill-session -t "$s"
  fi
}

# Back-compat for the old Trae naming.
# (no `tr` alias: it shadows /usr/bin/tr and breaks `echopath` and scripts)
alias trx=ttx
alias trxa=tta
alias trxls=ttls
alias trxk=ttk

# colorful stderr
# https://serverfault.com/questions/59262/bash-print-stderr-in-red-color
# color()(set -o pipefail;"$@" 2>&1>&3|sed $'s,.*,\e[31m&\e[m,'>&2)3>&1
color()(set -o pipefail;"$@" 2>&1 1>&3|sed $'s,.*,\e[31m&\e[m,'1>&2)3>&1

# redefine prompt_context for hiding user@hostname
prompt_context () { }


#####################################
# iTerm - macOS dark mode awareness
# https://apas.gr/2018/11/dark-mode-macos-safari-iterm-vim/
#####################################

if [[ "$(uname -s)" == "Darwin" ]]; then
    sith() {
        val=$(defaults read -g AppleInterfaceStyle 2>/dev/null)
        if [[ $val == "Dark" ]]; then
            i
        fi
    }

    i() {
        if [[ $ITERM_PROFILE == "Default" ]]; then
            echo -ne "\033]50;SetProfile=Dark\a"
            export ITERM_PROFILE="Dark"
        else
            echo -ne "\033]50;SetProfile=Default\a"
            export ITERM_PROFILE="Default"
        fi
    }

    # only talk to iTerm, and only when stdout is a terminal
    if [[ -t 1 && ( "$TERM_PROGRAM" == "iTerm.app" || -n "$ITERM_SESSION_ID" ) ]]; then
        sith
    fi
fi

alias iterm-dark-mode="i"



#####################################
# auto-fu, insta productivity boost 2
#####################################

# npm/make/brew autocompletions are super slow. Disable them so that auto-fu's
# completion doesn't trigger for these
noopt() {}
compdef noopt npm make brew
# enable completion for these commands.
compdef _gnu_generic yarn

# nvm lazy load (~1s savings)
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  # Add nvm's node to PATH immediately (no waiting for full nvm load): the
  # newest install matching `nvm alias default`, else the newest install.
  () {
    local def="$(cat "$NVM_DIR/alias/default" 2>/dev/null)"
    local -a found
    [[ "$def" == (v|)<->(|.<->)(|.<->) ]] && found=("$NVM_DIR"/versions/node/v${def#v}(|.*)(N/nOn))
    (( $#found )) || found=("$NVM_DIR"/versions/node/v*(N/nOn))
    (( $#found )) && PATH="$found[1]/bin:$PATH"
  }
  # Lazy-load nvm itself on first use. NVM_DIR is re-derived because shells
  # that inherit these functions do not always inherit the variable.
  _nvm_lazy_load() {
    unset -f nvm node npm npx _nvm_lazy_load
    export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
    \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  }
  nvm() { _nvm_lazy_load; nvm "$@"; }
  node() { _nvm_lazy_load; node "$@"; }
  npm() { _nvm_lazy_load; npm "$@"; }
  npx() { _nvm_lazy_load; npx "$@"; }
fi

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export PATH=$HOME/.local/bin:$PATH

command -v direnv >/dev/null && eval "$(direnv hook zsh)"

# --- BEGIN FEDERATED REPO GIT TELEMETRY CODE BLOCK ---
# https://bytedance.sg.larkoffice.com/docx/SurId67UBoZxHwxe07Clr5Ufgog

export FEDERATED_REPO_GIT_TELEMETRY_VERSION=1.2.0
# export GIT_TRACE2_EVENT="$HOME/.trace2/event"
# export GIT_TRACE2_EVENT_BRIEF=true
# export GIT_TRACE2_MAX_FILES=100000

# --- END FEDERATED REPO GIT TELEMETRY CODE BLOCK ---

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Codex defaults (no network sandbox)
# codex alias now covered by `cx` above
# alias codex="codex -a never -s danger-full-access"

# Trae CLI default no-confirm mode
# traecli alias now covered by `tt` above
# alias traecli='traecli --yolo'

export PATH=$PATH:$HOME/bin
export PATH="$HOME/byted/template-assembler/buildtools/clang-format:$PATH"

# Added by coco installer
export PATH="$HOME/.local/bin:$PATH"

# OpenClaw Completion
[ -f "$HOME/.openclaw/completions/openclaw.zsh" ] && source "$HOME/.openclaw/completions/openclaw.zsh"
