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
# Alias - Hermes
#####################################

########## Build

# Maybe someday I should add -oss/dbg/rel as CLI args to simulate Buck flavor
H_CLION="$HOME/hermes-clion"
H_CMAKE_DBG="$HOME/hermes-cmake-build-dbg"
H_CMAKE_REL="$HOME/hermes-cmake-build-rel"
H_CMAKE_OSS_DBG="$HOME/hermes-cmake-build-oss-dbg"
# H_CMAKE_OSS_REL="$HOME/hermes-cmake-build-oss-rel"
H_CMAKE_OSS_REL="$HOME/github/build_release" # https://hermesengine.dev/docs/react-native-integration
H_EM_DBG="$HOME/hermes-embuild" # fastcomp
H_EM_FASTCOMP_REL="$HOME/embuild-fastcomp-rel"
H_EM_UPSTREAM_REL="$HOME/embuild-upstream-rel"

# [CMake] Configure the build
alias config-cmake-hermes="./utils/build/configure.py $H_CMAKE_DBG"
alias config-cmake-hermes-rel="./utils/build/configure.py --distribute $H_CMAKE_REL"
alias config-cmake-hermes-oss="./utils/build/configure.py $H_CMAKE_OSS_DBG"
alias config-cmake-hermes-oss-rel="./utils/build/configure.py --distribute $H_CMAKE_OSS_REL"

# [Emscripten] Configure the build
# assuming the existence of \host-hermesc
config-em-hermes-2() {
  local cmake_flags=" -DIMPORT_HERMESC:PATH=$PWD/host-hermesc/ImportHermesc.cmake "

  python3 ./utils/build/configure.py \
    --cmake-flags "$cmake_flags" \
    --distribute \
    --wasm \
    --emscripten-platform=fastcomp \
    --emscripten-root="${EM_fastcomp}" \
    $H_EM_FASTCOMP_REL
}

config-em-hermes() {
  cmake . \
        -Bembuild \
        -GNinja \
        -DCMAKE_TOOLCHAIN_FILE="${EM_fastcomp}/cmake/Modules/Platform/Emscripten.cmake" \
        -DCMAKE_BUILD_TYPE=Release \
        -DEMSCRIPTEN_FASTCOMP=1 \
        -DCMAKE_EXE_LINKER_FLAGS="-s NODERAWFS=1 -s WASM=1 -s ALLOW_MEMORY_GROWTH=1"
        -DIMPORT_HERMESC="$PWD/host-hermesc/ImportHermesc.cmake"
}

config-em-hermes-upstream() {
  cmake . \
        -Bembuild \
        -GNinja \
        -DCMAKE_TOOLCHAIN_FILE="${EM_upstream}/cmake/Modules/Platform/Emscripten.cmake" \
        -DCMAKE_BUILD_TYPE=Release \
        -DEMSCRIPTEN_FASTCOMP=1 \
        -DCMAKE_EXE_LINKER_FLAGS="-s NODERAWFS=1 -s WASM=1 -s ALLOW_MEMORY_GROWTH=1"
        -DIMPORT_HERMESC="$H_CMAKE_OSS_DBG/ImportHermesc.cmake"
}


# [CMake] Build
alias cmake-hermes="(cd $H_CMAKE_DBG && ninja)"
alias cmake-hermes-rel="(cd $H_CMAKE_REL && ninja)"
alias cmake-hermes-oss="(cd $H_CMAKE_OSS_DBG && ninja)"
alias cmake-hermes-oss-rel="(cd $H_CMAKE_OSS_REL && ninja)"

# [CMake] Clean Build
# drop for now

# [Emscripten] Build
alias em-hermes="cmake --build $H_EM_DBG --target hermes"
alias em-hermes-fastcomp-rel="cmake --build $H_EM_FASTCOMP_REL --target hermes"
alias em-hermes-upstream-rel="cmake --build $H_EM_UPSTREAM_REL --target hermes"

# [Buck] Build
alias buck-hermes='buck build //xplat/hermes/tools/hermes:hermes'
alias buck-hermes-dbg='buck build @xplat/mode/hermes/dbg //xplat/hermes/tools/hermes:hermes'
alias buck-hermes-asan='buck build @xplat/mode/hermes/asan //xplat/hermes/tools/hermes:hermes'
alias buck-hermes-handlesan='buck build @xplat/mode/hermes/handlesan //xplat/hermes/tools/hermes:hermes'
alias buck-hermes-home='buck build --out ~/hermes-buck-out //xplat/hermes/tools/hermes:hermes' # rare use

########## Executables

# [Exe] Build Artifacts
alias her-clion="rlwrap $H_CLION/bin/hermes" 
alias her-cmake="rlwrap $H_CMAKE_DBG/bin/hermes"
alias her-cmake-rel="rlwrap $H_CMAKE_REL/bin/hermes"
alias her-cmake-oss="rlwrap $H_CMAKE_OSS_DBG/bin/hermes"
alias her-cmake-oss-rel="rlwrap $H_CMAKE_OSS_REL/bin/hermes"
alias her-buck="rlwrap ~/fbsource/buck-out/gen/xplat/hermes/tools/hermes/hermes"
alias her-buck-home="rlwrap ~/hermes-buck-out" # rare use
 
# [Exe] Convenient Aliases
alias her="her-buck"
alias herc="her-clion"
alias hercr="her-cmake-rel"
alias her-p="her -Xes6-promise"
alias herc-p="herc -Xes6-promise"
alias hercr-p="hercr -Xes6-promise"
alias her-oss="her-cmake-oss"

# [Exe] [JSVU] optimized builds, useful for benchmarking/uses
alias her-jsvu="hermes"  # .jsvu added to the path

js-to-bin-hbc() {
  her -emit-binary -out $1.hbc $1.js
}

js-to-dis-hbc() {
  her -dump-bytecode $1.js > $1.dis
}

hbc-bin-to-dis-hbc() {
  her -b -dump-bytecode $1.hbc > $1.dis
}


# [Exe] [Buck]
alias her-run='buck run tools/hermes'
alias her-run-strict='buck run tools/hermes -- -strict'

# [Exe] [Emscripten]
alias her-em="node $H_EM_DBG/bin/hermes.js"
alias her-em-fastcomp-rel="node $H_EM_FASTCOMP_REL/bin/hermes.js"
alias her-em-upstream-rel="node $H_EM_UPSTREAM_REL/bin/hermes.js"


########## Testing

# [CMake] Clion only
alias cmake-test-hermes="cd $H_CLION && ninja check-hermes"

# [Buck] Testing
alias test-hermes-all='buck test //xplat/hermes/...'
alias test-hermes-quic='buck test //xplat/hermes/test:quick'
alias test-hermes-asan='buck test @fbandroid/mode/asan @xplat/mode/hermes/asan'
alias test-hermes-lit='buck test //xplat/hermes/test:lit'
alias test-hermes-lit-ser='buck test @xplat/mode/hermes/serialize test:lit'
alias test-hermes-lit-asan='buck test @fbandroid/mode/asan test:lit'
alias test-lit="test-hermes-lit"
alias test-lit-asan="test-hermes-lit-asan"

# [Buck] Testing Test262
alias test262-hermes-matchAll-string='buck run //xplat/hermes/utils/testsuite:run_testsuite ~/fbsource/xplat/third-party/javascript-test-suites/test262/test/built-ins/String/prototype/matchAll'
alias test262-hermes-replaceAll-string='buck run //xplat/hermes/utils/testsuite:run_testsuite ~/fbsource/xplat/third-party/javascript-test-suites/test262/test/built-ins/String/prototype/replaceAll'
alias test262-hermes-matchAll-regexp='buck run //xplat/hermes/utils/testsuite:run_testsuite ~/fbsource/xplat/third-party/javascript-test-suites/test262/test/built-ins/RegExp/prototype/Symbol.matchAll'
alias test262-hermes-builtin='buck run //xplat/hermes/utils/testsuite:run_testsuite ~/fbsource/xplat/third-party/javascript-test-suites/test262/test/built-ins/'
alias test262-hermes-lang='buck run //xplat/hermes/utils/testsuite:run_testsuite ~/fbsource/xplat/third-party/javascript-test-suites//test262/test/language/'
alias test262-hermes-all='buck run //xplat/hermes/utils/testsuite:run_testsuite ~/fbsource/xplat/third-party/javascript-test-suites/test262/test'

alias test262-hermes-async-fn-decl="buck run //xplat/hermes/utils/testsuite:run_testsuite ~/fbsource/xplat/third-party/javascript-test-suites/test262/test/language/statements/async-function"
alias test262-hermes-async-arrow="buck run //xplat/hermes/utils/testsuite:run_testsuite ~/fbsource/xplat/third-party/javascript-test-suites/test262/test/language/expressions/async-arrow-function"
alias test262-hermes-async-fn-expr="buck run //xplat/hermes/utils/testsuite:run_testsuite ~/fbsource/xplat/third-party/javascript-test-suites/test262/test/language/expressions/async-function"
alias test262-hermes-asyncFn="buck run //xplat/hermes/utils/testsuite:run_testsuite ~/fbsource/xplat/third-party/javascript-test-suites/test262/test/built-ins/AsyncFunction/"
alias test262-hermes-async="test262-hermes-async-fn-decl && test262-hermes-async-fn-expr && test262-hermes-async-arrow"


########## Dev Convenience

alias format-fb="arc lint -a"
alias format-hermes="./utils/format.sh"

########## ESHOST
## https://github.com/bterlson/eshost-cli

alias estable='eshost --table'
alias esex='eshost --tags esvu-web -itsx'

########## ANDROID
 
alias android-emulator='ENABLE_WIFI=1 ~/fbsource/fbandroid/scripts/start_emulator -gpu host'
alias fb4a='cd ~/fbsource/fbandroid && buck install -r fb4a'
alias catalyst='cd ~/fbsource/fbandroid && buck install -r catalyst-android'

########## React Native

alias rn-clean-build-android='cd android && ./gradlew clean && cd .. && npx react-native run-android'

RNTESTER="${HOME}/react-native/react-native/packages/rn-tester"

# under RNTester
alias hash-apk-debug="unzip -p ${RNTESTER}/android/app/build/outputs/apk/hermes/debug/app-hermes-armeabi-v7a-debug.apk lib/armeabi-v7a/libhermes.so | shasum"
alias hash-apk-rel="unzip -p ${RNTESTER}/android/app/build/outputs/apk/hermes/release/app-hermes-armeabi-v7a-release.apk lib/armeabi-v7a/libhermes.so | shasum"
hash-hermes-debug() {
  tar zxfO ~/hermes-releases/v$1/hermes-engine-v$1.tgz package/android/hermes-debug.aar | tar xfO - jni/armeabi-v7a/libhermes.so | shasum
}
hash-hermes-rel() {
  tar zxfO ~/hermes-releases/v$1/hermes-engine-v$1.tgz package/android/hermes-release.aar | tar xfO - jni/armeabi-v7a/libhermes.so | shasum
}


#####################################
# Alias - FB Source Control
#####################################

# submit then update info
alias jfsu='jf s -u'
alias jfsun='jf s -u -n' # draft

# `e` for edit, same as `hg commit --amend`
alias hg-amend-e='hg amend -e'

# HG amend; Then JF push
alias hgjf='hg amend && jf s'
alias hgjfn='hg amend && jf s -n'

# HG amend; Editing commit message; Then JF push.
alias hgejfsu='hg amend -e && jf s -u'
alias hgejfsun='hg amend -e && jf s -u -n'

# HG revert is so damn hard to use
alias hgco='hg revert'           # git co -- <filename>
alias hgcoall='hg revert all'    # git co -- .
alias hgcoHEAD='hg revert -r .^' # git co HEAD^ <filename>

# bruto git push
alias gitpush='git add . && git commit -m "auto" && git push origin master'

# alias node='~/fbsource/xplat/third-party/node/bin/node'

# a hux-ized machine
alias sshdev='ssh devvm433.atn0.facebook.com'

# a cleaner machine
alias sshdev2='ssh devvm2238.vll0.facebook.com'


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
