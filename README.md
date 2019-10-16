# dotfilesのセットアップ
### 必要なパッケージをインストール
```
$ sudo yum -y groupinstall "Development Tools"
$ sudo yum -y install git zsh ncurses-devel lua lua-devel pcre-devel xz-devel
```
### zshのシンボリックリンクを作成
```
$ sudo ln -s /usr/bin/zsh /usr/local/bin/zsh
```
### このリポジトリをクローンしてセットアップ用のシェル実行
```
$ git clone https://github.com/ahiruman5/dotfiles.git
$ ./dotfiles/setup.sh
```
