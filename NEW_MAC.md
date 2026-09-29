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

On macOS 15 (Sequoia) and later this only un-hides the option: then pick
"Anywhere" in System Settings → Privacy & Security → "Allow applications from".

N.B. this does not require you to turn off [SIP (System Integrity Protection)](https://support.apple.com/en-us/102149).


Install _Meta_ Dependencies
------------------------------

> Dependencies of dependencies.

### CLI:

- [Oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) (pre-configured ZShell)
  - `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
  - `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`
  - `git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions`

- [Homebrew](https://brew.sh/)
  - `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
  - Apple Silicon installs to `/opt/homebrew` (already on `PATH` via `zsh/.zprofile`), so no `sudo chown` of `/usr/local` is needed anymore.


### MacOS Apps

- [iTerm2](https://www.iterm2.com/), better terminal.
  - See configuration below.
 
- [Karabiner](https://karabiner-elements.pqrs.org/) for replacing `capslock`.
  - Grant it "Input Monitoring" and allow its driver extension in System Settings → Privacy & Security when prompted.
  - A weaker alternatives is to use macOS native modifer keys mapping.


Applying Configurations (For Immediate Comforts!)
-------------------------------------------------

> Immediately giving a sense of HOME.

### Clone this repo and run `install.sh`

```sh
# using my one-stop install.sh (under the cloned repo)
$ sh install.sh

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
  - Settings Sync is built in: <https://code.visualstudio.com/docs/editor/settings-sync>
    (the old `shanalikhan/code-settings-sync` extension is deprecated)
  - [holding key does not repeat e.g. jjjj](https://stackoverflow.com/questions/39972335/how-do-i-press-and-hold-a-key-and-have-it-repeat-in-vscode/44010683#44010683)
    - `defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false`
    - or `defaults write -g ApplePressAndHoldEnabled -bool false` if you prefer this globally
  - [blurry font on macOS Mojave for non-retina screen e.g. display](https://github.com/Microsoft/vscode/issues/51132)
    - `defaults write com.microsoft.VSCode.helper CGFontRenderingFontSmoothingDisabled -bool NO`
  - [`im-select`](https://github.com/daipeihust/im-select) for `smartim`-like input method switching
    - `brew tap daipeihust/tap && brew install im-select`


### MacOS Apps

- [Rectangle](https://rectangleapp.com/), better Spectacle, w/ *Magnet* (now the default) shortcuts.
  - Preference - Repeated commands - "cycle 1/2, 2/3, and 1/3 on half actions"

- [Alfred](https://www.alfredapp.com/), better Spotlight
  - Activate "Power Pack" to sync the preference folder captured in this repo.
  - The _Focus_ and _TimeZones_ workflows run PHP, which macOS dropped in 12.3: `brew install php`.

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

- Vim 9 (`brew install vim`, built with `+termguicolors`)
- [Neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md) (`brew install neovim`)
  * `nvim/init.vim` shares `.vimrc` w/ `vim` (linked by `install.sh`)

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

