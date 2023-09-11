# dotfiles

ふくい（ま）が使っている dotfiles です。

# Setting

## dotfiles setting.

```sh
$ cd ${HOME}
$ git clone https://github.com/msfukui/dotfiles.git
...
$ cd dotfiles
$ ./dotfiles.sh
...
$ ./dotfiles_diff.sh
...
```

## Vim setting.

```sh
$ cd ${HOME}
$ vim
...
:PlugInstall
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

# Setting

## Windows10

以下 Windows 10 Home 2004 の前提で。

### Install applications

* WSL2 (Linux 用 Windows サブシステム, 仮想マシンプラットフォーム)

    * Ubuntu 22.04 LTS (MS Store から)

* Windows Terminal (MS Store から)

* Slack (MS Store から)

* PowerToy (MS Store から)

* Google Chrome

### Font

`Cascadia Code PL` (https://github.com/microsoft/cascadia-code/releases)

### アイコン画像の設定

設定 - アカウント - ユーザーの情報 で設定。

### デスクトップを適当な画像に

チラチラするのが嫌なので、デスクトップには落ち着いた画像を設定。

スクリーンセーバーはお好みで。（ Windows キー + L でロックするから基本は使わない。）

### MS-IME

MS-IMEのアイコンを右クリックで「設定」を開き、キーとタッチのカスタマイズのキーテンプレートを MS-IME から ATOK に変更。

### タスクバーアイコンの全表示設定を ON に

コントロールパネルの「個人用設定」-「タスクバー」で「タスクバーに表示するアイコンを選択します」をクリック。

「常にすべてのアイコンを通知領域に表示する」をONに。

### Ubuntu 22.04 LTS

* 追加コンポーネントのインストール

    dotfiles を入れる前に、

    `sudo apt install gcc fortune ncurses-dev make libssl-dev openssh xterm`

    でインストールしておく。

* `.netrc` の設定

    github.com から personal access token を払い出して設定。

    GitHub には https で clone / push / pull する。

### Boot Camp 周りの設定

Boot Camp 経由の起動の場合は、追加で以下の設定を入れる。

* トラックパッドのドライバのインストール

    標準のドライバだとできることがかなり限られるので、以下から代わりのドライバをインストール。

    https://github.com/imbushuo/mac-precision-touchpad

### 英字キーボード

設定後に PC 再起動が必要、設定変更後は Ctrl + Space で IME を切り替える設定を入れる。

## Mac

### Install native Applications

* Chrome（デフォルトのWebブラウザは Safari のままで）

* Slack（AppStoreから）

* Xcode（AppStoreから）

* MacVim

* Mac Ports（Homebrew でもいいけど。。）

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

### その他入れた方がよさそうなアプリケーション

xterm : resize コマンド（ターミナルのウィンドウサイズの変更を反映してくれる）を使いたいので！
