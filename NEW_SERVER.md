Xuan's New Dev Server Setup Guide
=================================

Install _Meta_ Dependencies
------------------------------

### CLI:

- `chsh -s "$(command -v zsh)"`

- [Oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) (pre-configured ZShell)
  - `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
  - `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`
  - `git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions`

- include internal specific `zshrc`


Applying Configurations (For Immediate Comforts!)
-------------------------------------------------

### Clone this repo and run `install.sh`

```sh
# using my one-stop install.sh (under the cloned repo)
$ sh install.sh
```

This should give you CLI configuration (e.g. `.zsh*`, `.bash*`, `.git*`) sync-ed immediately.


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

