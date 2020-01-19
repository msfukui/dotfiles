#!/bin/csh -f

# argument : all -> mac port selfupdate & upgrade
set OPT="$1"

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
    if ( ($file == "set_proxy.dot") || ($file == "gitconfig.dot") ) then
      if ( ($OPT == "all") || !(-f ${HOME}/.$file:r) ) then
        cp -p $file ${HOME}/.$file:r
      else
        echo "[MSG] $file copy skipped."
      endif
    else
      cp -p $file ${HOME}/.$file:r
    endif
  endif
end

# bin/ 配下のスクリプトもコピーする。
if ( !(-d "${HOME}/bin") ) then
  mkdir ${HOME}/bin
endif
cp -p bin/* ${HOME}/bin/

# lib/ 配下のファイルもコピーする。
if ( !(-d "${HOME}/lib") ) then
  mkdir ${HOME}/lib
endif
cp -p lib/* ${HOME}/lib/

# neobundle.vim だけはなければ手で取ってくる。
if ( !(-d "${HOME}/.vim/bundle") ) then
  mkdir -p "${HOME}/.vim/bundle"
endif
if ( !(-d "${HOME}/.vim/bundle/neobundle.vim") ) then
  pushd "${HOME}/.vim/bundle"
  git clone https://github.com/Shougo/neobundle.vim neobundle.vim
  popd
endif

# Mac Ports 経由での各種パッケージのインストール。
if ( -x /opt/local/bin/port ) then
  if ( $OPT == "all" ) then
    sudo port selfupdate
    sudo port upgrade outdated
    sudo port install coreutils openssl keychain gawk nkf fortune ocaml opam go
  else
    echo "[MSG] Mac Ports install/update skipped."
  endif
endif

# sl コマンドがなければコンパイルしてコピー。
if ( !(-f "${HOME}/bin/sl") ) then
  mkdir -p ${HOME}/install
  rm -fr ${HOME}/install/sl
  cp -pr install/sl ${HOME}/install/sl
  pushd ${HOME}/install/sl
  make
  cp -p sl ${HOME}/bin/
  popd
endif

# nkf コマンドがなければコンパイルしてインストール。
if ( !(-f "/usr/local/bin/nkf") ) then
  mkdir -p ${HOME}/install
  rm -f ${HOME}/install/nkf-2.1.5.tar.gz
  cp -p install/nkf-2.1.5.tar.gz ${HOME}/install/nkf-2.1.5.tar.gz
  pushd ${HOME}/install
  gzip -dc nkf-2.1.5.tar.gz | tar -xvf -
  cd nkf-2.1.5
  make
  make install
  cd ..
  rm -fr nkf-2.1.5
  popd
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
  pushd fortune
  foreach file ( *.dat )
    sudo strfile /opt/local/share/games/fortune/$file:r > /dev/null
  end
  popd
endif
