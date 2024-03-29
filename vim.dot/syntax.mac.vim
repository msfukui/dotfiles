﻿"========================================
" syntax.mac.vim
" author: @msfukui
"========================================

"--
" solarized の場合
"--
set background=dark
let g:solarized_termcolors=256

" I use xterm-256color as my terminfo on tmux 1.7 & Terminal.app on OS X Lion, so enable termtrans by manually.
" see https://github.com/altercation/vim-colors-solarized
let g:solarized_termtrans=1

colorscheme solarized
hi Normal     ctermbg=none ctermfg=lightgray
hi Comment    ctermfg=darkgray
hi LineNr     ctermbg=none ctermfg=darkgray
hi SpecialKey ctermbg=none ctermfg=black
hi FoldColumn ctermbg=none ctermfg=darkgreen

" Workaround a problem with solarized and vim-gitgutter.
" https://github.com/airblade/vim-gitgutter/issues/696
highlight! link SignColumn LineNr
autocmd ColorScheme * highlight! link SignColumn LineNr

"--
" molokai の場合
"--
"colorscheme molokai

"--
" jellybeans の場合
"--
"colorscheme jellybeans
