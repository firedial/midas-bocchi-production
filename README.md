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
sudo apt-get install -y git
```

#### リポジトリのクローン

```
git clone https://github.com/firedial/midas-bocchi-production.git
```

```
cd midas-bocchi-production
```

#### ssh の設定

```
sudo sh ./ssh_setting.sh
```

`ssh allow from: [ssh 接続を許可する IP アドレス]`

#### バックアップボタンの初期設定

```
sudo sh ./button_setting.sh
```

#### docker のインストール

```
sh ./docker_install.sh
```

#### 再起動

```
sudo reboot
```

####  イメージのプル、DBのリストア、コンテナの起動

```
cd midas-bocchi-production
```

```
bash restore.sh
```

`cryptedEnv: [input base64 string]`

`restore key: [input restore key]`

## 秘匿情報の更新

base64 の文字列が出力されるのでそれを保管する。

```
sudo bash ./crypt_backup_env.sh
```

`restore key: [input restore key]`

## SSL ファイルを base64 に変換

```
base64 -w 0 ssl/server.key
```

```
base64 -w 0 ssl/server.crt
```
