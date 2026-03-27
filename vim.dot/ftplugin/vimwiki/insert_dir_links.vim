" insert_dir_links.vim - 指定ディレクトリの .md ファイル一覧をリンクリストとしてカーソル位置に挿入する
" Author: @msfukui
"
" 使い方:
"   :VimwikiInsertDirLinks path/to/dir
"
"   カーソル行の下に、指定ディレクトリ内の .md ファイルへの
"   リンクリストを挿入します。
"   パスは wiki root からの相対パスで指定します。
"
"   実行例:
"     :VimwikiInsertDirLinks notes/projects
"
"   挿入結果:
"     - [design-doc](notes/projects/design-doc)
"     - [meeting-notes](notes/projects/meeting-notes)

if exists('b:loaded_vimwiki_insert_dir_links')
  finish
endif
let b:loaded_vimwiki_insert_dir_links = 1

function! s:get_wiki_root() abort
  let l:path = vimwiki#vars#get_wikilocal('path')
  return substitute(l:path, '/$', '', '')
endfunction

function! s:insert_dir_links(dir) abort
  let l:wiki_root = s:get_wiki_root()
  let l:ext = vimwiki#vars#get_wikilocal('ext')

  " ディレクトリパスを解決
  if a:dir[0] ==# '/'
    let l:abs_dir = a:dir
  else
    let l:abs_dir = l:wiki_root . '/' . a:dir
  endif

  " ディレクトリの存在確認
  if !isdirectory(l:abs_dir)
    echohl ErrorMsg
    echomsg 'VimwikiInsertDirLinks: ディレクトリが見つかりません: ' . l:abs_dir
    echohl None
    return
  endif

  " .md ファイル一覧を取得してソート
  let l:files = glob(l:abs_dir . '/*' . l:ext, 0, 1)
  call sort(l:files)

  if empty(l:files)
    echohl WarningMsg
    echomsg 'VimwikiInsertDirLinks: ' . l:ext . ' ファイルが見つかりません: ' . l:abs_dir
    echohl None
    return
  endif

  " リンク行を生成
  let l:links = []
  for l:file in l:files
    let l:basename = fnamemodify(l:file, ':t:r')
    let l:rel = a:dir . '/' . l:basename
    call add(l:links, '- [' . l:basename . '](' . l:rel . ')')
  endfor

  " カーソル行の下に挿入
  call append(line('.'), l:links)

  echomsg 'VimwikiInsertDirLinks: ' . len(l:links) . ' 件のリンクを挿入しました'
endfunction

" ディレクトリパスの補完
function! s:insert_dir_links_complete(arglead, cmdline, cursorpos) abort
  let l:wiki_root = s:get_wiki_root()
  let l:pattern = l:wiki_root . '/' . a:arglead . '*'
  let l:dirs = glob(l:pattern, 0, 1)
  " ディレクトリのみに絞り込み、wiki root からの相対パスに変換
  let l:result = []
  for l:d in l:dirs
    if isdirectory(l:d)
      let l:rel = substitute(l:d, '^' . escape(l:wiki_root . '/', '/.'), '', '')
      call add(l:result, l:rel)
    endif
  endfor
  return l:result
endfunction

" コマンド定義（引数必須、Tab 補完付き）
command! -buffer -nargs=1 -complete=customlist,<SID>insert_dir_links_complete
      \ VimwikiInsertDirLinks call s:insert_dir_links(<f-args>)

" キーバインド（<Leader>wl でコマンドラインに :VimwikiInsertDirLinks を展開）
nnoremap <buffer> <Leader>wl :VimwikiInsertDirLinks
