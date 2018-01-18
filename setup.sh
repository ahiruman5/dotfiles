#!/bin/sh

# dotfilesのPATHを取得
CURRENT=$(cd $(dirname $0) && pwd)

# ディレクトリ作成
if [ ! -d ~/bin/ ]
then
    mkdir ~/bin/
fi

# シンボリックリンク
ln -sf ${CURRENT}/.bash/.bash_profile ~
ln -sf ${CURRENT}/.vim/.vimrc ~
ln -sf ${CURRENT}/.gitconfig ~
ln -sf ${CURRENT}/.agignore ~
ln -sf ${CURRENT}/.dir_colors ~
ln -sf ${CURRENT}/bin/git_diff_wrapper ~/bin/
ln -sf ${CURRENT}/.zsh ~


# OS毎のバイナリ配置
case ${OSTYPE} in
    darwin*)
        # Mac用のバイナリ
        ln -sf ${CURRENT}/bin/mac/exa ~/bin/
        ;;
    linux*)
        # Linux用のバイナリ
        ln -sf ${CURRENT}/bin/linux/exa ~/bin/
        ln -sf ${CURRENT}/bin/linux/jq ~/bin/
        ;;
esac
