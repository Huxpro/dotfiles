# sourced on the start of a login shell.

# 10ms for key sequences
KEYTIMEOUT=1

# System binaries
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/usr/local/sbin:$PATH"

# Haskell ghcup/cabal/stack/hie etc.
export PATH=$HOME/.local/bin:$PATH
export PATH="$HOME/Library/Haskell/bin:$PATH"
export PATH="$HOME/.ghcup/bin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"

# Python Pyenv verison manager
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$PYENV_ROOT/shims:$PATH"

# Python pip
export PATH="$HOME/Library/Python/3.6/bin:$PATH"
export PATH="$HOME/Library/Python/3.7/bin:$PATH"

# Ruby gem
export GEM_HOME=$HOME/gems
export PATH=$HOME/gems/bin:$PATH
export PATH=$HOME/.gem/ruby/X.X.0/bin:$PATH

# JS Yarn
export PATH="$HOME/.yarn/bin:$PATH"

# JS JSVU
export PATH="$HOME/.jsvu:$PATH"

# Flutter
export PATH="$HOME/flutter/bin:$PATH"

# Sqlite
export PATH="/usr/local/opt/sqlite/bin:$PATH"

# Rust cargo
export PATH="$HOME/.cargo/bin:$PATH"

# Coq, override coq with brew-installed coq
export PATH="/usr/local/Cellar/coq/8.9.0/bin:$PATH"

# FB - XR
export PATH="$HOME/.fnl/bin:$PATH"
export PATH="$PATH:$HOME/aros/xros/bin"

# Emscripten
export PATH="$HOME/github/emsdk:$PATH"
EMSDK="$HOME/github/emsdk"
EM_CONFIG="$HOME/.emscripten"
EM_fastcomp="$HOME/github/emsdk/fastcomp/emscripten"
EM_upstream="$HOME/github/emsdk/upstream/emscripten"

# https://discourse.brew.sh/t/failed-to-set-locale-category-lc-numeric-to-en-ru/5092/19
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Hermes Android Build
export HERMES_WS_DIR=~/github

####### Native Toolchain

# Android
# this was required by building RN from source
# export ANDROID_NDK="/opt/android_ndk/r17fb2"
# export ANDROID_NDK="/opt/android_sdk/ndk/20.1.5948944"
export ANDROID_SDK="/opt/android_sdk"
export ANDROID_NDK="/opt/android_ndk/android-ndk-r20b"


### https://docs.oracle.com/cd/E17276_01/html/installation/build_unix_flags.html
# LDFLAGS  - linker (also CMake?)
# CPPFLAGS - C-preprocessor
# CXXFLAGS - C++ compiler

# openSSL
export PATH="/usr/local/opt/openssl/bin:$PATH"
# export LDFLAGS="-L/usr/local/opt/openssl/lib"
# export CPPFLAGS="-I/usr/local/opt/openssl/include"
# export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"

# LLVM (brew installed)
### disabled since FB Chef installed LLVM in `/opt/llvm` and linked in `/usr/local/opt/llvm`
# export PATH="/usr/local/opt/llvm/bin:$PATH"
# export LDFLAGS="-L/usr/local/opt/llvm/lib"
# export CPPFLAGS="-I/usr/local/opt/llvm/include"

# MacOS Catalina SDKs
# xcode-select-ed to XCode 10.15
# https://github.com/Homebrew/homebrew-core/pull/45304
# This alone fixed all the `/usr/local/opt/llvm/bin/..` issues!
export SDKROOT="$(xcrun --sdk macosx --show-sdk-path)"

# CMake
export CMAKE_OSX_SYSROOT="$SDKROOT"
export LLVM_DIR="/usr/local/opt/llvm/lib/cmake"

# Clang
# https://clang.llvm.org/docs/CommandGuide/clang.html#environment
#
# Disable since it
# Break the `pos install` of "Flipper-Glog (0.3.6)" using by React Native iOS
# - by forcing an IOS ARM builds to use the MacOS Intel headers...then BLOW UP
# 
# export CPATH="$SDKROOT/usr/include"

# GCC
# export PATH=/usr/local/gcc-8.1/bin:$PATH

# GNU utils
# export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# XROS
export PATH="$PATH:$HOME/aros/xros/bin"

