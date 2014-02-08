if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here: 
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'

" 予測変換してくれる
NeoBundle 'Shougo/neocomplcache'
" neocomplcacheをデフォルトで有効化
let g:neocomplcache_enable_at_startup=1

" git管理
NeoBundle 'tpope/vim-fugitive'
" fugitive用の設定 {{{
nnoremap <Space>gd :<C-u>Gdiff<Enter>
nnoremap <Space>gs :<C-u>Gstatus<Enter>
nnoremap <Space>ga :<C-u>Gwrite<Enter>
nnoremap <Space>gc :<C-u>Git checkout<Enter>
nnoremap <Space>gC :<C-u>Git commit --amend<Enter>
nnoremap <Space>gB :<C-u>Gblame<Enter>
nnoremap <Space>gb :<C-u>Git branch<Enter>
"Git now 導入まで待
"nnoremap <Space>gn :<C-u>Git now %<Enter>
"nnoremap <Space>gN :<C-u>Git now --rebase<Enter>
" }}}

" unite{{{
"" neocomplcacheとの連携
imap <C-k> <Plug>(neocomplcache_start_unite_complete)
nnoremap <silent> <S-q> :<C-u>Unite buffer file_mru<CR>
nnoremap <silent> <S-r> :<C-u>Unite -start-insert file_rec file_mru<CR>

" ファイルのアウトラインを表示
NeoBundle 'h1mesuke/unite-outline.git'
nnoremap <silent> <C-o> :<C-u>Unite -vertical outline<CR>

" command, search, yank の履歴を表示
NeoBundle 'thinca/vim-unite-history.git'
noremap <C-y><C-p> :Unite -buffer-name=register register<CR>
let g:unite_source_history_yank_enable=1
nnoremap <C-h> :<C-u>Unite history/

" unite-grep
NeoBundle 'Sixeight/unite-grep.git'

" unite-help
NeoBundle 'tsukkee/unite-help.git'
"}}}


" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

"文法
"syntaxに応じて色付け
syntax on
"行番号を表示
set number
"列番号を表示
set ruler
"閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
"検索時に大文字を含んでいたら大/小を区別
set smartcase
"新しい行を作ったときに高度な自動インデントを行う
set smartindent
"タブの代わりに空白文字を挿入する
set expandtab
"シフト移動幅
set shiftwidth=2
"行頭の余白内でTabを撃ちこむと、'shiftwidth'の数だけインデントを行う
set smarttab
"補完候補を表示
set wildmenu
"現在のモードを表示
set showmode
"入力中のコマンドを表示
set showcmd
"コマンドライン保管をシェルっぽく
set wildmode=longest:full
"カーソル移動時の上下の余白
set scrolloff=5
"オムニ補完
set omnifunc=syntaxcomplete#Complete
"filetype plugin indent on
"swapファイルを作成しない
set noswapfile

"範囲選択してタブ移動
vnoremap <tab> >gv
vnoremap <S-tab> <gv
