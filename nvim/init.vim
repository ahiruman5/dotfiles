set encoding=utf-8
scriptencoding utf-8
" ↑1行目は読み込み時の文字コードの設定
" ↑2行目はVim script内でマルチバイトを使う場合の設定
" Vim Scritptにvimrcも含まれるので、日本語でコメントを書く場合は先頭にこの設定が必要になる

"----------------------------------------------------------
" NeoBundle
"----------------------------------------------------------
if has('vim_starting')
    " 初回起動時のみruntimepathにNeoBundleのパスを指定する
    set runtimepath+=~/.vim/bundle/neobundle.vim/

    " NeoBundleが未インストールであればgit cloneする
    if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
        echo "install NeoBundle..."
        :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
    endif
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" インストールするVimプラグインを以下に記述
" NeoBundle自身を管理
NeoBundleFetch 'Shougo/neobundle.vim'
" カラースキームmolokai
NeoBundle 'ahiruman5/molokai'
" Gitを操作するプラグイン
NeoBundle 'tpope/vim-fugitive'
" GitのDiffを左恥に表示
NeoBundle 'airblade/vim-gitgutter'
" ステータスラインの表示内容強化
NeoBundle 'itchyny/lightline.vim'
" 検索ヒット数を表示
NeoBundle "osyo-manga/vim-anzu"
" インデントの可視化
NeoBundle 'Yggdroot/indentLine'
" 末尾の全角半角空白文字を赤くハイライト
NeoBundle 'bronson/vim-trailing-whitespace'
" コメントのオンオフを行う
NeoBundle 'scrooloose/nerdcommenter'
" 構文エラーチェック
NeoBundle 'scrooloose/syntastic'
" 多機能セレクタ
NeoBundle 'ctrlpvim/ctrlp.vim'
" CtrlPの拡張プラグイン. 関数検索
NeoBundle 'tacahiroy/ctrlp-funky'
" CtrlPの拡張プラグイン. コマンド履歴検索
NeoBundle 'suy/vim-ctrlp-commandline'
" CtrlPの検索にagを使う
NeoBundle 'rking/ag.vim'
" HTML5用. HTML5の構文をハイライトする
NeoBundle 'othree/html5.vim'
" Javascript用. ES6含めたJavascriptの構文をハイライトする
NeoBundle 'othree/yajs.vim'
" Node.js用. プロジェクトに入ってるESLintを読み込む
NeoBundle 'pmsorhaindo/syntastic-local-eslint.vim'
" Node.js用. 「gf」でrequireしたモジュールにジャンプ
NeoBundle 'moll/vim-node'
" LSPクライアント
NeoBundle 'autozimu/LanguageClient-neovim'
" fzf
NeoBundle 'junegunn/fzf'

" 遅延読み込みするVimプラグインを以下に記述
" JSON用. indentLineプラグインの影響でダブルクォーテーションが非表示になっていた問題を解決する
NeoBundleLazy 'elzr/vim-json',      {'autoload':{'filetypes':['json']}}

" vimのlua機能が使える時だけ以下のVimプラグインをインストールする
if has('lua')
    " コードの自動補完
    NeoBundle 'Shougo/neocomplete.vim'
    " スニペットの補完機能
    NeoBundle "Shougo/neosnippet"
    " スニペット集
    NeoBundle 'Shougo/neosnippet-snippets'
endif

" MacOS環境のみインストールする
if has('mac')
    " Markdown編集用プラグイン
    NeoBundle 'plasticboy/vim-markdown'
    " 文章整形用プラグイン. 主にMarkdownのテーブル用
    NeoBundle 'h1mesuke/vim-alignta'
    " Markdownのプレビュー用プラグイン
    NeoBundle 'kannokanno/previm'
    " ブラウザ起動
    NeoBundle 'tyru/open-browser.vim'
endif

call neobundle#end()

" ファイルタイプ別のVimプラグイン/インデントを有効にする
filetype plugin indent on

" 未インストールのVimプラグインがある場合、インストールするかどうか尋ねる設定
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
let NERDSpaceDelims = 1 " コメントアウト時に半角空白を1文字挿入

" 「,,」でコメントのオンオフ切り替え
nmap ,, <Plug>NERDCommenterToggle
vmap ,, <Plug>NERDCommenterToggle

"----------------------------------------------------------
" NERDCommenter
"----------------------------------------------------------
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)

"----------------------------------------------------------
" lsp
"----------------------------------------------------------

" Minimal LSP configuration for JavaScript
let g:LanguageClient_serverCommands = {}
if executable('javascript-typescript-stdio')
  let g:LanguageClient_serverCommands.javascript = ['javascript-typescript-stdio']
  " Use LanguageServer for omnifunc completion
  autocmd FileType javascript setlocal omnifunc=LanguageClient#complete
else
  echo "javascript-typescript-stdio not installed!\n"
  :cq
endif

" <leader>ld to go to definition
autocmd FileType javascript nnoremap <buffer>
  \ <leader>ld :call LanguageClient_textDocument_definition()<cr>
" <leader>lh for type info under cursor
autocmd FileType javascript nnoremap <buffer>
  \ <leader>lh :call LanguageClient_textDocument_hover()<cr>
" <leader>lr to rename variable under cursor
autocmd FileType javascript nnoremap <buffer>
  \ <leader>lr :call LanguageClient_textDocument_rename()<cr>
autocmd FileType javascript nnoremap <buffer>
  \ <leader>lf :call LanguageClient_textDocument_documentSymbol()<cr>

function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()

nnoremap <silent> <C-p> :ProjectFiles<CR>
