#!/bin/sh

#setup.shを置いてあるパスをCURRENTに代入
CURRENT=$(cd $(dirname $0) && pwd)

#setup.shと同じ階層のファイルをホームディレクトリに向けてシンボリックリンクを貼る
ln -sf ${CURRENT}/.bash/.bash_profile ~
ln -sf ${CURRENT}/.bash/.bashrc ~
ln -sf ${CURRENT}/.vim/.vimrc ~
ln -sf ${CURRENT}/.git-prompt.sh ~
ln -sf ${CURRENT}/.gitconfig ~
ln -sf ${CURRENT}/.git-completion.bash ~

if [ ! -d ~/.zsh/ ]
then
    mkdir ~/.zsh/
fi
ln -sf ${CURRENT}/.zsh/.zshenv ~/.zsh/
ln -sf ${CURRENT}/.zsh/.zshrc ~/.zsh/

if [ ! -d ~/.zsh/bin/ ]
then
    mkdir ~/.zsh/bin/
fi

#MacとLinuxでそれぞれ別のpecoを利用
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        ln -sf ${CURRENT}/.zsh/bin/peco/mac/peco ~/.zsh/bin/
        ;;
    linux*)
        #Linux用の設定
        ln -sf ${CURRENT}/.zsh/bin/peco/linux/peco ~/.zsh/bin/
        ;;
esac


if [ ! -d ~/bin/ ]
then
    mkdir ~/bin/
fi
ln -sf ${CURRENT}/bin/git_diff_wrapper ~/bin/
ln -sf ${CURRENT}/.dir_colors ~