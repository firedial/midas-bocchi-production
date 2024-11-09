import RPi.GPIO as GPIO
import time
import subprocess

'''
下記コマンドでバックグランドで起動しておく
$ nohup python button.py &
'''

GPIO.setmode(GPIO.BCM)

# ボタンに接続
GPIO.setup(27, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)

# rikka コンテナの名前
DOCKER_CONTEINER_RIKKA_NAME = 'midas-bocchi-production-rikka-1'

def notify(message):
    return subprocess.run(['docker', 'exec', DOCKER_CONTEINER_RIKKA_NAME, '/app/discord/notify.sh', message])


def deploy():
    # ボタン押された時
    notify('[deploy] start')

    # イメージのプル
    cp = subprocess.run(['docker', 'compose', 'pull'])

    if int(cp.returncode) != 0:
        notify('[deploy] pull failed!')

    # コンテナに反映
    cp = subprocess.run(['docker', 'compose', 'up', '-d'])

    if int(cp.returncode) == 0:
        # 成功した時
        notify('[deploy] succeeded')
    else:
        # 失敗した時
        notify('[deploy] docker compose up failed')

def backup():
    # ボタン押された時
    notify('[backup] start')

    # バックアップコマンド実行
    cp = subprocess.run(['docker', 'exec', DOCKER_CONTEINER_RIKKA_NAME, '/app/backup/main.sh'])

    if int(cp.returncode) == 0:
        # 成功した時
        notify('[backup] succeeded')
    else:
        # 失敗した時
        notify('[backup] failed')

def shutdown():
    # ボタン押された時
    notify('[shutdown] start')
    subprocess.run(['sudo', 'shutdown', '-h', 'now'])

isPushed = False
previousPushedTime = time.time()
try:
    while True:
        if isPushed == False and GPIO.input(27) == GPIO.HIGH:
            isPushed = True
            previousPushedTime = time.time()

        if isPushed == True:
            pushingTime = time.time() - previousPushedTime
            # 10秒以上押していたらシャットダウンする
            if pushingTime >= 10:
                # シャットダウンする
                shutdown()
                break

        if isPushed == True and GPIO.input(27) != GPIO.HIGH:
            pushingTime = time.time() - previousPushedTime
            previousPushedTime = time.time()
            isPushed = False

            if pushingTime < 2:
                # 2秒未満であればバックアップ
                backup()
            else:
                # それ以外であればデプロイ
                deploy()

except KeyboardInterrupt:
    pass

GPIO.cleanup()
