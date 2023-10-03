# midas-bocchi-production

家計簿管理システム Midas の本番環境用のリポジトリ

https://github.com/firedial/midas-bocchi

## リストアの方法

### git clone

リポジトリをクローンしてくる。

```
$ git clone https://github.com/firedial/midas-bocchi-production.git
$ cd midas-bocchi-production
$ bash restore.sh
restore key: [input restore key]
```

### バックアップボタンの設定

バックボタンを有効にする。

```
$ nohup python button.py &
```
