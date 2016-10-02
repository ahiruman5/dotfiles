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
ln -sf ${CURRENT}/.agignore ~

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

#MacとLinuxでそれぞれ別のpecoを利用
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        ln -sf ${CURRENT}/bin/mac/peco ~/bin/
        ;;
    linux*)
        #Linux用の設定
        ln -sf ${CURRENT}/bin/linux/peco ~/bin/
        ;;
esac
ln -sf ${CURRENT}/.dir_colors ~
