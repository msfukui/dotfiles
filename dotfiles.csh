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

# bin/ 配下のスクリプトもコピーする。
if ( !(-d "${HOME}/bin") ) then
  mkdir ${HOME}/bin
endif
cp -p bin/* ${HOME}/bin/

# neobundle.vim だけはなければ手で取ってくる。
if ( !(-d "${HOME}/.vim/bundle") ) then
  mkdir -p "${HOME}/.vim/bundle"
endif
if ( !(-d "${HOME}/.vim/bundle/neobundle.vim") ) then
  pushd "${HOME}/.vim/bundle"
  git clone git://github.com/Shougo/neobundle.vim neobundle.vim
  popd
endif

# sl コマンドがなければコンパイルしてコピー。
if ( !(-f "${HOME}/bin/sl") ) then
  if ( !(-d "${HOME}/install") ) then
    mkdir ${HOME}/install
  endif
  rm -fr ${HOME}/install/sl
  cp -pr install/sl ${HOME}/install/sl
  cd ${HOME}/install/sl
  make
  cp -p sl ${HOME}/bin/
endif

# fortune コマンドがあれば追加データをコピー。
if ( -x /usr/bin/fortune ) then
  cp -p fortune/* /usr/share/games/fortunes/
endif
