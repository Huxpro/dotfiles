#!/bin/bash

work_path=$(pwd)

# bash
ln -sf $work_path"/bash/.bashrc" ~/.bashrc

# zsh
ln -sf $work_path"/zsh/.zshrc" ~/.zshrc
ln -sf $work_path"/zsh/.zshenv" ~/.zshenv
ln -sf $work_path"/zsh/.zprofile" ~/.zprofile
ln -sf $work_path"/zsh/oh-my-zsh/themes/refined-lambda.zsh-theme" ~/.oh-my-zsh/themes/refined-lambda.zsh-theme

# vim
ln -sf $work_path"/vim/.vimrc" ~/.vimrc
ln -sf $work_path"/vim/.vimrc" ~/.ideavimrc

# git
ln -sf $work_path"/git/.gitconfig" ~/.gitconfig
ln -sf $work_path"/git/.gitignore" ~/.gitignore
ln -sf $work_path"/git/.gitattributes" ~/.gitattributes

# karabiner
ln -sf $work_path"/karabiner/karabiner.json" ~/.config/karabiner/karabiner.json
