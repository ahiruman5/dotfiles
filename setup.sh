#!/bin/sh

# dotfilesのPATHを取得
CURRENT=$(cd $(dirname $0) && pwd)

# シンボリックリンク
ln -sf ${CURRENT}/.bash/.bash_profile ~
ln -sf ${CURRENT}/.vim/.vimrc ~
ln -sf ${CURRENT}/.gitconfig ~
ln -sf ${CURRENT}/.agignore ~
ln -sf ${CURRENT}/.dir_colors ~
ln -sf ${CURRENT}/bin/git_diff_wrapper ~/bin/
ln -sf ${CURRENT}/.zsh/.zshenv ~/.zsh/
ln -sf ${CURRENT}/.zsh/.zshrc ~/.zsh/
ln -sf ${CURRENT}/.peco/config.json ~/.peco/

# ディレクトリ作成
if [ ! -d ~/.zsh/ ]
then
    mkdir ~/.zsh/
fi

if [ ! -d ~/bin/ ]
then
    mkdir ~/bin/
fi

if [ ! -d ~/.peco/ ]
then
    mkdir ~/.peco/
fi

# OS毎のバイナリ配置
case ${OSTYPE} in
    darwin*)
        #Mac用のバイナリ
        ln -sf ${CURRENT}/bin/mac/peco ~/bin/
        ln -sf ${CURRENT}/bin/mac/exa ~/bin/
        ;;
    linux*)
        #Linux用のバイナリ
        ln -sf ${CURRENT}/bin/linux/peco ~/bin/
        ln -sf ${CURRENT}/bin/linux/exa ~/bin/
        ln -sf ${CURRENT}/bin/linux/jq ~/bin/
        ;;
esac
