Xuan's New Mac Setup Guide
===========================

MacOS System
------------

0. "Reset modifier key": map "Caps Lock" to "Control"
1. ~Swap shortcuts for "Spotlight" and "Input Source" (`ctrl` <-> `cmd`)~
2. Turn on "Three finger drag", "Tap to click", "App expose" for trackpad
4. Set "Appearences" to "Auto"
5. Set "Default web browser" to "Google Chrome"

### ⚠️  Allow apps from "Anywhere"

Staring from macOS Sierra, apple has removed "Anywhere" from "Security & Privary" settings:

```sh
# to get "Anywhere" back
sudo spctl --master-disable
```

N.B. this does not require you to turn off [SIP (System Integrity Protection)](https://support.apple.com/en-us/HT204899).


Install _Meta_ Dependencies
------------------------------

> Dependencies of dependencies.

### CLI:

- [Oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) (pre-configured ZShell)
  - `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`
  - `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting`
  - `git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions`

- [Homebrew](https://brew.sh/)
  - `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
  - N.B. you might want to [change the ownership of some `usr/local/` from `root` to you](https://docs.brew.sh/FAQ#why-does-homebrew-prefer-i-install-to-usrlocal)
    - `sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/sbin`


### MacOS Apps

- [iTerm2](https://www.iterm2.com/), better terminal.
  - See configuration below.
 
- [Karabiner](https://pqrs.org/osx/karabiner/) for replacing `capslock`.
  - [Does not work on MacOS Catalina #1867](https://github.com/pqrs-org/Karabiner-Elements/issues/1867)
    - add `/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_grabber`
  - A weaker alternatives is to use macOS native modifer keys mapping.


Applying Configurations (For Immediate Comforts!)
-------------------------------------------------

> Immediately giving a sense of HOME.

### Clone this repo and run `linkall.sh`

```sh
# using my one-stop linkall.sh (under the cloned repo)
$ sh linkall.sh

# manual symlink (under $HOME)
$ ln -s <source_file> <target_file>
$ ln -s dotfiles/vim/.vimrc .vimrc
```

This should give you

- Karabiner configuration
- CLI configuration (e.g. `.zsh*`, `.bash*`, `.git*`)

sync-ed immediately.


### CLI Appearences & Configuration

- Fonts [Iosevka (SS05)](https://github.com/be5invis/Iosevka)
  - (was [FiraCode](https://github.com/tonsky/FiraCode))

- iTerm
  - Appearence
    * General - Theme - "Minimal"
    * Panes - uncheck "Show per-pane title bar with split panes"
    * Dimming - uncheck "Dim inactive split panes"
  - Profiles
    * Terminal - Notifications - check "Silence bell"
    * General - Working Directory - switch to "Reuse previous session's directory".
    * Colors - Color Presets...
      * [_One Light_](https://github.com/nathanbuchar/atom-one-dark-terminal)
      * _One Dark_ (I'm using the one from this repo but I forget where's from)

- Terminal.app (if you use it)
  - Profiles
    - _PaperColor_


Install _Must-have_ Dependencies
--------------------------------

> Retrieve back my normal workflow.

### Editors:

- Vim
  - Install [vim-plug](https://github.com/junegunn/vim-plug) 
    - `curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`
  - Within `vim`, run `:PlugInstall`.

- VSCode: 
  - Settings Sync 
    - It's now official: <https://code.visualstudio.com/docs/editor/settings-sync>
    - [Settings Sync](https://github.com/shanalikhan/code-settings-sync) and `Sync: Download Settings`.
    - [Frozen when trying to install unpublished extensions](https://github.com/shanalikhan/code-settings-sync/issues/1194)
  - [holding key does not repeat e.g. jjjj](https://stackoverflow.com/questions/39972335/how-do-i-press-and-hold-a-key-and-have-it-repeat-in-vscode/44010683#44010683)
    - `defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false`
  - [blurry font on macOS Mojave for non-retina screen e.g. display](https://github.com/Microsoft/vscode/issues/51132)
    - `defaults write com.microsoft.VSCode.helper CGFontRenderingFontSmoothingDisabled -bool NO`
  - [`im-select`](https://github.com/daipeihust/im-select) for `smartim`-like input method switching
    - `brew tap daipeihust/tap && brew install im-select`


### MacOS Apps

- [Rectangle](https://rectangleapp.com/), better Spectacle, w/ *Magnet* (now the default) shortcuts.

- [Alfred)](https://www.alfredapp.com/), better Spotlight
  - Activate "Power Pack" to sync the preference folder captured in this repo.

- [MacOS Quick-Look](https://github.com/sindresorhus/quick-look-plugins), better space preview.

- [Sogou PinYin (Chinese input method)](https://pinyin.sogou.com/mac/)

- [Google Drive](https://www.google.com/drive/download/)

- Xcode, for the native toolchain.


Install _Good-to-have_ Dependencies
-----------------------------------

### CLI (some are also used in Vim)

- [FZF](https://github.com/junegunn/fzf)

```
brew install fzf

# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install
```

- [Rg](https://github.com/BurntSushi/ripgrep)
  - `brew install ripgrep`
  - I bound Vim `<space>-f` to `:Rg`

- <del>[Hub](https://hub.github.com/)</del> [Gh](https://cli.github.com/), Github official CLI
  - `brew install gh`
  - [ghstack](https://github.com/ezyang/ghstack) for stack-based workflow: `pip3 install ghstack`

- "Readline Wrap"
  - `brew install rlwrap`

### MacOS Apps

- [Dash](https://kapeli.com/dash)

- Docker, required by `circleci` CLI.
 
- [IINA](https://iina.io/), open source media player for macOS.

- [PDF Expert](https://pdfexpert.com/), the pdf reader that I got used to.

- Final Cut Pro, etc. for vlogging.

- Monodraw

- Notion

- Web shortcuts 
  - Workplace
  - ASTExplorer
  - Excalidraw
  - Gmail
  - Prettier
  - Babel
  - Hermes Playground
  - Youtube Music


More on Editors
---------------

### Vim

- Vim 8.1
- OniVim
- SpaceVim
- [Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
  * [nightly release](https://github.com/neovim/neovim/releases) 
  * there are tricks to share `.vimrc` w/ `vim`
  * Potential [issue](https://github.com/neovim/neovim/issues/9050) on Python and macOS Mojave.

### Emacs

- [Spacemacs](http://spacemacs.org/)
  * synced under `emacs/.spacemacs`
  * GUI app options: `emacs-plus`, `emacs-mac`

### IDE

- XCode, as aforementioned.
- Android Studio
- [JetBrains Toolbox](https://www.jetbrains.com/) for Idea, CLion, PyCharm...
  * sync with `setting-sync` w/ a git repo
  * require github access token
  * *Must-have* Plugins:
    * IdeaVim
    * OneDark Theme
    * VSCode Keymap



More on Developer Softwares
---------------------------------

> This is WIP. 
> 
> It's intended to track non-trivial dependencies, but it's not very useful at this moment.

### Mainstream

- JavaScript
  - NodeJS, [`nvm`](https://github.com/nvm-sh/nvm), `nvm install stable`
  - Flow
  - TypeScript `npm i -g typescript`
  - Expo CLI (React Native)

- Python 3

- Java
  - Gradle

- Scala
  - Sbt, `brew install scala sbt`

### System

- LLVM `brew install llvm` 

- Emscripten SDK [`emsdk`](https://emscripten.org/docs/getting_started/downloads.html)

- CMake `brew install cmake`  

- Rust
  - Rustup

### Others

- OCaml
  - Opam

- ReScript/ReasonML

- SML
  - SMLNJ, `brew install smlnj`
  - MLton

- [Coq](https://coq.inria.fr/)
  - CoqMake

- Haskell
  - GHC, `ghcup`

- Racket
  - `brew install racket` (miminal)

- Agda

- Isabelle

- Prolog

