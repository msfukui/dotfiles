﻿"========================================
" common.vim
" author: @msfukui
"========================================

"----------------------------------------
" 言語、文字コード、ファイルフォーマットの設定
"----------------------------------------

set termencoding=utf-8
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
set fileformats=unix,dos,mac

"----------------------------------------
" help 言語設定
"----------------------------------------

" 英語は書かなくても検索対称にしてくれる。
" 事前に日本語ヘルプのセットアップが必要。
set helplang=ja

"----------------------------------------
" syntax color の設定
"----------------------------------------

set t_Co=256
syntax on

" 全角空白文字をハイライトする
scriptencoding utf-8
augroup highlightIdegraphicSpace
  au!
  au ColorScheme * highlight IdeographicSpace term=underline ctermbg=DarkMagenta guibg=DarkMagenta
  au VimEnter,WinEnter * match IdeographicSpace /　/
augroup END
highlight IdeographicSpace term=underline ctermbg=DarkMagenta guibg=DarkMagenta

"----------------------------------------
" 画面表示の設定
"----------------------------------------

" スプラッシュ(起動時のメッセージ)を表示しない
set shortmess+=I
" タイトルを非表示
set notitle
" マクロ実行中などの画面再描画を行わない
" set lazyredraw
" エラー時の音とビジュアルベルの抑制
set noerrorbells
set novisualbell
set visualbell t_vb=
" Windowsでディレクトリパスの区切り文字表示に / を使えるようにする
set shellslash
" 行番号表示
set number
" 括弧の対応表示時間
set showmatch matchtime=1
" 画面最後の行をできる限り表示する
set display=lastline
" Tab、行末の半角スペースを明示的に表示する
set list
set listchars=tab:^\ ,trail:~
" 長い行を折り返す
set wrap
" 折りたたみの初期値を100に（折りたたみ無し）
set foldlevel=100
" 折りたたみの種類はシンタックスキーワードで認識させる
set fdm=syntax
" カレント行の強調表示
set cursorline
set cursorlineopt=number

"----------------------------------------
" ステータスラインの設定
"----------------------------------------

" コマンドラインの高さ
" set cmdheight=2
set laststatus=2
" コマンドをステータス行に表示
set showcmd

"----------------------------------------
" インデントの設定
"----------------------------------------

" タブを設定
set ts=2 sw=2 sts=2
" タブの代わりに ts 分のスペースを挿入する
set expandtab
set smarttab
set shiftround
" 自動的にインデントする
set autoindent
set smartindent
" Cインデントの設定
set cinoptions+=:0
" カーソルキーで行末／行頭の移動可能に設定
set whichwrap=b,s,[,],<,>
" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start
" □や○の文字があってもカーソル位置がずれないようにする
set ambiwidth=double

"----------------------------------------
" 編集の設定
"----------------------------------------

" クリップボードを共有
set clipboard+=unnamed
" WSL2の場合は Clip.exe を経由してクリップボードを共有する
if system('uname -r | grep -i microsoft') != ''
  augroup myYank
    au!
    au TextYankPost * :call system('clip.exe', @")
  augroup END
endif

" 8進数を無効にする。<C-a>,<C-x>に影響する
set nrformats-=octal
" キーコードやマッピングされたキー列が完了するのを待つ時間(ミリ秒)
set timeout timeoutlen=3000 ttimeoutlen=100
" 編集結果非保存のバッファから、新しいバッファを開くときに警告を出さない
set hidden
" 日本語の行の連結時には空白を入力しない
set formatoptions+=mM
" Visual blockモードでフリーカーソルを有効にする
"set virtualedit=block
" コマンドライン補完するときに強化されたものを使う
set wildmenu

" バッファ操作のキー割り当て
nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>

"----------------------------------------
" 検索の設定
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
" <ESC>を二回押したら検索をキャンセル
nmap <Esc><Esc> :nohlsearch<CR><Esc>

"----------------------------------------
" バックアップの設定
"----------------------------------------

" ファイルの上書きの前にバックアップを作る/作らない
" set writebackupを指定してもオプション 'backup' がオンでない限り、
" バックアップは上書きに成功した後に削除される。
set nowritebackup
" バックアップ/スワップファイルを作成する/しない
set nobackup

"----------------------------------------
" 履歴の設定
"----------------------------------------

" ヒストリの保存数
set history=50
" ファイルを開いたら前回のカーソル位置へ移動
augroup vimrcEx
  au!
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line('$') | exe "normal! g`\"" | endif
augroup END
" .*.un~ ファイルを作らない様にする。
" >= 7.4.227
set noundofile

"----------------------------------------
" Quickfix の設定
"----------------------------------------

" <C-n>, <C-m> で :cnext, :cprevious, 端に着いたら一番最初, 一番最後に戻る
command CNextToggle     try<bar>cnext<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>cfirst<bar>endtry
command CPreviousToggle try<bar>cprevious<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>clast<bar>endtry
nnoremap <C-n> :<C-u>CNextToggle<CR>
nnoremap <C-m> :<C-u>CPreviousToggle<CR>
" Quickfix を閉じる
nnoremap <leader>a :<C-u>cclose<CR>

"----------------------------------------
" 各言語の文法チェック＆固有の定義
"----------------------------------------

" Ruby
augroup ruby_loading
  au!
  au FileType ruby nmap <leader>b <ESC>:!ruby -cW%<CR>
  au FileType ruby setlocal makeprg=ruby\ -c\ %
  au FileType ruby setlocal errorformat=%m\ in\ %f\ on\ line\ %l
  au FileType ruby setlocal shiftwidth=2
  au FileType ruby setlocal expandtab
augroup END

" PHP
augroup php_loading
  au!
  au FileType php nmap <leader>b <ESC>:!php -l%<CR>
  au FileType php setlocal makeprg=php\ -l\ %
  au FileType php setlocal errorformat=%m\ in\ %f\ on\ line\ %l
  au FileType php setlocal shiftwidth=4
  au FileType php setlocal expandtab
  au BufWritePost *.php silent! call PhpCsFixerFixFile()
  au BufNewFile *.php 0r $HOME/.vim/templates/template.php
augroup END

" CoffeeScript
augroup coffee_loading
  au!
  au BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee
  au FileType coffee setlocal sw=2 sts=2 ts=2 et
  au FileType coffee setlocal shiftwidth=2
  au FileType coffee setlocal expandtab
augroup END

" Groovy
augroup groovy_loading
  au!
  au BufRead,BufNewFile *.gradle set filetype=groovy
augroup END

"----------------------------------------
" LSP/補完の設定
"----------------------------------------
function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> <C-]> <plug>(lsp-definition)
  nmap <buffer> <f2> <plug>(lsp-rename)
  nmap <buffer> <Leader>d <plug>(lsp-type-definition)
  nmap <buffer> <Leader>r <plug>(lsp-references)
  nmap <buffer> <Leader>i <plug>(lsp-implementation)
endfunction

augroup lsp_install
  au!
  au User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/lsp.log')

let g:lsp_use_native_client = 1
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_echo_delay = 50
let g:lsp_diagnostics_signs_enabled = 1
let g:lsp_diagnostics_signs_delay = 50
let g:lsp_diagnostics_signs_insert_mode_enabled = 0
let g:lsp_diagnostics_float_cursor = 0
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_highlights_enabled = 1
let g:lsp_diagnostics_highlights_delay = 50
let g:lsp_diagnostics_highlights_insert_mode_enabled = 0
let g:lsp_document_code_action_signs_enabled = 1
let g:lsp_document_code_action_signs_delay = 50
let g:lsp_inlay_hints_enabled = 0
let g:lsp_semantic_enabled = 1
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 0
let g:asyncomplete_popup_delay = 200
let g:lsp_text_edit_enabled = 1
let g:lsp_preview_float = 1

"----------------------------------------
" その他の設定
"----------------------------------------

" vim-gitgutter の設定
" サインカラム表示の更新タイミングを100msに設定
set updatetime=100

"--
" スニペット(vim-vsnip)の保存先とキーバインド
"--
let g:vsnip_snippet_dir = expand($HOME . '/.vim/vsnip')
" Expand
imap <expr> <C-h>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-h>'
smap <expr> <C-h>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-h>'
" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

"--
" diff/patch
"--

" vimdiffの色設定
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
highlight DiffText   cterm=bold ctermfg=10 ctermbg=21

" 現バッファの差分表示(変更箇所の表示)
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" ファイルまたはバッファ番号を指定して差分表示。#なら裏バッファと比較
command! -nargs=? -complete=file Diff if '<args>'=='' | browse vertical diffsplit|else| vertical diffsplit <args>|endif
" パッチコマンド
set patchexpr=MyPatch()
function! MyPatch()
   call system($VIM."\\'.'patch -o " . v:fname_out . " " . v:fname_in . " < " . v:fname_diff)
endfunction

" netrw のデフォルト設定
" バナーを非表示
let g:netrw_banner=0
" 右に分割して開く
let g:netrw_altv=1
" 開いたウィンドウの幅(%)
let g:netrw_winsize=80
" 隠しファイルを表示/非表示
let g:netrw_list_hide= '\(^\|\s\s\)\zs\.\S\+'

" ファイル末尾に [EOF] を表示する
" 最終行に薄いグレーの [EOF] の文字を足す
" バッファが編集不可の場合はなにもしない

" ハイライトグループの定義（薄いグレー）
" highlight MyEOFColor ctermfg=gray guifg=gray

" バッファローカル変数にマッチIDを保持するためのヘルパー関数
" function! SetEOFHighlight()
"   if exists('b:EOF_matchid')
"     call matchdelete(b:EOF_matchid)
"     unlet b:EOF_matchid
"   endif
"   let lnum = line('$')
"   let eofpat = '\%' . lnum . 'l\[EOF\]'
"   let b:EOF_matchid = matchadd('MyEOFColor', eofpat)
" endfunction

" ファイル末尾に [EOF] を表示する
" autocmd BufReadPost,BufNewFile * call AppendReadOnlyLine()
" autocmd BufWritePost * call AppendReadOnlyLine()

" function! AppendReadOnlyLine()
"   if !&modifiable || &readonly || &buftype != ''
"     return
"   endif
"   if getline('$') !=# '[EOF]'
"     call append(line('$'), '[EOF]')
"   endif
"   call SetEOFHighlight()
" endfunction

" 読み取り専用行の保護
" autocmd TextChangedI,TextChanged * call ProtectReadOnlyLine()

" function! ProtectReadOnlyLine()
"   if !&modifiable || &readonly || &buftype != ''
"     return
"   endif
"   let last_line = line('$')
"   if getline(last_line) !=# '[EOF]'
"     call setline(last_line, '[EOF]')
"     echohl WarningMsg | echo 'この行は編集できません' | echohl None
"   endif
"   call SetEOFHighlight()
" endfunction

" カーソル位置保護
" autocmd CursorMoved * call PreventCursorOnROLine()

" function! PreventCursorOnROLine()
"   if !&modifiable || &readonly || &buftype != ''
"     return
"   endif
"   if line('.') == line('$') && line('.') > 1
"     call cursor(line('.') - 1, col('.'))
"   endif
" endfunction

" 保存前に特別行を削除する
" autocmd BufWritePre * call RemoveReadOnlyLine()

" function! RemoveReadOnlyLine()
"   if !&modifiable || &readonly || &buftype != ''
"     return
"   endif
"   if getline('$') ==# '[EOF]'
"     call deletebufline('%', '$')
"   endif
"   if exists('b:EOF_matchid')
"     call matchdelete(b:EOF_matchid)
"     unlet b:EOF_matchid
"   endif
" endfunction

" 保存後に特別行を再追加する
" autocmd BufWritePost * call AppendReadOnlyLine()

" autocmd BufEnter * call SetEOFHighlight()

"----------------------------------------
" キーマップの設定
"----------------------------------------
"----------------------------------------
" ノーマルモード
"----------------------------------------
" ヘルプ検索
nnoremap <F1> K
" 現在開いているvimスクリプトファイルを実行
nnoremap <F8> :source %<CR>
" 強制全保存終了を無効化
nnoremap ZZ <Nop>
" カーソルを j k では表示行で移動する。
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
" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]>

" Alt key を normal mode で有効にする
nmap <ESC>w <A-w>
nmap <ESC>t <A-t>
nmap <ESC>s <A-s>
nmap <ESC>v <A-v>
nmap <ESC>j <A-j>
nmap <ESC>k <A-k>
nmap <ESC>o <A-o>
nmap <ESC>; <A-;>
nmap <ESC>/ <A-/>

"----------------------------------------
" 挿入モード
"----------------------------------------
" lexima.vim の <CR> の設定が競合しているため無効にする
" cf. https://github.com/cohama/lexima.vim/issues/65
let g:lexima_no_default_rules = 1
call lexima#set_default_rules()
call lexima#insmode#map_hook('before', '<CR>', '')
" 補完設定
" 初期状態は一番上の選択肢を選択して挿入はしない
set completeopt=menuone,noinsert
" 補完表示時のEnterで改行をしない
inoremap <expr><CR> pumvisible() ? "<C-y>" : "<CR>"
" 上下で補完を選択する
inoremap <expr><C-j> pumvisible() ? "<Down>" : "<C-j>"
inoremap <expr><C-k> pumvisible() ? "<Up>" : "<C-k>"

"----------------------------------------
" ビジュアルモード
"----------------------------------------

"----------------------------------------
" コマンドモード
"----------------------------------------

"----------------------------------------
" ターミナルモード
"----------------------------------------
" Alt key を Terminal 内の Vim でも有効にする
tmap <ESC>w <A-w>
tmap <ESC>t <A-t>
tmap <ESC>s <A-s>
tmap <ESC>v <A-v>
tmap <ESC>j <A-j>
tmap <ESC>k <A-k>
tmap <ESC>o <A-o>
tmap <ESC>; <A-;>
tmap <ESC>/ <A-/>

" ターミナルモードのキーマップ変更 (C-w をシェルで有効に)
set termwinkey=<A-w>
" ターミナルジョブモードで垂直分割した右ウインドウを開く
noremap <A-t> :vs<CR><C-w>l:term ++curwin<CR>
" ターミナルジョブモードからノーマルモードに切り替える
tnoremap <A-t> <C-\><C-n><CR>
" 水平分割した上ウィンドウを開く
noremap <A-s> :sp<CR>
" 垂直分割した右ウィンドウを開く
noremap <A-v> :vs<CR>
" ウインドウ間移動
noremap  <A-j> <C-w>w
tnoremap <A-j> <C-\><C-n><C-w>w
" ウィンドウ間を逆に移動
noremap  <A-k> <C-w>W
tnoremap <A-k> <C-\><C-n><C-w>W
" 他のウィンドウを閉じて最大化する
noremap  <A-o> <C-w>o
tnoremap <A-o> <C-\><C-n><C-w>o
" コマンドラインモードに移行
noremap  <A-;> :
tnoremap <A-;> <C-\><C-n><C-w>:
noremap  <A-/> /
tnoremap <A-/> <C-\><C-n>/
" ウインドウ操作時にターミナルノーマルモードの場合は
" 自動でジョブモードに切り替える
autocmd WinEnter * if &buftype ==# 'terminal' | normal i | endif
