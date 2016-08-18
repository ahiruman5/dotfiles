if [ -x /usr/local/bin/zsh ]
then
    export ZDOTDIR=${HOME}/.zsh
    exec /usr/local/bin/zsh -l
else
    source ~/.bashrc
fi
