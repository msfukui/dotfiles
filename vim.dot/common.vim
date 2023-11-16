"========================================
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
  inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
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

"----------------------------------------
" 挿入モード
"----------------------------------------
" 補完設定
" 最初の一つ目を選択済みにして挿入はしない
set completeopt=menuone,noinsert
" 補完表示時のEnterで改行をしない
inoremap <expr><CR> pumvisible() ? "<C-y>" : "<CR>"
" 上下で補完を選択する
inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-n>"
inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"

"----------------------------------------
" ビジュアルモード
"----------------------------------------

"----------------------------------------
" コマンドモード
"----------------------------------------
