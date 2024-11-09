# midas-bocchi-production

家計簿管理システム Midas の本番環境用のリポジトリ

https://github.com/firedial/midas-bocchi

## リストアの方法

### リストア

git のインストール

```
$ sudo apt-get install git -y
```

リポジトリのクローン

```
$ git clone https://github.com/firedial/midas-bocchi-production.git
$ cd midas-bocchi-production
```

バックアップボタンの初期設定と docker のインストールと再起動

```
$ sudo sh ./button_setting.sh
$ sudo sh ./docker_install.sh
$ sudo reboot
```

イメージのプル、DBのリストア、コンテナの起動

```
$ bash restore.sh
restore key: [input restore key]
```
