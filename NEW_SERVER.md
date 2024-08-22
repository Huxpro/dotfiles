Xuan's New Dev Server Setup Guide
=================================

Install _Meta_ Dependencies
------------------------------

### CLI:

- `chsh zsh`

- [Oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) (pre-configured ZShell)
  - `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`

- include internal specific `zshrc`


Applying Configurations (For Immediate Comforts!)
-------------------------------------------------

### Clone this repo and run `install.sh`

```sh
# using my one-stop install.sh (under the cloned repo)
$ sh install.sh
```

This should give youCLI configuration (e.g. `.zsh*`, `.bash*`, `.git*`) sync-ed immediately.


Install Must-have Dependencies
---------------------------------

### Editors:

- Vim: [vim-plug](https://github.com/junegunn/vim-plug) and `:PlugInstall`.


### Performance under `ssh`

Commentout expensive vim plugins for speeding up.


Install Good-to-have Dependencies
------------------------------

### CLI (some are also used in Vim)

- [FZF](https://github.com/junegunn/fzf)

```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

- [Rg](https://github.com/BurntSushi/ripgrep)
  - I bound Vim `<space>-f` to `:Rg`

