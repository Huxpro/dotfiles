Notes - New Mac Setup Guide
===========================

MacOS System
------------

1. Swap shortcuts for "Spotlight" and "Input Source" (`ctrl` <-> `cmd`)
2. Turn on "Three finger drag", "Tap to click", "App expose" for trackpad
3. Setup Touch ID (if available)
4. Set "Appearences" to "Auto"
5. Set "Default web browser" to "Google Chrome"


Install _Meta_ Dependencies
------------------------------

### CLI:

- [Oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) (pre-configured ZShell)
  - `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`

- [Homebrew](https://brew.sh/)
  - `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`


### MacOS Apps

- [iTerm2](https://www.iterm2.com/)

- [Karabiner](https://pqrs.org/osx/karabiner/) for replacing `capslock`.
  - [Does not work on MacOS Catalina #1867](https://github.com/pqrs-org/Karabiner-Elements/issues/1867)
    - add `/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_grabber`
  - A weaker alternatives is to use macOS native modifer keys mapping.


Applied Configurations (For Immediate Comforts!)
------------------------------------------------

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


### Performance under `ssh`

Commentout some expensive vim plugins for speeding up.



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

- Vim: [vim-plug](https://github.com/junegunn/vim-plug) and `:PlugInstall`.

- VSCode: [Settings Sync](https://github.com/shanalikhan/code-settings-sync) and `Sync: Download Settings`.
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
  - Preferences file is synced by this repo as well.

- [MacOS Quick-Look](https://github.com/sindresorhus/quick-look-plugins), better space preview.



Install Good-to-have Dependencies
------------------------------

### CLI (some are also invoked in Vim)

- [FZF](https://github.com/junegunn/fzf)

```
brew install fzf

# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install
```

- [Rg](https://github.com/BurntSushi/ripgrep)
  - `brew install ripgrep`
  - I bound `<space>-f` to `:Rg`

- [Hub](https://hub.github.com/)
  - `brew install hub`



More on Editors
---------------

### Vim

- Vim 8.1
- OniVim
- SpaceVim
- [Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
  * [nightly release](https://github.com/neovim/neovim/releases) 
  * there are tricks to share `.vimrc` w/ `vim`
  * Potential OSX Mojave and Python problem:
    * <https://github.com/neovim/neovim/issues/9050>


### Emacs

- [Spacemacs](http://spacemacs.org/)
  * sync emacs setting

### IDE

- XCode
- Android Studio
- [IntelliJ IDEA](https://www.jetbrains.com/idea/) (CLion, PyCharm...)
  * sync with `setting-sync` w/ a git repo
  * require github access token



More on Developer Softwares
---------------------------------

JS
- `node`, `npm`, Flow, TypeScript

Python3

Java
- Gradle

Scala
- Sbt `brew install scala sbt`

Rust
- Cargo, `rustup`, `rls`, `rustc`

OCaml
- Opam / Dune (Jbuilder)

[Coq](https://coq.inria.fr/)
- CoqMake

Reason
- BuckleScript / Esy

SML
- `brew install smlnj rlwrap`
- MLton

Haskell
- GHC, `ghcup`

Agda

Isabelle

Dart

Swift

Racket
- `brew install racket` (miminal)

