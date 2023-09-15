"========================================
" plugin.vim
" author: @msfukui
"========================================

"----------------------------------------
" 各種プラグイン設定
"----------------------------------------

filetype off

if has('vim_starting')
  call plug#begin(expand('~/.vim/plugged'))
endif

" color scheme
Plug 'tomasr/molokai'
Plug 'altercation/vim-colors-solarized'
Plug 'nanotech/jellybeans.vim'
Plug 'w0ng/vim-hybrid'

" status line
Plug 'itchyny/lightline.vim'
let g:lightline = {
  \ 'colorscheme': 'jellybeans',
\ }

" project.vim
Plug 'vim-scripts/project.tar.gz'
let g:proj_flags = "imstc"
nmap <silent> <Leader>P <Plug>ToggleProject
augroup plugin_project_loading
  au!
  au BufAdd .vimprojects silent! %foldopen!
augroup END

" smartchr
Plug 'kana/vim-smartchr'
inoremap <expr> = smartchr#loop('=',' = ',' == ',' === ')
inoremap <expr> ! smartchr#loop('!',' != ', ' !== ')
inoremap <expr> + smartchr#loop('+',' + ',' += ','++')
inoremap <expr> - smartchr#loop('-',' - ',' -= ','--')
inoremap <expr> : smartchr#loop(':',' := ','::')

" tcomment(gcc, visual-mode: gc)
Plug 'tomtom/tcomment_vim'

" Markdown
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
let g:vim_markdown_folding_disabled=1

" Vue components syntax highlight.
Plug 'posva/vim-vue'

" coloring indents
Plug 'Yggdroot/indentLine'
let g:indentLine_color_term=239
let g:indentLine_char='|'
let g:indentLine_fileType=['coffee','ruby','haml','css','scss','javascript','typescript','python','php','c','cpp','dart','go']

" showtime.vim
Plug 'thinca/vim-showtime'

" pluntuml syntax highlight & :make
Plug 'aklt/plantuml-syntax'
let g:plantuml_executable_script=expand('~/bin/plantuml')

" CoffeeScript support
" syntax high-light + auto-compile
Plug 'kchmck/vim-coffee-script'

" TypeScript support(Compiler settings, Syntax highlighting)
Plug 'leafgarland/typescript-vim'

" Go support
Plug 'mattn/vim-goimports'
let g:goimports_simplify = 1
Plug 'mattn/vim-gomod'

" Flutter support.
Plug 'dart-lang/dart-vim-plugin'
let g:dart_html_in_string = v:true
let g:dart_style_guide = 2
let g:dart_format_on_save = v:true

" LSP Support & Auto complete setting
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
"Plug 'mattn/vim-lsp-icons'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" EditorConfig support
Plug 'editorconfig/editorconfig-vim'

" Finder
Plug 'ctrlpvim/ctrlp.vim'

" Auto close parentheses
Plug 'cohama/lexima.vim'

" Alternate files mapping
Plug 'tpope/vim-projectionist'

" Github Copilot
Plug 'github/copilot.vim'

" Git support
Plug 'airblade/vim-gitgutter'

" Vim help for Japanese
Plug 'vim-jp/vimdoc-ja'

if has('vim_starting')
  call plug#end()
endif

filetype plugin indent on
