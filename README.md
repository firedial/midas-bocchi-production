# midas-bocchi-production

家計簿管理システム Midas の本番環境用のリポジトリ

https://github.com/firedial/midas-bocchi

## リストアの方法

### OS の設定

* デバイス: Raspberry Pi 4
* OS: Raspberry Pi OS Lite (64-bit)

### リストア

#### git のインストール

```
$ sudo apt-get install -y git
```

#### リポジトリのクローン

```
$ git clone https://github.com/firedial/midas-bocchi-production.git
$ cd midas-bocchi-production
```

#### 秘匿情報の取得

環境を引数に指定して実行

* 本番環境: prod
* ステージング環境: stag

```
$ bash restore_secret.sh {env}
password: [input password]
```

#### バックアップボタンの初期設定

```
$ sudo sh ./button_setting.sh
```

#### docker のインストール

```
$ sh ./docker_install.sh
```

#### 再起動

```
$ sudo reboot
```

####  イメージのプル、DBのリストア、コンテナの起動

```
$ cd midas-bocchi-production
$ bash restore.sh
restore key: [input restore key]
```

## 秘匿情報の更新

### NAS のマウント

```
$ sudo mkdir -p /mnt/nas
$ sudo systemctl daemon-reload
$ sudo mount -t cifs //192.168.12.13/home /mnt/nas -o username=${USER},password=${PASSWORD},iocharset=utf8,rw
```

### 環境変数の更新

```
$ sudo bash ./crypt_backup_env.sh
```

### 証明書の更新

```
$ sudo bash ./crypt_backup_ssl.sh
```
