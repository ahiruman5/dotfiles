#!/bin/sh

#setup.shを置いてあるパスをCURRENTに代入
CURRENT=$(cd $(dirname $0) && pwd)

#setup.shと同じ階層のファイルをホームディレクトリに向けてシンボリックリンクを貼る
ln -sf ${CURRENT}/.bash/.bash_profile ~
ln -sf ${CURRENT}/.vim/.vimrc ~
ln -sf ${CURRENT}/.gitconfig ~
ln -sf ${CURRENT}/.agignore ~
ln -sf ${CURRENT}/.dir_colors ~

if [ ! -d ~/.zsh/ ]
then
    mkdir ~/.zsh/
fi
ln -sf ${CURRENT}/.zsh/.zshenv ~/.zsh/
ln -sf ${CURRENT}/.zsh/.zshrc ~/.zsh/

if [ ! -d ~/.peco/ ]
then
    mkdir ~/.peco/
fi
ln -sf ${CURRENT}/.peco/config.json ~/.peco/

if [ ! -d ~/bin/ ]
then
    mkdir ~/bin/
fi

ln -sf ${CURRENT}/bin/git_diff_wrapper ~/bin/

#MacとLinuxでそれぞれ別のコマンドを利用
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        ln -sf ${CURRENT}/bin/mac/peco ~/bin/
        ln -sf ${CURRENT}/bin/mac/exa ~/bin/
        ;;
    linux*)
        #Linux用の設定
        ln -sf ${CURRENT}/bin/linux/peco ~/bin/
        ln -sf ${CURRENT}/bin/linux/exa ~/bin/
        ln -sf ${CURRENT}/bin/linux/jq ~/bin/
        ;;
esac
