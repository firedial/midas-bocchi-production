# midas-bocchi-production

家計簿管理システム Midas の本番環境用のリポジトリ

https://github.com/firedial/midas-bocchi

## リストアの方法

### リストア

リポジトリのクローン

```
$ git clone https://github.com/firedial/midas-bocchi-production.git
$ cd midas-bocchi-production
```

docker のインストール

```
$ sh ./docker_install.sh
```

イメージのプル、DBのリストア、コンテナの起動

```
$ bash restore.sh
restore key: [input restore key]
```

### バックアップボタンの設定

バックボタンを有効にする。

```
$ nohup python button.py &
```
