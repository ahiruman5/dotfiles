#!/bin/bash

# dotfilesのPATHを取得
CURRENT=$(cd $(dirname $0) && pwd)

# ディレクトリ作成
if [ ! -d ~/bin/ ]
then
    mkdir ~/bin/
fi

if [ ! -d ~/.zsh/ ]
then
    mkdir ~/.zsh/
fi

if [ ! -d ~/.config/nvim/ ]
then
    mkdir -p ~/.config/nvim/
fi

# zplugが未インストールであればインストールする
if [ ! -e "${HOME}/.zplug" ]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

# シンボリックリンク
ln -sf ${CURRENT}/.bash/.bash_profile ~
ln -sf ${CURRENT}/.vim/.vimrc ~
ln -sf ${CURRENT}/nvim/init.vim ~/.config/nvim/
ln -sf ${CURRENT}/.gitconfig ~
ln -sf ${CURRENT}/.agignore ~
ln -sf ${CURRENT}/bin/git_diff_wrapper ~/bin/
ln -sf ${CURRENT}/.zsh/.zshenv ~/.zsh/
ln -sf ${CURRENT}/.zsh/.zshrc ~/.zsh/
