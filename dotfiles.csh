#!/bin/csh -f

foreach file ( *.dot )
  if ( -d $file ) then
    cd $file
    foreach subfile ( *.dot )
      if ( -d $subfile ) then
        rm -fr ${HOME}/.$file:r/$subfile:r
        cp -pr $subfile ${HOME}/.$file:r/$subfile:r
      else
        cp -p $subfile ${HOME}/.$file:r/.$subfile:r
      endif
    end
    cd ..
  else
    cp -p $file ${HOME}/.$file:r
  endif
end

# neobundle.vim だけはなければ手で取ってくる。
if ( !(-d "${HOME}/.vim/bundle") ) then
  mkdir -p "${HOME}/.vim/bundle"
endif
if ( !(-d "${HOME}/.vim/bundle/neobundle.vim") ) then
  cd "${HOME}/.vim/bundle"
  git clone git://github.com/Shougo/neobundle.vim neobundle.vim
endif
