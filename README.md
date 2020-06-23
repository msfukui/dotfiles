# dotfiles

ふくい（ま）が使っている dotfiles です。

# Setting

## dotfiles setting.

```sh
$ cd ${HOME}
$ git clone https://github.com/msfukui/dotfiles.git
...
$ cd dotfiles
$ ./dotfiles.csh
...
$ ./dotfiles_diff.csh
...
```

## Vim setting.

```sh
$ cd ${HOME}
$ vim
...
:NeoBundleInstall
...
:q
$ vim
...
:q
```

## rbenv & ruby setting.

```sh
$ cd ${HOME}/dotfiles
$ ./rbenv_setup.sh
...
$ ./rbenv_ruby_setup.sh
...
```

# Pre and Post setting

## Windows10

### Install applications

* Chrome

  インストール後、デフォルトのWebブラウザに設定する。

* Firefox

* Slack

* TeraPad （スタイル付きテキストのコピペ用）

* Cygwin

  一旦 chere, gcc-core, gcc-g++, git, fortune, keychain, libncurses-devel, make, openssl-devel, openssh, ruby, subversion, tcsh, vim を入れる

* Graphviz （PlantUML の画像生成に必要なため）

* Vagrant

* VirtualBox

* Docker for Windows

* VSCode（SettingSync を入れて設定内容を gist で同期）

* Java （OpenJDK）

  http://jdk.java.net/ から落としてきて雑に C:\Java\ に配置する。システムの環境変数 PATH に C:\java\bin を追加する。

### Font

M+ 1m を取得してインストール。

### アイコン画像の設定

コントロールパネル - アカウントで設定。

### デスクトップを適当な画像に

チラチラするのが嫌なので、デスクトップには落ち着いた画像を設定。

スクリーンセーバーはお好みで。（ロックするから基本は使わない。）

### IME

MS-IMEの表示で右クリックで「プロパティ」を開き、「詳細設定」ボタンを押して、以下の項目を MS-IME から ATOK に変更する。

「編集操作」－「キー設定」

「ローマ字／色の設定」－「色設定」

### タスクバーアイコンの全表示設定を ON に

コントロールパネルの「個人用設定」-「タスクバー」で「タスクバーに表示するアイコンを選択します」をクリック。

「常にすべてのアイコンを通知領域に表示する」をONにします。

### VSCode

SettingsSync を入れて gist の token を設定した後、設定内容一式を同期する。

### Cygwin

keychain にモンキーパッチをあてる。

/usr/bin/keychain の 814 行目に。（keychain 2.7.1 の場合）

```
815             *\ SHA256:[0-9a-zA-Z\+\/=]*)
816                 # The new OpenSSH 6.8+ format, we hope
817                 # 1024 SHA256:aAbBcCdDeEfFgG /home/barney/.ssh/id_dsa (DSA)
818                 echo "$ef_line" | cut -f2 -d' '
819                 ;;
```

## Mac

### Install native Applications

* Chrome（インストール後、システム環境設定 - 一般で、デフォルトのWebブラウザに設定）

* Firefox

* Slack（AppStoreから）

* Microsoft Remote Desktop（AppStoreから）

* Xcode（AppStoreから）

* MacVim（Kaoriya版で）

* Mac Ports（Homebrew でもいいけど。。）

* Vagrant

* VirtualBox

### Xcode のコマンドユーティリティのインストール

```
xcode-select --install
```

### MacPorts 経由のアプリケーションのインストール

```
$ sudo port selfupdate
$ sudo port install coreutil openjdk[xx] fortune ncurses
```

[xx] は openjdk のその時点での最新を。

### トラックパッドの設定

システム環境設定 - トラックパッドで。

全てのタブのチェックを入れる。

三本指のドラッグは、システム環境設定 - アクセシビリティの「マウスとトラックパッド」の「トラックパッドオプション」の中にある。

「ドラッグを有効にする」をOnにして「3本指のドラッグ」を選択。

### ショートカットキーの設定

* 画面ロック（Windows風に）

  システム環境設定 - キーボードのショートカットタブで設定します。

  アプリケーションを選んで + ボタンで「画面をロック」を作成して Cmd + L に割り当て。

  （High Sierra 以降で設定可能です。）

* Option と Ctrl の入れ替え

  システム環境設定 - キーボードのキーボードの右下にある「修飾キー」で設定します。

  Ctrl を Option に。

  Option と Fn を Ctrl に。

* デスクトップの切り替え（Windows風に）

  システム環境設定 - キーボードのショートカットタブで設定します。

  Mission Control を選んで「左の操作スペースに移動」を Ctrl + Cmd + ←に、「右の操作スペースに移動」を Ctrl + Cmd + →に割り当て。

### アイコン画像の設定

システム環境設定 - ユーザーとグループで。

### DockのサイズをMaxに

システム環境設定 - Dockで。

表示は最低限のものに絞る。

### デスクトップを無地に

チラチラするのが嫌なので、デスクトップには無地で落ち着いた色を設定。

スクリーンセーバーはお好みで。（ロックするから基本は使わない。）

### Terminal の設定を solarized に

こちら clone して、

https://github.com/tomislav/osx-terminal.app-colors-solarized

メニューバー ＞ ターミナル ＞ 環境設定

タブ ＞ 設定

プロファイル下部 ＞ 歯車ボタン ＞ 読み込む

ダウンロードした設定の Solarized Dark.terminal を選択してプロファイルにロード

そのプロファイルをデフォルトに設定。

### VirtualBox + Vagrant

* CentOS7 の場合

  https://github.com/msfukui/vagrantfile_centos7

  を ${HOME}/vagrant/[環境名] に clone して環境にあわせて編集した上で、`vagrant up` で起動。

  proxy が必要な環境だと 最初の provision は失敗するが、`vagrant ssh` による接続はきっとできるはず。

  設定f後は `vagrant ssh` で接続後、 `sudo su - root` で `root` になり、 `passwd [アカウント名]` でパスワードを初期化。

  ホスト側の `~/.ssh/config` を作成して、以下の内容で接続を簡易化しておく。

```
Host [ホスト名]
  HostName 127.0.0.1
  Port 10022
  User [アカウント名]
  ForwardAgent yes
```

  これで `ssh [ホスト名]` だけで開発環境に接続できるようになる。

## Linux

### proxy 周りの設定（必要な場合）

/etc/yum.conf を開いて、末尾に以下のエントリを追加。

（provision で設定できるようにすれば不要になるんだけどさぼってる。）

```
proxy=http://[IP]:[port]
proxy_username=[account]
proxy_password=[password]
```

root で visudo で sudoers を開き、適度な場所に以下のエントリを追加。

（proxy の環境変数に英小文字を使っている場合は、英小文字で書かないと引き継いでくれないので注意。）

（初期の provision 時の設定ファイルを直せば不要になるんだけどさぼってる。）

```
Defaults    env_keep += "http_proxy https_proxy"
```

その他 vagrant up --provision を成功させるには、vagrant アカウントの .bashrc あたりに proxy の環境変数の設定を追加する必要もあるけど省略。

### その他入れた方がよさそうなアプリケーション

xterm : resize コマンド（ターミナルのウィンドウサイズの変更を反映してくれる）を使いたいので！
