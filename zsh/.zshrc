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

# alias vim to neovim
if [ -x "$(command -v nvim)" ]; then
  # nvim will still invoke nvim stable
  alias nvimnightly='~/nvim-nightly/bin/nvim'  # neovim nightly
  alias vi='nvimnightly'
  alias vim='nvimnightly'
  alias vim8='\vim' # vim 8.1
fi

# vim
EDITOR=vim
GIT_EDITOR=vim

# emacs (open in new instance)
alias emacs='open -n -a Emacs.app .'
alias emacsterm='\emacs-26.2'
alias oldemacs='\emacs'

# rlwrap
alias sml='rlwrap sml'
alias jake='rlwrap jake'
alias uscheme='rlwrap uscheme'
alias scheme='rlwrap scheme'
alias racket='rlwrap racket'

# grep (recursive, linenum)
alias greprn='grep -rn'

# reason
alias mlre='pbpaste | refmt --parse ml --print re | pbcopy'
alias reml='pbpaste | refmt --parse re --print ml | pbcopy'
alias prtop='pbpaste | rtop'

# echo $PATH line by line
alias echopath='tr ":" "\n" <<< "$PATH"'

# cloc coq .v
alias clocv='cloc --by-file-by-lang --match-f=v --exclude-dir="Lib" .'

# langfc
alias fc='./bin/langfc -Ckeep-convert-to-reploc=true -Ckeep-vm-codegen=true'


# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# permission
alias sudolocalbin='sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/sbin'

# claude
alias yolo='claude --dangerously-skip-permissions'

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

    sith
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
# See https://github.com/zsh-users/zsh-completions/blob/master/zsh-completions-howto.org#completing-generic-gnu-commands
compdef _gnu_generic bsc bsb ocamlc yarn

# https://github.com/hchbaw/auto-fu.zsh
# Fork with cleaned-up readme:
# https://github.com/HerringtonDarkholme/auto-fu.zsh

# make sure history-substring-match is disabled (crashes window with auto-fu).
# auto-fu master currently unstable. Use the `pu` branch instead

# git clone https://github.com/HerringtonDarkholme/auto-fu.zsh ~/.auto-fu
# cd ~/.auto-fu
# git checkout pu

# below is commented out to to turn off auto-fu.
# the main issue is mis-match and performance
# using ** for FZF for some cases instead

# if [ -f ~/.auto-fu/auto-fu.zsh ]; then
#   source ~/.auto-fu/auto-fu.zsh
#   function zle-line-init () {
#     auto-fu-init
#   }
#   zle -N zle-line-init
#   zstyle ':completion:*' completer _oldlist _complete
# fi
# zstyle ':auto-fu:var' postdisplay $''

# nvm lazy load (~1s savings)
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  # Add nvm's node to PATH immediately (no waiting for full nvm load)
  [ -d "$NVM_DIR/versions/node" ] && PATH="$(ls -d "$NVM_DIR/versions/node"/*/bin 2>/dev/null | tail -1):$PATH"
  # Lazy-load nvm itself on first use
  nvm() {
    unset -f nvm node npm npx
    \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm "$@"
  }
  node() { unset -f nvm node npm npx; \. "$NVM_DIR/nvm.sh"; node "$@"; }
  npm() { unset -f nvm node npm npx; \. "$NVM_DIR/nvm.sh"; npm "$@"; }
  npx() { unset -f nvm node npm npx; \. "$NVM_DIR/nvm.sh"; npx "$@"; }
fi

# pnpm
export PNPM_HOME="/Users/bytedance/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export PATH=$HOME/.local/bin:$PATH

eval "$(direnv hook zsh)"

# --- BEGIN FEDERATED REPO GIT TELEMETRY CODE BLOCK ---
# https://bytedance.sg.larkoffice.com/docx/SurId67UBoZxHwxe07Clr5Ufgog

export FEDERATED_REPO_GIT_TELEMETRY_VERSION=1.2.0
# export GIT_TRACE2_EVENT="$HOME/.trace2/event"
# export GIT_TRACE2_EVENT_BRIEF=true
# export GIT_TRACE2_MAX_FILES=100000

# --- END FEDERATED REPO GIT TELEMETRY CODE BLOCK ---

# bun completions
[ -s "/Users/bytedance/.bun/_bun" ] && source "/Users/bytedance/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
