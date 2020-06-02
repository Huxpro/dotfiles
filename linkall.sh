#!/bin/bash

cwd=$(pwd)

# bash
ln -sf "$cwd/bash/.bashrc" ~/.bashrc

# zsh
ln -sf "$cwd/zsh/.zshrc" ~/.zshrc
ln -sf "$cwd/zsh/.zshenv" ~/.zshenv
ln -sf "$cwd/zsh/.zprofile" ~/.zprofile
ln -sf "$cwd/zsh/oh-my-zsh/themes/refined-lambda.zsh-theme" ~/.oh-my-zsh/themes/refined-lambda.zsh-theme

# vim
ln -sf "$cwd/vim/.vimrc" ~/.vimrc
ln -sf "$cwd/vim/.vimrc" ~/.ideavimrc

# neovim and coc
if [ -d "~/.config/nvim" ]; then
  ln -sf "$cwd/nvim/init.vim" ~/.config/nvim/init.vim
  ln -sf "$cwd/nvim/coc-settings.json" ~/.config/nvim/coc-settings.json
else
  # fallback to vim
  ln -sf "$cwd/nvim/coc-settings.json" ~/.vim/coc-settings.json
fi

# vscode
ln -sf "$cwd/vscode/settings.json" ~/Library/Application\ Support/Code/User/settings.json

# spacemacs
ln -sf "$cwd/emacs/.spacemacs" ~/.spacemacs

# git
ln -sf "$cwd/git/.gitconfig" ~/.gitconfig
ln -sf "$cwd/git/.gitignore" ~/.gitignore
ln -sf "$cwd/git/.gitattributes" ~/.gitattributes

# karabiner
ln -sf "$cwd/karabiner/karabiner.json" ~/.config/karabiner/karabiner.json
