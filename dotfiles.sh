#!/bin/bash

# argument : all -> mac port selfupdate & upgrade
OPT="$1"

for file in *.dot
do
  if [ -d $file ]; then
    mkdir -p ${HOME}/.${file%.*}
    cd $file
    for subfile in *.dot
    do
      if [ -d $subfile ]; then
        rm -fr ${HOME}/.${file%.*}/${subfile%.*}
        cp -pr $subfile ${HOME}/.${file%.*}/${subfile%.*}
      else
        cp -p $subfile ${HOME}/.${file%.*}/.${subfile%.*}
      fi
    done
    cd ..
  else
    if [ "$file" = "set_proxy.dot" ] || [ "$file" = "gitconfig.dot" ]; then
      if [ "$OPT" = "all" ] || [ ! -f ${HOME}/.${file%.*} ]; then
        cp -p $file ${HOME}/.${file%.*}
      else
        echo "[MSG] $file copy skipped."
      fi
    else
      cp -p $file ${HOME}/.${file%.*}
    fi
  fi
done

# bin/ 配下のスクリプトもコピーする。
if [ ! -d "${HOME}/bin" ]; then
  mkdir ${HOME}/bin
fi
cp -p bin/* ${HOME}/bin/

# lib/ 配下のファイルもコピーする。
if [ ! -d "${HOME}/lib" ]; then
  mkdir ${HOME}/lib
fi
cp -p lib/* ${HOME}/lib/

# neobundle.vim だけはなければ手で取ってくる。
if [ ! -d "${HOME}/.vim/bundle" ]; then
  mkdir -p "${HOME}/.vim/bundle"
fi
if [ ! -f "${HOME}/.vim/bundle/neobundle.vim" ]; then
  pushd "${HOME}/.vim/bundle" > /dev/null
  git clone https://github.com/Shougo/neobundle.vim neobundle.vim
  popd > /dev/null
fi
# vim-plug だけはなければ手で取ってくる。
if [ ! -f "${HOME}/.vim/autoload/plug.vim" ]; then
  curl -fLo ${HOME}/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Mac Ports 経由での各種パッケージのインストール。
if [ -x /opt/local/bin/port ]; then
  if [ "${OPT}" = "all" ]; then
    sudo port selfupdate
    sudo port upgrade outdated
    sudo port install coreutils openssl keychain gawk nkf fortune
    sudo port install ocaml opam
    sudo port install go gosec staticcheck
    sudo port install argocd
  else
    echo "[MSG] Mac Ports install/update skipped."
  fi
fi

# macOS で利用する bash の shell を最新に差し替え
if [ -x /opt/local/bin/port ]; then
  if [ ! -x /opt/local/bin/bash ]; then
    sudo port install bash bash-completion
    sudo sh -c 'echo /opt/local/bin/bash >> /etc/shells'
    chsh -s /opt/local/bin/bash
  fi
fi

# sl コマンドがなければコンパイルしてコピー。
if [ ! -f "${HOME}/bin/sl" ]; then
  mkdir -p ${HOME}/install
  rm -fr ${HOME}/install/sl
  cp -pr install/sl ${HOME}/install/sl
  pushd ${HOME}/install/sl > /dev/null
  make
  cp -p sl ${HOME}/bin/
  popd > /dev/null
fi

# nkf コマンドがなければコンパイルしてインストール。
if [ ! -f "/usr/local/bin/nkf" ]; then
  which nkf > /dev/null
  if [ $? -ne 0 ]; then
    mkdir -p ${HOME}/install
    rm -f ${HOME}/install/nkf-2.1.5.tar.gz
    cp -p install/nkf-2.1.5.tar.gz ${HOME}/install/nkf-2.1.5.tar.gz
    pushd ${HOME}/install > /dev/null
    gzip -dc nkf-2.1.5.tar.gz | tar -xvf -
    cd nkf-2.1.5
    make
    which sudo > /dev/null
    if [ $? -ne 0 ]; then
      make install
    else
      sudo make install
    fi
    cd ..
    rm -fr nkf-2.1.5
    popd > /dev/null
  fi
fi

# fortune コマンドがあれば追加データをコピー。
# for windows & *nix
if [ -x /usr/bin/fortune ] || [ -x /usr/games/fortune ]; then
  which sudo > /dev/null
  if [ $? -eq 0 ]; then
    sudo cp -p fortune/* /usr/share/games/fortunes/
  else
    cp -p fortune/* /usr/share/games/fortunes/
  fi
fi
# for mac(mac ports)
if [ -x /opt/local/bin/fortune ]; then
  sudo cp fortune/* /opt/local/share/games/fortune/
  # mac は dat の形式が違うようなのでセットアップ時に毎回変換して上書きする。
  pushd fortune > /dev/null
  for file in *.dat
  do
    sudo strfile /opt/local/share/games/fortune/${file%.*} > /dev/null
  done
  popd > /dev/null
fi
