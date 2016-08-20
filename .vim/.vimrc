set nocompatible               " vi互換のVimとして動作. これが無いとプラグインが動作しなくなったりするが、最近はなくてもいいらしい

"---------------------------
" Start Neobundle Settings.
"---------------------------
if has('vim_starting')
    " 初回起動時のみruntimepathにneobundleのパスを指定する
    set runtimepath+=~/.vim/bundle/neobundle.vim/

    " Neobundleが未インストールであればgit clone
    if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
        echo "install neobundle..."
        :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
    endif
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" インストールするプラグインをここに記述
" Neobundle自身を管理
NeoBundleFetch 'Shougo/neobundle.vim'
" カラースキーマmolokai
NeoBundle 'tomasr/molokai'
" ステータスラインの表示内容強化
NeoBundle 'itchyny/lightline.vim'
" インデントの可視化
NeoBundle 'Yggdroot/indentLine'
" 末尾の全角半角空白文字を赤くハイライト
NeoBundle 'bronson/vim-trailing-whitespace'

call neobundle#end()

" ファイルタイプ別のプラグイン/インデントを有効にする
filetype plugin indent on

" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
NeoBundleCheck

"-------------------------
" End Neobundle Settings.
"-------------------------

" molokaiを適用
colorscheme molokai
set t_Co=256 " iTermなど既に256色環境なら無くても良い
syntax enable " 構文に色を付ける

set encoding=utf-8 " TODO
set fileencoding=utf-8 " TODO
scriptencoding utf-8 " Vim Script内で使用するエンコーディングを指定. vimrcもそのひとつ

set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " ファイルエンコーディングの自動判別対象を指定. 左側が優先される TODO

" 改行コードの自動認識
set fileformats=unix,dos,mac

" □や○の文字があってもカーソル位置がずれないようにする
" iTerm2を使ってる場合は設定から「Treat ambiguous-width characters as double width」にチェックする必要がある
set ambiwidth=double

"----------------------------------------------------------
" 表示
"----------------------------------------------------------
set showmode "現在のモードを表示
set showcmd "打ったコマンドをステータスラインの下に表示
set number " 行番号を表示
set ruler " ステータスラインの右側にカーソルの位置を表示する

" ステータスラインを常に表示
set laststatus=2

"----------------------------------------------------------
" コマンドモード
"----------------------------------------------------------
set wildmode=list:full "コマンドモードの補完
set history=5000 "保存する履歴の数
"前方一致検索をCtrl+PとCtrl+Nで TODO neocomplete入れたら使わなくていいかも
cnoremap <C-P> <UP>
cnoremap <C-N> <DOWN>

"----------------------------------------------------------
" バッファの切り替え TODO 使ってないから要らないかも
"----------------------------------------------------------
nnoremap <C-n> :bn<CR>
nnoremap <C-p> :bp<CR>
set hidden "変更中のバッファを保存しないで他のバッファを表示



"----------------------------------------------------------
" タブ・インデント
"----------------------------------------------------------
set tabstop=4 "ファイル内の <Tab> が対応する空白の数
set softtabstop=4 "<Tab> キーをおした時に挿入されるスペース数
set autoindent "新しい行のインデントを自動実行
set smartindent " 高度な自動インデント
set shiftwidth=4 "インデントの自動実行するスペース数
set expandtab " タブをスペースに変換する

"----------------------------------------------------------
" 検索
"----------------------------------------------------------
set incsearch " インクリメンタルサーチ. １文字入力毎に検索を行う
set ignorecase "検索パターンに大文字を含まなければ大文字小文字を区別しない
set smartcase "検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch "検索結果をハイライト
" ESCキー2度押しでハイライトを無効化
nnoremap <Esc><Esc> :<C-u>set nohlsearch!<CR>

"----------------------------------------------------------
" カーソル
"----------------------------------------------------------
"行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

" backspaceキーの有効化
set backspace=indent,eol,start

"----------------------------------------------------------
" カッコ・タグの対応
"----------------------------------------------------------
set showmatch "括弧の対応関係を一瞬表示する
source $VIMRUNTIME/macros/matchit.vim "HTMLタグをマッチさせる

"----------------------------------------------------------
" マウスでカーソル移動
"----------------------------------------------------------
if has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632') " I couldn't use has('mouse_sgr') :-(
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif

"----------------------------------------------------------
" マップ
"----------------------------------------------------------
set whichwrap=b,s,h,l,<,>,[,],~ "矢印で自由に移動

" 挿入モードでクリップボードからペーストする時に自動でインデントさせないようにする
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

" tplとhtml拡張子はファイルタイプをphpとして判定
augroup SetFiletypePHP
    autocmd!
    autocmd BufNewFile,BufRead *.tpl        setlocal filetype=php
    autocmd BufNewFile,BufRead *.html       setlocal filetype=php
augroup END