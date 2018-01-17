#----------------------------------------------------------
# zplug
#----------------------------------------------------------

# zplugが未インストールであればインストールする
if [ ! -d ~/.zplug ]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi

source ~/.zplug/init.zsh

# インストールするZshプラグインを以下に記述
# zplug自身を管理
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
# 履歴からコマンド候補を表示
zplug 'zsh-users/zsh-autosuggestions'
# 補完候補を強力にする
zplug 'zsh-users/zsh-completions'
# 履歴のインクリメンタル検索
zplug 'mollifier/anyframe'
# プロンプトのテーマをpureにする
zplug 'sindresorhus/pure', use:pure.zsh, from:github, as:theme
# Zshの非同期処理プラグイン. pureプラグインが非同期でgitのremote情報を取得するのに必要
zplug 'mafredri/zsh-async', from:github

# 遅延読み込みするZshプラグインを以下に記載
# コマンドのハイライト
zplug 'zsh-users/zsh-syntax-highlighting', defer:2

# 未インストールのZshプラグインがある場合、インストールするか尋ねる設定
if ! zplug check --verbose; then
    printf 'Install? [y/N]: '
    if read -q; then
        echo; zplug install
    fi
fi

# Zshプラグインを読み込み、コマンドにパスを通す
zplug load --verbose

#----------------------------------------------------------
# anyframe
#----------------------------------------------------------
# コマンド履歴から検索・実行する
bindkey '^r' anyframe-widget-put-history

#----------------------------------------------------------
# pure
#----------------------------------------------------------
# プロンプトの表示を変更
PURE_PROMPT_SYMBOL='❯❯❯'

export LANG=ja_JP.UTF-8
export EDITOR="$(which vim)"
path=($HOME/bin $path)

#nodebrewを使う場合はPATHを設定する
if [ -d $HOME/.nodebrew ]
then
    path=(~/.nodebrew/current/bin(N-/) $path)
fi

#pyenvを使う場合はPATHを設定する
if [ -d $HOME/.pyenv ]
then
    path=(~/.pyenv/bin(N-/) $path)
    eval "$(pyenv init -)"
fi

#パスの重複を除外
typeset -U path cdpath fpath manpath

#compinit関数のロード
autoload -Uz compinit
compinit

#補完候補をハイライトする
zstyle ':completion:*:default' menu select=2

#大文字、小文字を区別せず補完する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'


setopt prompt_subst
setopt auto_pushd
setopt correct

HISTFILE=~/.zsh_history
SAVEHIST=100000
HISTSIZE=100000



##history関連
#historyコマンドをhistoryに追加しない
setopt hist_no_store

#コマンドの実行した時の時間と処理にかかった時間をhistoryに追加する
#setopt extended_history

#余分なスペースを削除してからhistoryに追加する
setopt hist_reduce_blanks

#コマンドの実行時間を記録
setopt extended_history

#通常はシェルが終了してからhistoryに書き込まれるが
#このオプションを有効にすることで即書き込んでくれる
setopt inc_append_history

#他のシェルでhistoryに書き込まれたものをリアルタイムで参照が出来る
setopt share_history


##グロブ関連
#マッチングした時に文字列じゃなくて数値としてソートするようにする
setopt numeric_glob_sort

#rmコマンドの確認メッセージを無くす
setopt rm_star_silent

#デフォルトパーミッションの設定
#新規ファイルは644、新規ディレクトリは755
umask 022

alias history='history -Di 1'

#キーバインドをemacsモードに設定
bindkey -e

#プロンプトの色表示を可能にする
autoload -U colors
colors

#grepに色を付ける
alias grep='grep --color=auto'

#startColor='\e[0;'
#endColor='\e[m'
#
#insertColor='38;5;123m'
#
#PS1="%{'\e[0;38;5;123mテスト\e[m'%}"

local fg_red=$'%{\e[38;5;203m%}%}'
local fg_green=$'%{\e[38;5;118m%}%}'
local fg_blue=$'%{\e[38;5;051m%}%}'

PROMPT2="%_> "

SPROMPT="( ',_>') { やれやれ、"${fg_green}"%B%r%b%{${reset_color}%}かね?
<(;'A')> { そう!"${fg_blue}"(y)${reset_color}, 違う!"${fg_red}"(n) :%{${reset_color}%} "


#ディレクトリスタックに重複するディレクトリを登録しない
setopt pushd_ignore_dups

#ディレクトリを補完した時は/を付けたままにする
setopt no_auto_remove_slash

#補完候補を表示順を横にする
setopt list_rows_first

#ドットから始まるファイル・ディレクトリも補完
setopt glob_dots

#Ctrl+Dによるログアウトを無効にする
setopt ignore_eof

#コマンドのフロー制御を無効にする
setopt no_flow_control

#ビープを鳴らさない
setopt no_beep

#cd付けずにパス名を入力するだけで移動できる
setopt auto_cd

#emacs風キーバインド
bindkey -e

#前方一致histoory検索
bindkey "^N" history-beginning-search-forward
bindkey "^P" history-beginning-search-backward

#単語単位のカーソル移動
bindkey "^H" forward-word
bindkey "^F" backward-word

#カーソル位置から行頭または行末までの削除
bindkey "^J" backward-kill-word

#誤爆しやすいから無効化する
bindkey -r "^O"

#OS別の設定
case ${OSTYPE} in
    darwin*)
        #LSのカラー設定
        #brew install coreutilsでパッケージを入れる必要あり
        eval $(gdircolors -b $HOME/.dir_colors)
        #Mac用の設定
        alias ll='gls -alrtFG --color=auto'
        ;;
    linux*)
        #LSのカラー設定
        eval $(dircolors -b $HOME/.dir_colors)
        #Linux用の設定
        alias ll='ls -alrtF --color=auto'
        ;;
esac

#補完時にもLSCOLORを使う
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
