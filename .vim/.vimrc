set nocompatible " vi互換のVimとして動作. これが無いとプラグインが動作しなくなったりするが、最近はなくてもいいらしい

"----------------------------------------------------------
" Neobundle
"----------------------------------------------------------
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

" インストールするプラグインを以下に記載
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

" 遅延ロードするプラグインを以下に記載
" Node.js用. 「gf」でrequireしたモジュールにジャンプ
NeoBundleLazy 'moll/vim-node',      {'autoload':{'filetypes':['javascript']}}
" Javascript用. ES6含めたJavascriptの構文をハイライトする
NeoBundleLazy 'othree/yajs.vim',    {'autoload':{'filetypes':['javascript']}}
" JSON用. indentLineプラグインの影響でダブルクォーテーションが非表示になっていた問題を解決する
NeoBundleLazy 'elzr/vim-json',      {'autoload':{'filetypes':['json']}}

" vimのlua機能が使える時だけ以下のプラグインをインストールする. 「vim --version | grep lua」で有効化されてるか確認
if has('lua')
    " コードの自動補完
    NeoBundle 'Shougo/neocomplete.vim'
    " スニペットの補完機能
    NeoBundle "Shougo/neosnippet"
    " スニペット集
    NeoBundle 'Shougo/neosnippet-snippets'
endif

call neobundle#end()

" ファイルタイプ別のプラグイン/インデントを有効にする
filetype plugin indent on

" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
NeoBundleCheck

"----------------------------------------------------------
" カラースキーム
"----------------------------------------------------------
if neobundle#is_installed('molokai')
    colorscheme molokai " カラースキームにmolokaiを設定する
endif

set t_Co=256 " iTerm2など既に256色環境なら無くても良い
syntax enable " 構文に色を付ける

"----------------------------------------------------------
" 文字
"----------------------------------------------------------
set encoding=utf-8 " 読み込み時の文字コード
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
scriptencoding utf-8 " Vim Script内で使用する文字コードを指定
set fileformats=unix,dos,mac " 改行コードの自動判別

" □や○の文字があってもカーソル位置がずれないようにする
" iTerm2を使ってる場合は設定から「Treat ambiguous-width characters as double width」にチェックする必要がある
set ambiwidth=double

let g:vim_json_syntax_conceal = 0 " JSON用. indentLineプラグインの影響でダブルクォーテーションが非表示になっていた問題を解決する

"----------------------------------------------------------
" ステータスライン
"----------------------------------------------------------
set laststatus=2 " ステータスラインを常に表示
set showmode " 現在のモードを表示
set showcmd " 打ったコマンドをステータスラインの下に表示
set ruler " ステータスラインの右側にカーソルの位置を表示する

"----------------------------------------------------------
" コマンドモード
"----------------------------------------------------------
set wildmode=list:full " コマンドモードの補完
set history=5000 " 保存する履歴の数

"----------------------------------------------------------
" タブ・インデント
"----------------------------------------------------------
set tabstop=4 " ファイル内のタブが対応する空白の数
set softtabstop=4 " タブキーを押した時に挿入されるスペース数
set autoindent " 新しい行のインデントを自動実行
set smartindent " 高度な自動インデント
set shiftwidth=4 " インデントの自動実行するスペース数
set expandtab " タブをスペースに変換する

" Javascript用. インデントを2にする
autocmd! FileType javascript    set shiftwidth=2 tabstop=2 softtabstop=2
autocmd! FileType json          set shiftwidth=2 tabstop=2 softtabstop=2

"----------------------------------------------------------
" 文字列検索
"----------------------------------------------------------
set incsearch " インクリメンタルサーチ. １文字入力毎に検索を行う
set ignorecase " 検索パターンに大文字を含まなければ大文字小文字を区別しない
set smartcase " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch " 検索結果をハイライト

" ESCキー2度押しでハイライトを無効化
nnoremap <Esc><Esc> :<C-u>set nohlsearch!<CR>

"----------------------------------------------------------
" カーソル
"----------------------------------------------------------
set whichwrap=b,s,h,l,<,>,[,],~ " 矢印キーで自由に移動
set number " 行番号を表示
set cursorline " カーソルラインをハイライト

" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

" backspaceキーの有効化
set backspace=indent,eol,start

"----------------------------------------------------------
" カッコ・タグの対応
"----------------------------------------------------------
set showmatch " 括弧の対応関係を一瞬表示する
source $VIMRUNTIME/macros/matchit.vim " HTMLタグをマッチさせる

"----------------------------------------------------------
" マウスでカーソル移動とスクロール
"----------------------------------------------------------
if has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif

"----------------------------------------------------------
" クリップボードからのペースト
"----------------------------------------------------------
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

"----------------------------------------------------------
" NeoCompleteとNeoSnippet
"----------------------------------------------------------
if neobundle#is_installed('neocomplete.vim')
    " neocompleteを有効にする
    let g:neocomplete#enable_at_startup = 1
    " smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
    let g:neocomplete#enable_smart_case = 1
    " ちょっとかゆいとこまで補完. 「neocomplete」が「neocomplete#」まで補完してくれる
    let g:neocomplete#enable_auto_delimiter = 1
    " 1文字目の入力から補完のポップアップを表示
    let g:neocomplete#auto_completion_start_length = 1
    " バックスペースで補完のポップアップを閉じる
    inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"
    " エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定
    imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
    " タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ
    imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"
endif
