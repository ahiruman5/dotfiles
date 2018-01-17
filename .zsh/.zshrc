#----------------------------------------------------------
# zplug
#----------------------------------------------------------
# zplugが未インストールであればインストールする
if [ ! -d ~/.zplug ]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi

# init.zsh読み込み
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
# 基本設定
#----------------------------------------------------------
# ディレクトリ名でcd
setopt auto_cd
# cd時に自動でディレクトリスタックに追加する
setopt auto_pushd
# ディレクトリスタックと重複したディレクトリをスタックに追加しない
setopt pushd_ignore_dups
# ディレクトリの補完時は末尾に/を表示
setopt no_auto_remove_slash
# 補完候補の表示順を水平方向にする
setopt list_rows_first
# 数値でソート
setopt numeric_glob_sort
# 隠しファイルも補完
setopt glob_dots
# スペルミスの修正候補を提示
setopt correct
# ファイル名のスペルミスの修正候補を提示
setopt correct_all
# historyコマンドをコマンド履歴に記録しない
setopt hist_no_store
# コマンド履歴に実行時間も記録する
setopt extended_history
# コマンド中の余分なスペースは削除して履歴に記録する
setopt hist_reduce_blanks
# 履歴をすぐに追加する(通常はシェル終了時)
setopt inc_append_history
# Zsh間で履歴を共有する
setopt share_history
# 「rm *」で確認を求める機能を無効化する
setopt rm_star_silent
# Ctrl+Dによるログアウトを無効化する
setopt ignore_eof
# コマンドのフロー制御を無効にする
setopt no_flow_control
# ビープ音を無効化する
setopt no_beep

#----------------------------------------------------------
# 環境変数
#----------------------------------------------------------
# 言語設定
export LANG=ja_JP.UTF-8
# エディター設定
export EDITOR=vim
# スペルミス時に無視するパターン
export CORRECT_IGNORE='_*'
# ファイル名のスペルミス時に無視するパターン
export CORRECT_IGNORE_FILE='.*'

#----------------------------------------------------------
# PATH
#----------------------------------------------------------
# dotfilesで管理してるbinディレクトリにPATHを通す
path=($HOME/bin $path)

#nodebrewを使う場合はPATHを通す
if [ -d $HOME/.nodebrew ]
then
    path=(~/.nodebrew/current/bin(N-/) $path)
fi

#pyenvを使う場合はPATHを通す
if [ -d $HOME/.pyenv ]
then
    path=(~/.pyenv/bin(N-/) $path)
    eval "$(pyenv init -)"
fi

#cargoを使う場合はPATHを通す
if [ -d $HOME/.cargo ]
then
    path=(~/.cargo/bin(N-/) $path)
fi

#パスの重複を除外
typeset -U path cdpath fpath manpath

#----------------------------------------------------------
# alias
#----------------------------------------------------------
# exaを実行しモダンな感じのlsを表示(変更時刻順でソート)
alias ll='exa -aghlF -s=modified --git'
# exaを実行しモダンな感じのtreeを表示(size順でソート)
alias tree='exa -aghlrFT -s=size --git'
# ag検索時に隠しファイルも対象にする
alias ag='ag --hidden'
# コマンド履歴の実行時刻と実行時間を表示. 表示件数は全件.
alias history='history -Di 1'
# grepで検索した文字列をハイライト
alias grep='grep --color=auto'

#----------------------------------------------------------
# PROMPT
#----------------------------------------------------------
# カラー設定
local fg_red=$'%{\e[38;5;1m%}%}'
local fg_green=$'%{\e[38;5;2m%}%}'
local fg_yellow=$'%{\e[38;5;3m%}%}'
local fg_blue=$'%{\e[38;5;4m%}%}'

# 通常のプロンプト
PURE_PROMPT_SYMBOL='❯❯❯'

# スペル訂正時のプロンプト
SPROMPT="( ',_>') { "${fg_yellow}"%R${reset_color}は"${fg_green}"%B%r%b${reset_color}の間違いかね?
<(;'A')> { そう!"${fg_blue}"(y)${reset_color}, 違う!"${fg_red}"(n) :${reset_color} "

#----------------------------------------------------------
# zstyle
#----------------------------------------------------------
#補完候補を一覧から選択する
zstyle ':completion:*:default' menu select=2
#大文字、小文字を区別せず補完する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
#補完時のハイライト設定
zstyle ':completion:*' list-colors ''

#----------------------------------------------------------
# キーバインド
#----------------------------------------------------------
# キーバインドをemacsモードに設定
bindkey -e

# コマンド履歴からインクリメンタル検索
bindkey '^R' anyframe-widget-put-history

# 単語単位のカーソル移動
bindkey "^H" forward-word
bindkey "^F" backward-word

# カーソル位置から行頭または行末までの削除
bindkey "^J" backward-kill-word

#----------------------------------------------------------
# コマンド履歴
#----------------------------------------------------------
# コマンド履歴の保存先
HISTFILE=~/.zsh_history
# コマンド履歴に保存される件数
SAVEHIST=100000
# メモリにキャッシュするコマンド履歴件数
HISTSIZE=100000

#----------------------------------------------------------
# umask
#----------------------------------------------------------
# 新規ファイルは644、新規ディレクトリは755
umask 022
