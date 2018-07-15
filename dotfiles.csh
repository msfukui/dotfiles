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

# Mac Ports 経由での各種パッケージのインストール。
if ( -x /opt/local/bin/port ) then
  sudo port selfupdate
  sudo port upgrade outdated
  sudo port install coreutils openssl keychain gawk nkf fortune ocaml opam go
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
# for windows & *nix
if ( -x /usr/bin/fortune ) then
  cp -p fortune/* /usr/share/games/fortunes/
endif
# for mac(mac ports)
if ( -x /opt/local/bin/fortune ) then
  sudo cp fortune/* /opt/local/share/games/fortune/
  # mac は dat の形式が違うようなのでセットアップ時に毎回変換して上書きする。
  cd fortune
  foreach file ( *.dat )
    sudo strfile /opt/local/share/games/fortune/$file:r
  end
endif
