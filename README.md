# midas-bocchi-production

家計簿管理システム Midas の本番環境用のリポジトリ

https://github.com/firedial/midas-bocchi

## リストアの方法

### git clone

リポジトリをクローンしてくる。

```
$ git clone https://github.com/firedial/midas-bocchi-production.git
```

### SSL の設定

ディレクトリの作成

```
$ mkdir ssl
$ cd ssl
```

秘密鍵の作成

```
$ sudo openssl genrsa -out server.key 2048
```

証明書署名要求の作成

```
$ sudo openssl req -new -key server.key -out server.csr
```

証明書署名要求の設定例

```
Country Name (2 letter code) [AU]:JP
State or Province Name (full name) [Some-State]:Tokyo
Locality Name (eg, city) []:
Organization Name (eg, company) [Internet Widgits Pty Ltd]:
Organizational Unit Name (eg, section) []:
Common Name (e.g. server FQDN or YOUR name) []:midas.home.arpa
Email Address []:

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:
```

サーバ証明書の作成
```
$ sudo openssl x509 -days 3650 -req -signkey server.key -in server.csr -out server.crt
```

### 環境変数の設定

example をコピーして各種値を設定する。

```
$ cp .env.example .env
```

### データリストア

リストア用のシェルスクリプトを実行する。

```
$ sh ./restore
```

### バックアップボタンの設定

バックボタンを有効にする。

```
$ nohup python button.py &
```

