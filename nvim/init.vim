set encoding=utf-8
scriptencoding utf-8
" ↑1行目は読み込み時の文字コードの設定
" ↑2行目はVim script内でマルチバイトを使う場合の設定
" Vim Scritptにvimrcも含まれるので、日本語でコメントを書く場合は先頭にこの設定が必要になる

"----------------------------------------------------------
" vim-plug
"----------------------------------------------------------
if has('vim_starting')
    " vim-plugが未インストールであればインストールする
    if !isdirectory(expand('~/.local/share/nvim/site/autoload/'))
        echo 'install vim-plug...'
        call system('curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
    endif
endif

call plug#begin('~/.local/share/nvim/site/plugged')

" インストールするVimプラグインを以下に記述
" カラースキームmolokai
Plug 'ahiruman5/molokai'
" Gitを操作するプラグイン
Plug 'tpope/vim-fugitive'
" GitのDiff情報を左端に表示
Plug 'airblade/vim-gitgutter'
" ステータスラインの表示内容強化
Plug 'itchyny/lightline.vim'
" 検索ヒット数を表示
Plug 'osyo-manga/vim-anzu'
" インデントの可視化
Plug 'Yggdroot/indentLine'
" 末尾の全角半角空白文字を赤くハイライト
Plug 'bronson/vim-trailing-whitespace'
" コメントのオンオフを行う
Plug 'scrooloose/nerdcommenter'
" HTML5用. HTML5の構文をハイライトする
Plug 'othree/html5.vim'
" Javascript用. ES6含めたJavascriptの構文をハイライトする
Plug 'othree/yajs.vim'
" Node.js用. 「gf」でrequireしたモジュールにジャンプ
Plug 'moll/vim-node'
" fzfをvimで利用
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" 遅延読み込みするVimプラグインを以下に記述
" JSON用. indentLineプラグインの影響でダブルクォーテーションが非表示になっていた問題を解決する
Plug 'elzr/vim-json', {'for': 'json'}

" MacOS環境のみインストールする
if has('mac')
    " Markdown編集用プラグイン
    Plug 'plasticboy/vim-markdown'
    " 文章整形用プラグイン. 主にMarkdownのテーブル用
    Plug 'h1mesuke/vim-alignta'
    " Markdownのプレビュー用プラグイン
    Plug 'kannokanno/previm'
    " ブラウザ起動
    Plug 'tyru/open-browser.vim'
endif

call plug#end()

"----------------------------------------------------------
" カラースキーム
"----------------------------------------------------------
if isdirectory(expand('~/.local/share/nvim/site/plugged/molokai/'))
    colorscheme molokai " カラースキームにmolokaiを設定する
endif

set t_Co=256 " iTerm2など既に256色環境なら無くても良い

"----------------------------------------------------------
" 文字
"----------------------------------------------------------
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される

" □や○文字が崩れる問題を解決
set ambiwidth=double

let g:vim_json_syntax_conceal = 0 " JSON用. indentLineプラグインの影響でダブルクォーテーションが非表示になっていた問題を解決する

"----------------------------------------------------------
" Markdown
"----------------------------------------------------------
if has('mac')
    au BufRead,BufNewFile *.md set filetype=markdown
    let g:vim_markdown_conceal = 0 " 構文の隠蔽をオフ
    let g:vim_markdown_folding_disabled = 1 " 自動折り畳みをオフ
    let g:vim_markdown_new_list_item_indent = 2 " インデントを2にする
endif

"----------------------------------------------------------
" ステータスライン
"----------------------------------------------------------
set laststatus=2 " ステータスラインを常に表示
set showmode " 現在のモードを表示
set showcmd " 打ったコマンドをステータスラインの下に表示
set ruler " ステータスラインの右側にカーソルの現在位置を表示する

"----------------------------------------------------------
" コマンドモード
"----------------------------------------------------------
set wildmenu " コマンドモードの補完
set history=5000 " 保存するコマンド履歴の数

" ESCキーのマッピング
noremap <C-j> <Esc>
noremap! <C-j> <Esc>

" vim-nodeプラグイン用. 「gf」でジャンプしたファイルを水平展開
autocmd! User Node  nmap <buffer> gf <Plug>NodeSplitGotoFile

"----------------------------------------------------------
" タブ・インデント
"----------------------------------------------------------
set expandtab " タブ入力を複数の空白入力に置き換える
set tabstop=4 " 画面上でタブ文字が占める幅
set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent " 改行時に前の行のインデントを継続する
set smartindent " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=4 " smartindentで増減する幅

" Javascript用. インデントを2にする
autocmd! FileType javascript    set shiftwidth=2 tabstop=2 softtabstop=2
autocmd! FileType json          set shiftwidth=2 tabstop=2 softtabstop=2

" Javascript用. メソッドチェーンで改行した場合のインデントを無効
let g:javascript_opfirst = 1

"----------------------------------------------------------
" 文字列検索
"----------------------------------------------------------
set incsearch " インクリメンタルサーチ. １文字入力毎に検索を行う
set ignorecase " 検索パターンに大文字小文字を区別しない
set smartcase " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch " 検索結果をハイライト

" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

"----------------------------------------------------------
" カーソル
"----------------------------------------------------------
set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set number " 行番号を表示
" set cursorline " カーソルラインをハイライト

" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

" バックスペースキーの有効化
set backspace=indent,eol,start

"----------------------------------------------------------
" カッコ・タグの対応
"----------------------------------------------------------
set showmatch " 括弧の対応関係を一瞬表示する
source $VIMRUNTIME/macros/matchit.vim " Vimの「%」を拡張する

"----------------------------------------------------------
" マウスでカーソル移動とスクロール
"----------------------------------------------------------
set mouse=a

"----------------------------------------------------------
" vim-fugitive
"----------------------------------------------------------
set diffopt+=vertical " :Gdiffコマンド実行時の分割を垂直分割にする

"----------------------------------------------------------
" vim-gitgutter
"----------------------------------------------------------
let g:gitgutter_max_signs = 1000 " 表示させる差分の最大数

"----------------------------------------------------------
" NERDCommenter
"----------------------------------------------------------
let g:NERDSpaceDelims = 1 " コメントアウト時に半角空白を1文字挿入
let g:NERDDefaultAlign = 'left' " ネストしないようにコメントする

" 「,,」でコメントのオンオフ切り替え
nmap ,, <Plug>NERDCommenterToggle
vmap ,, <Plug>NERDCommenterToggle

"----------------------------------------------------------
" vim-anzu
"----------------------------------------------------------
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)

"----------------------------------------------------------
" fzf.vim
"----------------------------------------------------------
" Ctrl + Pでファイル検索
nnoremap <silent> <C-p> :Files<CR>
" Ctrl + Fでコマンド検索
nnoremap <silent> <C-f> :Commands<CR>
" ファイル検索時にプレビューを表示
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
