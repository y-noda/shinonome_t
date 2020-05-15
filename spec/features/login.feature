# encoding: utf-8
# language: ja

機能: ログイン
  登録されたユーザーでログインできる

  シナリオ: 登録された管理者ユーザーでログインする
    もし ログインページを表示する
    かつ 管理者ユーザーが存在する
    かつ 次の値を入力する
      | key | value |
      | name | admin |
      | password | password |
    かつ ログインをクリックする
    ならば 管理TOPページが表示されていること

  シナリオ: 登録された一般ユーザーでログインする
    もし ログインページを表示する
    かつ 一般ユーザーが存在する
    かつ 次の値を入力する
      | key | value |
      | name | general |
      | password | password |
    かつ ログインをクリックする
    ならば アプリTOPページが表示されていること

  シナリオ: 登録されていないユーザーでログインに失敗する
    もし ログインページを表示する
    かつ 次の値を入力する
      | key | value |
      | name | aiueo |
      | password | gouranga |
    かつ ログインをクリックする
    ならば ログインエラーが表示されていること
