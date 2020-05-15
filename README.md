# 最初の開発用DB用意
```
$ createuser shinonome -d -P
Enter password for new role: (shinonome というパスワードで)
Enter it again: (もう一回)

$ bundle exec rake db:migrate:reset
```

# テスト

```
$ bundle exec rspec
```

# テスト用Dockerについて
jenkins向け．もちろんこれを使っても構わない．

```
$ docker-compose build
$ docker-compose up -d
$ docker wait ${APP_CONTAINER_ID} # コンテナがexitするまで待ってくれる
```

あとはステータスコード返ってくる．

# デプロイ

### SSH できるようにする

SSH 鍵は yatagarasu にあります。

```
Host shinonome.production
  HostName <サーバーの IP アドレス>
  IdentityFile ~/.ssh/shinonome_id_rsa
```

### secrets.yml を設定する

- config/secrets.yml に secret_key_base などなどを記述する
- Capistrano でサーバーにアップロードする
    ```
    $ bundle exec cap production deploy:setup
    ```
- :warning: ローカルの config/secrets.yml は編集前に戻しておく（Git にコミットしないように！ :no_good:）

### デプロイ

```
$ bundle exec cap production deploy
```

### その他

- Unicorn の再起動: `$ bundle exec cap production unicorn:restart`
- Asset の precompile: `$ bundle exec cap production deploy:compile_assets`

# Vagrant にデプロイしてみる

```
Host shinonome.vagrant
  HostName 127.0.0.1
  IdentityFile ~/.ssh/shinonome_id_rsa
```

```
$ bundle exec cap vagrant deploy:setup
$ bundle exec cap vagrant deploy
```
