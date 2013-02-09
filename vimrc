﻿"========================================
" .vimrc
" author: m.fukui
"========================================
set nocompatible
"----------------------------------------
" 内部エンコード指定
"----------------------------------------
:set encoding=utf-8
:set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
:set fileformats=unix,dos,mac

"----------------------------------------
" ユーザーランタイムパス設定
"----------------------------------------
if isdirectory($HOME . '/.vim')
  let $MY_VIMRUNTIME = $HOME.'/.vim'
elseif isdirectory($HOME . '\vimfiles')
  let $MY_VIMRUNTIME = $HOME.'\vimfiles'
elseif isdirectory($VIM . '\vimfiles')
  let $MY_VIMRUNTIME = $VIM.'\vimfiles'
endif

"----------------------------------------
" システム設定
"----------------------------------------
" ファイルの上書きの前にバックアップを作る/作らない
" set writebackupを指定してもオプション 'backup' がオンでない限り、
" バックアップは上書きに成功した後に削除される。
set nowritebackup
" バックアップ/スワップファイルを作成する/しない
set nobackup
" if version >= 703
"   " 再読込、vim終了後も継続するアンドゥ(7.3)
"   set undofile
"   " アンドゥの保存場所(7.3)
"   set undodir=.
" endif
" クリップボードを共有
set clipboard+=unnamed
" 8進数を無効にする。<C-a>,<C-x>に影響する
set nrformats-=octal
" キーコードやマッピングされたキー列が完了するのを待つ時間(ミリ秒)
set timeout timeoutlen=3000 ttimeoutlen=100
" 編集結果非保存のバッファから、新しいバッファを開くときに警告を出さない
set hidden
" ヒストリの保存数
set history=50
" 日本語の行の連結時には空白を入力しない
set formatoptions+=mM
" Visual blockモードでフリーカーソルを有効にする
"set virtualedit=block
" カーソルキーで行末／行頭の移動可能に設定
set whichwrap=b,s,[,],<,>
" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start
" □や○の文字があってもカーソル位置がずれないようにする
set ambiwidth=double
" コマンドライン補完するときに強化されたものを使う
set wildmenu
" マウスを有効にする
"if has('mouse')
"  set mouse=a
"endif
" plugin, indent を使用可能にする
filetype on
filetype plugin on
filetype indent on

"----------------------------------------
" 検索
"----------------------------------------
" 検索の時に大文字小文字を区別しない
" ただし大文字小文字の両方が含まれている場合は大文字小文字を区別する
set ignorecase
set smartcase
" 検索時にファイルの最後まで行ったら最初に戻る
set wrapscan
" インクリメンタルサーチ
set incsearch
" 検索文字の強調表示
set hlsearch
" w,bの移動で認識する文字
" set iskeyword=a-z,A-Z,48-57,_,.,-,>
" vimgrep をデフォルトのgrepとする場合internal
" set grepprg=internal

"----------------------------------------
" 表示設定
"----------------------------------------
" スプラッシュ(起動時のメッセージ)を表示しない
" set shortmess+=I
" エラー時の音とビジュアルベルの抑制(gvimは.gvimrcで設定)
set noerrorbells
set novisualbell
set visualbell t_vb=
" マクロ実行中などの画面再描画を行わない
" set lazyredraw
" Windowsでディレクトリパスの区切り文字表示に / を使えるようにする
set shellslash
" 行番号表示
set number
if version >= 703
  " 相対行番号表示(7.3)
  " set relativenumber
endif
" 括弧の対応表示時間
set showmatch matchtime=1
" タブを設定
" set ts=4 sw=4 sts=4
" 自動的にインデントする
"set autoindent
" Cインデントの設定
set cinoptions+=:0
" タイトルを表示
set title
" コマンドラインの高さ (gvimはgvimrcで指定)
" set cmdheight=2
set laststatus=2
" コマンドをステータス行に表示
set showcmd
" 画面最後の行をできる限り表示する
set display=lastline
" Tab、行末の半角スペースを明示的に表示する
set list
set listchars=tab:^\ ,trail:~

" ハイライトを有効にする
syntax on
" 色テーマ設定
" gvimの色テーマは.gvimrcで指定する
" plugin を使うためここでは指定しない
" colorscheme mycolor

""""""""""""""""""""""""""""""
" ステータスラインに文字コード等表示
" iconvが使用可能の場合、カーソル上の文字コードをエンコードに応じた表示にするFencB()を使用
""""""""""""""""""""""""""""""
"if has('iconv')
"  set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=[0x%{FencB()}]\ (%v,%l)/%L%8P\ 
"else
"  set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=\ (%v,%l)/%L%8P\ 
"endif

" FencB() : カーソル上の文字コードをエンコードに応じた表示にする
" function! FencB()
"   let c = matchstr(getline('.'), '.', col('.') - 1)
"   let c = iconv(c, &enc, &fenc)
"   return s:Byte2hex(s:Str2byte(c))
" endfunction

" function! s:Str2byte(str)
"   return map(range(len(a:str)), 'char2nr(a:str[v:val])')
" endfunction

" function! s:Byte2hex(bytes)
"   return join(map(copy(a:bytes), 'printf("%02X", v:val)'), '')
" endfunction

"----------------------------------------
" diff/patch
"----------------------------------------
" diffの設定
if has('win32') || has('win64')
  set diffexpr=MyDiff()
  function! MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let cmd = '!diff ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
    silent execute cmd
  endfunction
endif

" 現バッファの差分表示(変更箇所の表示)
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" ファイルまたはバッファ番号を指定して差分表示。#なら裏バッファと比較
command! -nargs=? -complete=file Diff if '<args>'=='' | browse vertical diffsplit|else| vertical diffsplit <args>|endif
" パッチコマンド
set patchexpr=MyPatch()
function! MyPatch()
   call system($VIM."\\'.'patch -o " . v:fname_out . " " . v:fname_in . " < " . v:fname_diff)
endfunction

"----------------------------------------
" ノーマルモード
"----------------------------------------
" ヘルプ検索
nnoremap <F1> K
" 現在開いているvimスクリプトファイルを実行
nnoremap <F8> :source %<CR>
" 強制全保存終了を無効化
nnoremap ZZ <Nop>
" カーソルをj k では表示行で移動する。物理行移動は<C-n>,<C-p>
" キーボードマクロには物理行移動を推奨
" h l は行末、行頭を超えることが可能に設定(whichwrap)
nnoremap <Down> gj
nnoremap <Up>   gk
nnoremap h <Left>zv
nnoremap j gj
nnoremap k gk
nnoremap l <Right>zv
" .vimrc をコマンド<Space> - . で開く。
nnoremap <Space>. :<C-u>tabedit $MYVIMRC<CR>

"----------------------------------------
" 挿入モード
"----------------------------------------

"----------------------------------------
" ビジュアルモード
"----------------------------------------

"----------------------------------------
" コマンドモード
"----------------------------------------

"----------------------------------------
" Vimスクリプト
"----------------------------------------
""""""""""""""""""""""""""""""
" ファイルを開いたら前回のカーソル位置へ移動
" $VIMRUNTIME/vimrc_example.vim
""""""""""""""""""""""""""""""
augroup vimrcEx
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line('$') | exe "normal! g`\"" | endif
augroup END

""""""""""""""""""""""""""""""
" 挿入モード時、ステータスラインのカラー変更
""""""""""""""""""""""""""""""
"let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

"if has('syntax')
"  augroup InsertHook
"    autocmd!
"    autocmd InsertEnter * call s:StatusLine('Enter')
"    autocmd InsertLeave * call s:StatusLine('Leave')
"  augroup END
"endif
" if has('unix') && !has('gui_running')
"   " ESCですぐに反映されない対策
"   inoremap <silent> <ESC> <ESC>
" endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
    redraw
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

""""""""""""""""""""""""""""""
" 全角スペースを表示
""""""""""""""""""""""""""""""
" コメント以外で全角スペースを指定しているので、scriptencodingと、
" このファイルのエンコードが一致するよう注意！
" 強調表示されない場合、ここでscriptencodingを指定するとうまくいく事があります。
" scriptencoding cp932
function! ZenkakuSpace()
  silent! let hi = s:GetHighlight('ZenkakuSpace')
  if hi =~ 'E411' || hi =~ 'cleared$'
    highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
  endif
endfunction
if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme       * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif

""""""""""""""""""""""""""""""
" grep,tagsのためカレントディレクトリをファイルと同じディレクトリに移動する
""""""""""""""""""""""""""""""
" if exists('+autochdir')
"   "autochdirがある場合カレントディレクトリを移動
"   set autochdir
" else
"   "autochdirが存在しないが、カレントディレクトリを移動したい場合
"   au BufEnter * execute ":silent! lcd " . escape(expand("%:p:h"), ' ')
" endif

"----------------------------------------
" 各種プラグイン設定
"----------------------------------------

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle/'))
endif
" originalrepos on github
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
"NeoBundle 'VimClojure'
"NeoBundle 'Shougo/vimshell'
"NeoBundle 'Shougo/unite.vim'
"NeoBundle 'Shougo/neocomplcache'

" snippet 関連の設定
"NeoBundle 'Shougo/neosnippet'
"NeoBundle 'honza/snipmate-snippets'
"let g:neosnippet#snippets_directory = '~/.vim/bundle/snipmate-snippets/snippets'
" Plugin key-mappings.
"imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" SuperTab like snippets behavior.
"imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
"smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" For snippet_complete marker.
"if has('conceal')
"  set conceallevel = 2 concealcursor = i
"endif

"NeoBundle 'jpalardy/vim-slime'

" colorscheme の設定
" solarized カラースキーム
"NeoBundle 'altercation/vim-colors-solarized'
" mustang カラースキーム
"NeoBundle 'croaker/mustang-vim'
" wombat カラースキーム
"NeoBundle 'jeffreyiacono/vim-colors-wombat'
" jellybeans カラースキーム
"NeoBundle 'nanotech/jellybeans.vim'
" lucius カラースキーム
"NeoBundle 'vim-scripts/Lucius'
" zenburn カラースキーム
"NeoBundle 'vim-scripts/Zenburn'
" mrkn256 カラースキーム
"NeoBundle 'mrkn/mrkn256.vim'
" railscasts カラースキーム
"NeoBundle 'jpo/vim-railscasts-theme'
" pyte カラースキーム
"NeoBundle 'therubymug/vim-pyte'
" molokai カラースキーム
NeoBundle 'tomasr/molokai'
" unite で一覧選択できるようにする。
"NeoBundle 'ujihisa/unite-colorscheme'
" 既定値の設定
set t_Co=256
colorscheme molokai

" status line のカスタマイズ
" power-line の設定
NeoBundle 'Lokaltog/vim-powerline'
" スペシャルシンボルを使わない
let g:Powerline_symbols = 'compatible'
" シンボルを上書きする
let g:Powerline_symbols_override = {
\ 'LINE': 'Caret'
\ }
" モード名を上書きする
let g:Powerline_mode_n  = 'normal'
let g:Powerline_mode_i  = 'insert'
let g:Powerline_mode_R  = 'replace'
let g:Powerline_mode_v  = 'visual'
let g:Powerline_mode_V  = 'visual-line'
let g:Powerline_mode_cv = 'visual-block'
let g:Powerline_mode_s  = 'select'
let g:Powerline_mode_S  = 'select-line'
let g:Powerline_mode_cs = 'select-block'
" ファイルへの相対パスを表示する
let g:Powerline_stl_path_style = 'relative'

" NERDTree （エクスプローラ）
" NeoBundle 'scrooloose/nerdtree'
" syntastic （シンタックスチェック）
"NeoBundle 'scrooloose/syntastic'
" smartchr （キー入力補完）
"NeoBundle 'kana/vim-smartchr'
" = 入力時に両端に半角空白
"inoremap <expr> = smartchr#loop(' = ', ' == ', ' === ', '=')

" HTML/CSS coding helper
NeoBundle 'mattn/zencoding-vim'
" 言語別に対応させる
let g:user_zen_settings  =  {
      \  'lang' : 'ja',
      \  'indentation' :'  ',
      \  'html' : {
      \    'filters' : 'html',
      \  },
      \  'css' : {
      \    'filters' : 'fc',
      \  },
      \}

" expand to text object.
"NeoBundle 'taichouchou2/surround.vim'

" open a browser
" NeoBundle 'open-browser.vim'
" カーソル下のURLをブラウザで開く
" nmap <Leader>o <Plug>(openbrowser-open)
" vmap <Leader>o <Plug>(openbrowser-open)
" google さんに聞く
" nnoremap <Leader>g :<C-u>OpenBrowserSearch<Space><C-r><C-w><Enter>

" スクリプト内でwebapiを実行できるようにする
"NeoBundle 'mattn/webapi-vim'

" ファイル保存時にブラウザを自動リロード
" NeoBundle 'tell-k/vim-browsereload-mac'
" リロード後に戻ってくるアプリ
" let g:returnApp  =  "mintty"
" nmap <Space>bc :ChromeReloadStart<CR>
" nmap <Space>bC :ChromeReloadStop<CR>
" nmap <Space>bf :FirefoxReloadStart<CR>
" nmap <Space>bF :FirefoxReloadStop<CR>
" nmap <Space>bs :SafariReloadStart<CR>
" nmap <Space>bS :SafariReloadStop<CR>
" nmap <Space>bo :OperaReloadStart<CR>
" nmap <Space>bO :OperaReloadStop<CR>
" nmap <Space>ba :AllBrowserReloadStart<CR>
" nmap <Space>bA :AllBrowserReloadStop<CR>

" CSS3 syntax
"NeoBundle 'hail2u/vim-css3-syntax'
" HTML5 syntax
"NeoBundle 'taichouchou2/html5.vim'
" JavaScript syntax
"NeoBundle 'taichouchou2/vim-javascript' " jQuery syntax追加
" sass コンパイル、compass 関連の操作
" 有効とするためには sass が事前に必要
"NeoBundle 'AtsushiM/sass-compile.vim'
" sass の保存時に自動コンパイル
"let g:sass_compile_auto   =  1
"let g:sass_compile_cdloop =  5
"let g:sass_compile_cssdir =  ['css', 'stylesheet']
"let g:sass_compile_file   =  ['scss', 'sass']
"let g:sass_started_dirs   =  []
" less, sass のインデントを設定
"autocmd FileType less,sass setlocal sw = 2 sts = 2 ts = 2 et
"autocmd BufWritePost *.sass SassCompile

" CoffeeScript syntax
"NeoBundle 'kchmck/vim-coffee-script'
" vimにcoffeeファイルタイプを認識させる
"au BufRead,BufNewFile,BufReadPre *.coffee   set filetype = coffee
" インデントを設定
"autocmd FileType coffee setlocal sw = 2 sts = 2 ts = 2 et
" 保存時に自動コンパイル
"autocmd BufWritePost *.coffee silent CoffeeMake! -cb | cwindow | redraw!

" Quickrun
NeoBundle 'thinca/vim-quickrun'
" PHPUnitに関する設定
" ref: http://www.karakaram.com/quickrun-phpunit
" Filetypeを新しく定義
augroup QuickRunPHPUnit
  autocmd!
  autocmd BufWinEnter,BufNewFile *Test.php set filetype=phpunit
augroup END
" vimprocをrunnerに定義（非同期実行用）
let g:quickrun_config = {}
let g:quickrun_config['_'] = {}
let g:quickrun_config['_']['runner'] = 'vimproc'
let g:quickrun_config['_']['runner/vimproc/updatetime'] = 100
" PHPunit実行後の結果表示
let g:quickrun_config['phpunit'] = {}
let g:quickrun_config['phpunit']['outputter/buffer/split'] = 'vertical 35'
let g:quickrun_config['phpunit']['command'] = 'php'
let g:quickrun_config['phpunit']['cmdopt'] = 'D:/ProgramData/PHP/PEAR/phpunit'
let g:quickrun_config['phpunit']['exec'] = '%c %o `cygpath -m %s`'

"----------------------------------------
" 一時設定
"----------------------------------------
set notitle

"----------------------------------------
" その他設定
"----------------------------------------
