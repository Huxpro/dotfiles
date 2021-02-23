Xuan's New Mac Setup Guide
===========================

MacOS System
------------

1. Swap shortcuts for "Spotlight" and "Input Source" (`ctrl` <-> `cmd`)
2. Turn on "Three finger drag", "Tap to click", "App expose" for trackpad
3. Setup Touch ID (if available)
4. Set "Appearences" to "Auto"
5. Set "Default web browser" to "Google Chrome"
6. Disable HDR for my HDR display (I dunno but the HDR looks really bad)

### ⚠️  Allow apps from "Anywhere"

Staring from macOS Sierra, apple has removed "Anywhere" from "Security & Privary" settings:

```sh
# to get "Anywhere" back
sudo spctl --master-disable
```

N.B. this does not require you to turn off [SIP (System Integrity Protection)](https://support.apple.com/en-us/HT204899).


Install _Meta_ Dependencies
------------------------------

### CLI:

- [Oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) (pre-configured ZShell)
  - `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`

- [Homebrew](https://brew.sh/)
  - `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
  - N.B. you might want to [change the ownership of some `usr/local/` from `root` to you](https://docs.brew.sh/FAQ#why-does-homebrew-prefer-i-install-to-usrlocal)
    - `sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/sbin`


### MacOS Apps

- [iTerm2](https://www.iterm2.com/), better terminal.
  - Profiles/Terminal
    - Notifications: check "Silence bell"
  - Profiles/General
    - Working Directory: check "Reuse previous session's directory"

- [Karabiner](https://pqrs.org/osx/karabiner/) for replacing `capslock`.
  - [Does not work on MacOS Catalina #1867](https://github.com/pqrs-org/Karabiner-Elements/issues/1867)
    - add `/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_grabber`
  - A weaker alternatives is to use macOS native modifer keys mapping.


Applying Configurations (For Immediate Comforts!)
-------------------------------------------------

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




Install Must-have Dependencies
---------------------------------

### Appearences (very important!)

- Fonts [Iosevka (SS05)](https://github.com/be5invis/Iosevka)
  - (was [FiraCode](https://github.com/tonsky/FiraCode))

- iTerm settings
  - Appearence
    * Theme: "minimal"
    * Panes: uncheck "per-pane title bar"
    * Dimming: uncheck "dim inactive"
  - Profiles/Colors
    * [_One Light_](https://github.com/nathanbuchar/atom-one-dark-terminal)
    * _One Dark_ (forget where's from but better than above repo)

- Terminal.app
  - Profiles
    - _PaperColor_


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
  - `im-select` for `smartim`-like input method switching
    - `curl -Ls https://raw.githubusercontent.com/daipeihust/im-select/master/install_mac.sh | sh`


### MacOS Apps

- [Rectangle](https://rectangleapp.com/), better Spectacle, w/ *Magnet* shortcuts.

- [Alfred (v3)](https://www.alfredapp.com/), better Spotlight
  - Preferences folder is located by this repo as well.
  - Activate power pack to sync on preference folder.

- [MacOS Quick-Look](https://github.com/sindresorhus/quick-look-plugins), better space preview.

- [搜狗输入法](https://pinyin.sogou.com/mac/)

- [Dash](https://kapeli.com/dash)

- [Back and Sync](https://www.google.com/drive/download/)


Install Good-to-have Dependencies
------------------------------

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

- [Hub](https://hub.github.com/)
  - `brew install hub`

- "Readline Wrap"
  - `brew install rlwrap`


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

- XCode
- Android Studio
- [IntelliJ IDEA](https://www.jetbrains.com/idea/) (CLion, PyCharm...)
  * via "JetBrains Toolbox"
  * sync with `setting-sync` w/ a git repo
  * require github access token



More on Developer Softwares
---------------------------------

> This is WIP. 
> 
> It's intended to track non-trivial dependencies, but it's not very useful at this moment.

### Mainstream

- JavaScript
  - NodeJS, `brew install node`
  - Flow, TypeScript
  - Expo (React Native)

- Python 3

- Java
  - Gradle

- Scala
  - Sbt, `brew install scala sbt`

### System

- LLVM / Clang

- Rust
  - Rustup

### Others

- OCaml
  - Opam

- Reason
  - BuckleScript / Esy

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

