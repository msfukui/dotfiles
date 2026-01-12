#!/bin/bash

# argument : all -> mac port selfupdate & upgrade
OPT="$1"

for file in *.dot
do
  if [ -f $file ]; then
    if [ "$file" = "env.dot" ] || [ "$file" = "gitconfig.dot" ]; then
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
mkdir -p ${HOME}/bin
cp -p bin/* ${HOME}/bin/

# lib/ 配下のファイルもコピーする。
mkdir -p ${HOME}/lib
cp -p lib/* ${HOME}/lib/

# vim 関連の設定をまとめてコピーする。
mkdir -p ${HOME}/.vim
cp -pr vim.dot/* ${HOME}/.vim

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
    sudo port install coreutils gsed openssl libyaml gmp keychain gawk nkf fortune fzf git gh
    sudo port install ocaml opam
    sudo port install rust cargo
    sudo port install go gosec staticcheck
    sudo port install kubectl
    sudo port install elixir
    sudo port install cmatrix
    go install golang.org/x/tools/cmd/goimports@latest
    gh extension install https://github.com/nektos/gh-act
  else
    echo "[MSG] Mac Ports install/update skipped."
  fi
fi

# WSL2 なら各パッケージをインストールする
if uname -r | grep -qi microsoft; then
  if [ "${OPT}" = "all" ]; then
    sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y
    sudo apt install -y coreutils openssl libyaml-dev keychain gawk nkf fortune git gh
    sudo apt install -y ocaml opam
    sudo apt install -y golang
    sudo apt install -y apt-transport-https ca-certificates curl gnupg zlib1g-dev
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
    sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list
    sudo apt update -y
    sudo apt install -y kubectl
    sudo apt install -y elixir
    sudo apt install -y cmatrix
    go install github.com/securego/gosec/v2/cmd/gosec@latest
    go install honnef.co/go/tools/cmd/staticcheck@latest
    go install golang.org/x/tools/cmd/goimports@latest
    sudo apt install -y vim
    sudo apt install default-jdk -y
    # fzf は個別にセットアップする。
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --no-key-bindings --no-completion --no-update-rc
    sudo cp -p ~/.fzf/bin/fzf /usr/bin
    sudo chmod 755 /usr/bin/fzf
    sudo chown root:root /usr/bin/fzf
  else
    echo "[MSG] apt install/update skipped."
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
