# dotfiles

ふくい（ま）が使っている dotfiles です。

# Setting

## dotfiles setting

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

## Vim setting

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

## CRuby setting

```sh
$ cd ${HOME}/dotfiles/settings
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

* MacVim (https://macvim.org/)

* Mac Ports（Homebrew でもいいけど。。）

* Karabiner-Elements（https://karabiner-elements.pqrs.org/）

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

三本指のドラッグは、システム環境設定 - アクセシビリティの「ポインタコントロール」の「トラックパッドオプション」の中にある。

「ドラッグにトラックパッドを使用」をOnにして「ドラッグ方法」に「3本指のドラッグ」を選択。

### ショートカットキーの設定

* 画面ロック（Windows風に）

  システム環境設定 - キーボードの「キーボードショートカット」の「アプリのショートカット」で設定します。

  + ボタンで「アプリケーション」に「すべてのアプリケーション」を選んで「画面をロック」（Sonoma 以降では「ロック画面」）を作成して Cmd + L に割り当て。

* デスクトップの切り替え（Windows風に）

  システム環境設定 - キーボードの「キーボードショートカット」の「Mission Control」で設定します。

  Mission Control を開いて「左の操作スペースに移動」を Ctrl + Cmd + ←に、「右の操作スペースに移動」を Ctrl + Cmd + →に割り当て。

* Spotlight 検索のショートカットキーを変更（誤入力防止のため）

  システム環境設定 - キーボードの「キーボードショートカット」の「Spotlight」で設定します。

  「Spotlight検索を表示」を Ctrl + Cmd + Space に割り当て。

### アイコン画像の設定

システム環境設定 - ユーザーとグループで。

### Dock のサイズをMaxに

システム環境設定 - デスクトップと Dock で。

Dock に表示するアイコンは最低限のものに絞る。

### ２画面時の操作スペースを個別にしない（Dock の表示が別画面に移動するのが嫌なので）

システム環境設定 - デスクトップと Dock で。

一番下にある「ディスプレイ毎に個別の操作スペース」をオフに。

### デスクトップはお好みで

Sonoma からは動的な壁紙が使えるのでそれを使うのがおすすめ。

スクリーンセーバーも連動して動くのであわせて設定しておく。

### Terminal の設定を solarized に

こちら適当なディレクトリに clone して、

https://github.com/tomislav/osx-terminal.app-colors-solarized

メニューバー ＞ ターミナル ＞ 環境設定

タブ ＞ 設定

プロファイル下部 ＞ 歯車ボタン ＞ 読み込む

ダウンロードした設定の Solarized Dark.terminal を選択してプロファイルにロード

そのプロファイルをデフォルトに設定。

### Karaibiner-Elements の設定

#### 共通の設定

* 「Simple Modifications」で caps_lock を left_control に変更

* 「Complex Modifications」で「Add predefined rule」を選択して以下のルールを追加

    「コマンドキーを単体で押したときに、英数・かなキーを送信する。（左コマンドキーは英数、右コマンドキーはかな）(rev 3)」

#### Windows 用キーボードの場合の設定

* 「Simple Modification」で left_alt を left_command に, left_gui を left_option に, right_alt を right_command に変更

### その他入れた方がよさそうなアプリケーション

xterm : resize コマンド（ターミナルのウィンドウサイズの変更を反映してくれる）を使いたいので！
