Xuan's dotfiles
===============

I maintain this for my personal uses, but you're quite welcome to refer and use ;)


Screenshots
-----------

with One theme (for 24-bit *true color* terminal):
![screenshot](./scrshot-one.png)


with Solarized theme (for 8-bit 256 colors terminal, e.g. MacOS's `Terminal.app`):
![screenshot](./scrshot-sol.png)


with PaperColor theme. (for both)
TBD.


Using `:Light`/`:Dark` (underlying `set background`) to switch between dark and light versions of each themes.
See `Theme - Key binding` for commands to switch between themes (WIP).


Dependencies - CLI
------------------

[Oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) (pre-configured ZShell)
  * `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`

[Homebrew](https://brew.sh/)
  * `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
  * [permission issue](https://github.com/Homebrew/homebrew-core/issues/19286)

[iTerm2](https://www.iterm2.com/)
  * Dimming: minimal
  * Panes: uncheck titlebar
  * Theme: minimal
  * Profile colors
    * One Light came from [here](https://github.com/nathanbuchar/atom-one-dark-terminal)
    * One Dark  came from another repo (the above one is not satisified)
    * add keyboard shortcut `cmd-'`, `cmd-"` for switching via "load color preset"

[FZF](https://github.com/junegunn/fzf)

```
brew install fzf

# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install
```

[Rg](https://github.com/BurntSushi/ripgrep)
  * `brew install ripgrep`
  * I bound `<space>-f` to `:Rg` provided by `FZF` for grep.

[Hub](https://hub.github.com/)
  * using github from CLI.
  * `brew install hub`


Dependencies - Editors
----------------------

Vim 8.1

[vim-plug](https://github.com/junegunn/vim-plug)

[Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
  * [nightly release](https://github.com/neovim/neovim/releases) 
  * there are tricks to share `.vimrc` w/ `vim`
  * Potential OSX Mojave and Python problem:
    * <https://github.com/neovim/neovim/issues/9050>

OniVim

SpaceVim

[Coc.nvim](https://github.com/neoclide/coc.nvim)
  * [Coc-highlight](https://github.com/neoclide/coc-highlight): Highlight symbol of current position in all positions of current buffer (when no document highlight provider exists from language server).
  * [more extensions](https://github.com/neoclide/coc.nvim#extensions)

Emacs

[Spacemacs](http://spacemacs.org/)
  * sync emacs setting

[IntelliJ IDEA](https://www.jetbrains.com/idea/)
  * sync with setting-sync w/ a git repo
  * require github access token

[VS Code](https://code.visualstudio.com/)
  * sync with `Settings Sync` plugin w/ a private gist
  * require github access token
  * [holding key does not repeat e.g. jjjj](https://stackoverflow.com/questions/39972335/how-do-i-press-and-hold-a-key-and-have-it-repeat-in-vscode/44010683#44010683)
    * `defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false`
  * [blurry font on macOS Mojave for non-retina screen e.g. display](https://github.com/Microsoft/vscode/issues/51132)
    * `defaults write com.microsoft.VSCode.helper CGFontRenderingFontSmoothingDisabled -bool NO`
  * smartim-like input method switching 
    * installing `im-select` (works w/ `VSCodeVIM`)
      * `curl -Ls https://raw.githubusercontent.com/daipeihust/im-select/master/install_mac.sh | sh`

Android Studio

XCode


Dependencies - Visual
---------------------

[FiraCode](https://github.com/tonsky/FiraCode) or [Iosevka](https://github.com/be5invis/Iosevka)


Dependencies - MacOS
--------------------

[Karabiner](https://pqrs.org/osx/karabiner/)
  * keyboard layout mapping / hacking (e.g. mapping capslock to esc + ctrl)
  * sync with its configuration file
  * In Catalina, you might want to refer to issue `#1867` to add `karabiner_grabber` manually

[Alfred (v3)](https://www.alfredapp.com/)
  * sync with its preferences file

[Rectangle](https://rectangleapp.com/)
  * Window manager, better alternatives of Spectacle.
  * set to *Magnet* keyboard shortcut

[MacOS Quick-Look](https://github.com/sindresorhus/quick-look-plugins)
  * `brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlimagesize webpquicklook suspicious-package quicklookase qlvideo`


Protips
-------

### `symlink` over copy

```bash
$ ln -s <source_file> <target_file>

# use my linkall.sh (under repo's dir)
$ sh linkall.sh

# e.g. (under $HOME)
$ ln -s dotfiles/vim/.vimrc .vimrc
```

### `ssh` performance

For `ssh` usages, you might want to comment out some vim plugins for speeds.


Notes - Common Language Softwares
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


Notes - New Mac Setup Guide
---------------------------

### System 

1. Swap Spotlight and Input Source (`ctrl` <-> `cmd`)
2. Turn on "Three finger drag", "Tap to click", "App expose"


### Replacing Capslock

could be easier configured to `escape` or `ctrl`,
but could be more powerful with Karabiner


### Install dependencies

`brew`, `zsh`, `vim-plug`, Karabiner, Rectangle...


### Run `linkall.sh`

Hopefully you will get 
- Karabiner configuration sync-ed
- `zsh` with `lambda` theme


### Setup Vim

Run `:PlugInstall` inside `vim`
Then you should get pretty `PaperColor` theme for `Terminal.app` (Not True Color)


### Adjusting Git Configuration

Although git auth users by their github username/password, the commits are logged and tracked by the email recorded on your local `git config`.
So please follow [Why are my commits linked to the wrong user?
](https://help.github.com/en/github/committing-changes-to-your-project/why-are-my-commits-linked-to-the-wrong-user) to adjust your local configs:

```sh
$ git config --global user.email "email@example.com"
```

### More Dependencies...


Reference
---------

This dotfiles shamelessly borrow a lot from the web. (Thx, the internet!)

You can also find plenty of dotfiles from:

* <https://dotfiles.github.io/>
* <https://github.com/nicksp/dotfiles>
* <https://github.com/necolas/dotfiles>
* <https://github.com/paulirish/dotfiles>
