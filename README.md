Xuan's dotfiles
===============

I maintain this for my very personal use, but you're quite welcome to refer it, use it, and make suggestions.


Screenshots
-----------

with One theme:
![screenshot](./scrshot-one.png)


with Solarized theme:
![screenshot](./scrshot-sol.png)

Both themes support using `set background` to switch between dark and light versions.

[alpha] PaperWhite theme.


Dependencies / Credits
----------------------

[vim-plug](https://github.com/junegunn/vim-plug)
  * `curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`
    
[Oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) (pre-configured ZShell)
  * `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`

[Solarized Theme](http://ethanschoonover.com/solarized)
  * To use Solarized theme, you need to: 
    * Delete/Comment out the `===THEME (ONE) ===` section (any easier way to do that? PR welcome)
    * Solarized color depend on the terminal one so you need to config your terminal as well.
      * I include a `.itermcolor` in `/theme` for ITerm users

[One/Vim-One Theme](https://github.com/jordwalke/vim-one)
  " The current default.
  * One theme is independent with terminal theme, so you don't have to change your terminal theme.
    * It seems not working at macOS native terminal app (PR welcome)
    * But I also include a `.itermcolor` in `/theme` for ITerm users

[FiraCode](https://github.com/tonsky/FiraCode)
  * also checkout "Nerds Font" 


Other Common Dependencies
-------------------------

[Homebrew](https://brew.sh/)
  * `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

[ITerm2](https://www.iterm2.com/)
  * Dimming : minimal
  * Panes : uncheck titlebar
  * Theming
    * One Light came from [here](https://github.com/nathanbuchar/atom-one-dark-terminal)
    * One Dark  came from another repo (the above one is not satisified)
    * add keyboard shortcut `cmd-'`, `cmd-"` for switching via "load color preset"

[Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
  * there are tricks to share `.vimrc` w/ `vim`
  * [wish] Onivim, Spacevim

[Spacemacs](http://spacemacs.org/)
  * sync emacs setting

[IntelliJ IDEA](https://www.jetbrains.com/idea/)
  * sync with setting-sync w/ a git repo
  * require github access token

[VS Code](https://code.visualstudio.com/)
  * sync with `Settings Sync` plugin w/ a private gist
  * require github access token
  * the key-repeat issue 
    * `defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false`
  * `im-select` (used by VSCodeVIM)
    * `curl -Ls https://raw.githubusercontent.com/daipeihust/im-select/master/install_mac.sh | sh`
   
[Karabiner](https://pqrs.org/osx/karabiner/)
  * keyboard layout mapping / hacking (e.g. mapping capslock to esc)
  * sync with its configuration file

[Alfred (v3)](https://www.alfredapp.com/)
  * sync with its preferences file
  
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



Other Common Language Softwares 
--------------------------------

JS / Node / NPM / Flow / TypeScript

Python3 / PyRe 

Java / JDK / Gradle / Scala / Sbt

Rust / Cargo
- `rustup`, `rls`, `rustc`

OCaml / Opam / Dune (Jbuilder)

[Coq](https://coq.inria.fr/)

Reason / BuckleScript / Esy

SML
- `brew install smlnj rlwrap`

Haskell / GHC 
- `ghcup`

Agda

Idris

Isabelle

Scala / Sbt
- `brew install scala sbt`


Reference
---------

This dotfiles shamelessly borrow a lot from the web. (Thx, the internet!)

You can also find plenty of dotfiles from:

* <https://dotfiles.github.io/>
* <https://github.com/nicksp/dotfiles>
* <https://github.com/necolas/dotfiles>
* <https://github.com/paulirish/dotfiles>
