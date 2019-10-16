#!/bin/sh

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

# シンボリックリンク
ln -sf ${CURRENT}/.bash/.bash_profile ~
ln -sf ${CURRENT}/.vim/.vimrc ~
ln -sf ${CURRENT}/nvim/init.vim ~/.config/nvim/
ln -sf ${CURRENT}/.gitconfig ~
ln -sf ${CURRENT}/.agignore ~
ln -sf ${CURRENT}/bin/git_diff_wrapper ~/bin/
ln -sf ${CURRENT}/.zsh/.zshenv ~/.zsh/
ln -sf ${CURRENT}/.zsh/.zshrc ~/.zsh/


# OS毎のバイナリ配置
case ${OSTYPE} in
    darwin*)
        # Mac用のバイナリ
        ln -sf ${CURRENT}/bin/mac/exa ~/bin/
        ln -sf ${CURRENT}/bin/mac/fzf ~/bin/
        ;;
    linux*)
        # Linux用のバイナリ
        ln -sf ${CURRENT}/bin/linux/exa ~/bin/
        ln -sf ${CURRENT}/bin/linux/jq ~/bin/
        ln -sf ${CURRENT}/bin/linux/fzf ~/bin/
        ln -sf ${CURRENT}/bin/linux/ag ~/bin/
        ;;
esac
