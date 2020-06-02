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
# Alias (Hermes Dev Mac)
#####################################
 
# Re-configure
alias confighermes='./utils/build/configure.py ~/hermes-build'
alias confighermes-oss='./utils/build/configure.py ~/hermes-build-oss'

# CMake Build
alias cmakehermes='(cd ~/hermes-build && ninja)'
alias cmkhermes='cmakehermes'
alias cmakehermes-oss='(cd ~/hermes-build-oss && ninja)'
alias cmkhermes-oss='cmakehermes-oss'

# From Source (`her` for short)
alias herrepl='rlwrap ~/hermes-build/bin/hermes'
alias her='herrepl'
alias herrepl-oss='rlwrap ~/hermes-build-oss/bin/hermes'
alias her-oss='herrepl-oss'

# From JSVU
alias hermes-repl='rlwrap hermes-repl'

# Buck Build
alias buckhermes='buck build --out .hermes hermes'

# Buck Testing
alias testhermes='buck test //xplat/hermes/test:quick'
alias testhermesfull='buck test //xplat/hermes/...'

# Format
alias formathermes='./utils/format.sh'


#####################################
# Alias (FB)
#####################################

alias hgjf='echo ":wq" | hg commit --amend && jf s'

# change to a function so it can take a message parameter
#hgjf() {
#  echo ":wq" | hg commit --amend && jf s -s -m $1
#}

# alias node='~/fbsource/xplat/third-party/node/bin/node'

# a hux-ized machine
alias sshdev='ssh devvm433.atn0.facebook.com'

# a cleaner machine
alias sshdev2='ssh devvm2238.vll0.facebook.com'

# a CentOS7 machine
alias sshcent7='ssh devvm3030.prn2.facebook.com'

#####################################
# Alias
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

# alias vim='/usr/local/Cellar/vim/8.2.0654/bin/vim'

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

# ocaml / opam switch (upgrade to opam 2.0)
alias evalopamenv='eval $(opam env)'

# 4.02.3 for Reason/BuckleScript <=5 and Coq 8.4 (JSCert)
alias opamswitch402='opam switch reason && evalopamenv'

# 4.05.* for Coq 8.8.2 (Software Foundation)
alias opamswitch405='opam switch unsafe-str && evalopamenv'

# echo $PATH line by line
alias echopath='tr ":" "\n" <<< "$PATH"'

# cloc coq .v
alias clocv='cloc --by-file-by-lang --match-f=v --exclude-dir="Lib" .'

# langfc
alias fc='./bin/langfc -Ckeep-convert-to-reploc=true -Ckeep-vm-codegen=true'

# cling
alias cpprepl='cling'

# haskell
alias stack-all='ls $(stack path --programs)'

# permission
alias sudochownlocalbin='sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/sbin'


#####################################
# Initilization on log
#####################################

# NVM (https://github.com/nvm-sh/nvm)
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# only eval opam on `source .zshrc` if opam is an executable
if [ -x "$(command -v opam)" ]; then
  eval $(opam config env)
fi

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# colorful stderr
# https://serverfault.com/questions/59262/bash-print-stderr-in-red-color
# color()(set -o pipefail;"$@" 2>&1>&3|sed $'s,.*,\e[31m&\e[m,'>&2)3>&1
color()(set -o pipefail;"$@" 2>&1 1>&3|sed $'s,.*,\e[31m&\e[m,'1>&2)3>&1

# redefine prompt_context for hiding user@hostname
prompt_context () { }

# vim
EDITOR=vim
GIT_EDITOR=vim


#####################################
# iTerm - macOS dark mode awareness
# https://apas.gr/2018/11/dark-mode-macos-safari-iterm-vim/
#####################################

# if [[ "$(uname -s)" == "Darwin" ]]; then
#     sith() {
#         val=$(defaults read -g AppleInterfaceStyle 2>/dev/null)
#         if [[ $val == "Dark" ]]; then
#             i
#         fi
#     }

#     i() {
#         if [[ $ITERM_PROFILE == "Default" ]]; then
#             echo -ne "\033]50;SetProfile=Dark\a"
#             export ITERM_PROFILE="Dark"
#         else
#             echo -ne "\033]50;SetProfile=Default\a"
#             export ITERM_PROFILE="Default"
#         fi
#     }

#     sith
# fi

# alias iterm-dark-mode="i"



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

# added by setup_fb4a.sh
export ANDROID_SDK=/opt/android_sdk
export ANDROID_NDK_REPOSITORY=/opt/android_ndk
export ANDROID_HOME=${ANDROID_SDK}
export PATH=${PATH}:${ANDROID_SDK}/tools:${ANDROID_SDK}/tools/bin:${ANDROID_SDK}/platform-tools
