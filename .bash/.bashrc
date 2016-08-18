export PATH="$HOME/local/bin:$HOME/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/local/lib:$LD_LIBRARY_PATH"
export LANG=ja_JP.UTF-8
export SHELL=/bin/bash
#export LC_CTYPE=C$
#export LC_ALL=C$
export SVN_EDITOR=vim
export LESSCHARSET=utf-8
export HISTTIMEFORMAT='%y/%m/%d %H:%M:%S '
export LSCOLORS=gxfxcxdxbxegedabagacad$
# 入力履歴をログアウト時に保存する。$
HISTFILE=~/.bash_history # 履歴をファイルに保存する$
HISTSIZE=9999            # メモリ内の履歴の数$
HISTFILESIZE=9999        # 保存される履歴の数$

source $HOME/.git-prompt.sh
source $HOME/.git-completion.bash   #git-completionの設定
PS1='\[\033[0;36m\][\u@\h:\w$(__git_ps1 "(%s)")]\\$ \[\033[0m\]'    #プロンプトにブランチ名を表示

alias ll='ls -alrtF'

#sshで今まで入ったことのあるホスト名を補完
if [ ! -f $HOME/.ssh/known_hosts ]
then
    touch $HOME/.ssh/known_hosts
fi
complete -W "$(sed 's/[ ,].*$/ /' ~/.ssh/known_hosts | tr -d '\n')" ssh
