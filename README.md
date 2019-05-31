# Xuan's dotfiles


I maintain this for my very personal use, but you're quite welcome to refer it, use it, and make suggestions.

## Screenshot

with One theme:
![screenshot](./scrshot-one.png)


with Solarized theme:
![screenshot](./scrshot-sol.png)

Both themes support using `set background` to switch between dark and light versions.

## Dependencies / Credits

Vim-plug
  * `curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`
    
Vundle (for vim plugin management)
  * `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
  * `:PluginInstall` in vim

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

Fira Fonts (if you like this)
  * checkout "Nerds Font" 

## Other common dependencies

Homebrew
  * `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

[ITerm2](https://www.iterm2.com/)
  * Dimming minimal
  * Panes uncheck titlebar

[Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)

Spacemacs

VSCode

## Protips

Use `symlink` rather than hard copies!

```bash
$ ln -s <source_file> <target_file>

# use my linkall.sh (under repo's dir)
$ sh linkall.sh

# e.g. (under $HOME)
$ ln -s dotfiles/vim/.vimrc .vimrc
```

For `ssh` usages, you might want to comment out soem plugins to prevent the vim from starting too slow.
I Personally only kept a few.

## MacOS Tools

* <https://github.com/sindresorhus/quick-look-plugins>

* Karabiner

* Alfred

## Reference

This dotfiles shamelessly borrow a lot from the web. (Thx, the internet!)

You can also find plenty of dotfiles from:

* <https://dotfiles.github.io/>
* <https://github.com/nicksp/dotfiles>
* <https://github.com/necolas/dotfiles>
* <https://github.com/paulirish/dotfiles>
