" カレントディレクトリにプロジェクトファイルがあったら自動的に読み込む。
if exists(":Project")
	if getcwd() != $HOME
		if filereadable(getcwd().'/.vimprojects')
			Project .vimprojects
		endif
	endif
endif
