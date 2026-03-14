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
