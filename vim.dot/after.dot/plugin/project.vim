" カレントディレクトリにプロジェクトファイルがあったら自動的に読み込む。
if exists(":Project")
	if getcwd() != $HOME
		if filereadable(getcwd().'/.vimprojects')
      if !(&diff)
        Project .vimprojects
        if argc() == 0
          autocmd VimEnter * nested hide
        endif
      endif
		endif
	endif
endif
