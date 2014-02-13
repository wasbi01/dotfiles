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
nnoremap <Space>gn :<C-u>Git now %<Enter>
nnoremap <Space>gN :<C-u>Git now --rebase<Enter>
" }}}

" Tag
NeoBundle 'alpaca-tc/alpaca_tags.git'
augroup AlpacaTags
  autocmd!
  if exists(':Tags')
    autocmd BufWritePost Gemfile TagsBundle
    autocmd BufEnter * TagsSet
    " 毎回保存と同時更新する
    autocmd BufWritePost * TagsUpdate
  endif
augroup END

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

" unite-quickfix
NeoBundle 'osyo-manga/unite-quickfix.git'
"}}}

" vimfiler{{{
NeoBundle 'Shougo/vimfiler'
" vimfilerをデフォルトのfilerにする
let g:vimfiler_as_default_explorer=1
autocmd! FileType vimfiler call <Plug>(vimfiler_switch_to_history_directory)
" NERDTree風vimfiler
nnoremap <silent> vf :VimFiler -buffer-name=explorer -split -winwidth=45 -toggle -no-quit<CR>
"}}}

" ruby
NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tpope/vim-endwise.git'
NeoBundle 'vim-scripts/ruby-matchit.git'

" rspec
NeoBundle 'thoughtbot/vim-rspec.git'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'kana/vim-altr.git'
nmap <C-n> <Plug>(altr-forward)
nmap <C-p> <Plug>(altr-back)
" For ruby tdd
call altr#define('%.rb','spec/%_spec.rb')
" For rails tdd
call altr#define('app/models/%.rb','spec/models/%_spec.rb','spec/factories/%s.rb')
call altr#define('app/controllers/%.rb','spec/controllers/%_spec.rb')
call altr#define('app/helpers/%.rb','spec/helpers/%_spec.rb')

NeoBundleLazy 'thoughtbot/vim-rspec', {
                \ 'depends'  : 'tpope/vim-dispatch',
                \ 'autoload' : { 'filetypes' : ['ruby'] }
              \ }
let g:rspec_command = "Dispatch rspec {spec}"
let s:bundle = neobundle#get('vim-rspec')
function! s:bundle.hooks.on_source(bundle)
   let g:rspec_command = 'Dispatch rspec {spec}'
endfunction
nmap <silent> <Space>rs :call RunCurrentSpecFile()<CR>
nmap <silent> <Space>rl :call RunNearestSpec()<CR>
"nmap <silent> <C-s>l :call RunLastSpec()<CR>
"nmap <silent> <C-s>a :call RunAllSpecs()<CR>

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

"文法
"syntaxに応じて色付け
syntax on
function! RSpecSyntax()
  hi def link rubyRailsTestMethod             Function
  syn keyword rubyRailsTestMethod describe context it its specify shared_examples_for it_should_behave_like before after around subject fixtures controller_name helper_name
  syn match rubyRailsTestMethod '\<let\>!\='
  syn keyword rubyRailsTestMethod violated pending expect double mock mock_model stub_model
  syn match rubyRailsTestMethod '\.\@<!\<stub\>!\@!'
endfunction
autocmd BufReadPost *_spec.rb call RSpecSyntax()

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
" status line
set statusline=%<     " 行が長すぎるときに切り詰める位置
set statusline+=[%n]  " バッファ番号
set statusline+=%m    " %m 修正フラグ
set statusline+=%r    " %r 読み込み専用フラグ
set statusline+=%h    " %h ヘルプバッファフラグ
set statusline+=%w    " %w プレビューウィンドウフラグ
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}  " fencとffを表示
set statusline+=%y    " バッファ内のファイルのタイプ
set statusline+=\     " 空白スペース
if winwidth(0) >= 130
  set statusline+=%F    " バッファ内のファイルのフルパス
else
  set statusline+=%t    " ファイル名のみ
endif
set statusline+=%=    " 左寄せ項目と右寄せ項目の区切り
set statusline+=%{fugitive#statusline()}  " Gitのブランチ名を表示
set statusline+=\ \   " 空白スペース2個
set statusline+=%1l   " 何行目にカーソルがあるか
set statusline+=/
set statusline+=%L    " バッファ内の総行数
set statusline+=,
set statusline+=%c    " 何列目にカーソルがあるか
set statusline+=%V    " 画面上の何列目にカーソルがあるか
set statusline+=\ \   " 空白スペース2個
set statusline+=%P    " ファイル内の何％の位置にあるか

"範囲選択してタブ移動
vnoremap <tab> >gv
vnoremap <S-tab> <gv
