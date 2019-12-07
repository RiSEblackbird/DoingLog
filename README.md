# DoingLog-Rails-only-
既存リポジトリ[DoingLog - RailsとVueによる取り組み記録用アプリの試作](https://github.com/RiSEblackbird/DoingLog)において、初めて触れる概念で詰まることが相次ぐと思われるので、本リポジトリでおおよそ既知技術でアプリの雛形を制作する。ポートフォリオというよりは個人での実用を意識しているので、動く様子を早く見たい。  
もし本アプリがうまく作れれば、上記リポジトリに着手するかもしれない。(活動スケジュール次第)
初期のGemセッティングは2019/11/27時点のDoingLogを踏襲。

## 追加Gem

```Gemfile
# 機能追加用のGem抜粋
# OAuthの実装は今回スキップする(2019/12/07記)

# タグ付け機能
gem 'acts-as-taggable-on', '~> 6.0'

# アプリエラーの詳細表示
gem 'better_errors'

# Bootstrap
gem 'bootstrap'

# 充実した登録ユーザーの実装
gem 'devise'
gem 'devise-i18n'
gem 'devise-i18n-views'

# 環境変数の管理
gem 'dotenv-rails'

# Deviceで導入したUserモデルにOAuthでGoogleアカウントでログイン
gem 'devise_token_auth'
gem 'omniauth'
gem 'omniauth-google-oauth2'

# OmniAuthの脆弱性対応
gem 'omniauth-rails_csrf_protection'

# Googleアナリティクス(気が向いたら使う)
gem 'google-analytics-rails'

# ページネーション
gem 'kaminari'

# アプリ名変更 - 仕様の変更でDoingLogが妥当なアプリ名じゃなくなったら使う
gem 'rename'
```

## Models

```models detail
// 下記はGem由来以外のもののみ

definitions:  
  DoingLog:
    properties:
      id:
        type: "integer"
      title:
        type: "string"
      tag:
        $ref: "#/definitions/Category"
      summary:
        type: "text"
      problems:
        $ref: "#/definitions/Problem"
      createdAt:
        type: "datetime"
      updatedAt:
        type: "datetime"
  Problem:
    properties:
      id:
        type: "integer"
      title:
        type: "string"
      summary:
        type: "text"
      trying:
        $ref: "#/definition/Try"
      solved:
        type: "boolean"
      createdAt:
        type: "datetime"
      updatedAt:
        type: "datetime"
  Tags:
    properties:
      id:
        type: "integer"
      name:
        type: "string"
      summary:
        type: "text"
      createdAt:
        type: "datetime"
      updatedAt:
        type: "datetime"
  Try:
    properties:
      id:
        type: "integer"
      title:
        type: "string"
      body:
        type: "text"
      effective:
        type: "boolean"
      createdAt:
        type: "datetime"
      updatedAt:
        type: "datetime"
  User:
    properties:
      id:
        type: "integer"
      username:
        type: "string"
      profile:
        type: "text"
      email:
        type: "string"
      password:
        type: "string"
      createdAt:
        type: "datetime"
      updatedAt:
        type: "datetime"
```

## Reference articles

- 全般  
  **[Rails 5 API + Vue.js + devise_token_authでTwitterと連携するSPAを作る（①RAILS編）](https://qiita.com/natsukingdom-yamaguchi/items/15142bd4ad77679afb04)**  
  - アプリ制作の基本的な流れを参考する。  

- Rails  
  **[RailsでいろんなSNSとOAuth連携/ログインする方法](https://qiita.com/awakia/items/03dd68dea5f15dc46c15)**  
  **[[Rails]gem "OmniAuth" の脆弱性対策](https://qiita.com/NT90957869/items/2a3ce18dedf93ccf2bdc)**  
    - githubで脆弱性を警告されることに対する対応。  
    
  **[Devise に omniauth-google-oauth2 でGoogle認証を追加する (Rails 5.2.2)](https://ontheneworbit.blogspot.com/2019/03/devise-omniauth-google-oauth2-google.html)**  
  **[RailsでFacebookとGoogleのOAuth連携。SNS認証の方法](https://qiita.com/nakanishi03/items/2dfe8b8431a044a01bc6)**  
    - この記事で環境変数を管理するGem 'dotenv-rails' を知った。  
    
  **[gemのdeviseをインストールした直後のエラー](https://qiita.com/ryouzi/items/9c5324ba567109ab2a22)**  

  - Devise
  **[[*Rails*] deviseの使い方（rails5版）](https://qiita.com/cigalecigales/items/f4274088f20832252374)**
  **[deviseでUserテーブルの作成が出来ない。 - teratail](https://teratail.com/questions/210291)**
    - $ rails g devise UserでUserテーブルが"作成"ではなく"変更"としてマイグレーションファイルに記載されてしまう事象への対処。

- DB  
  **[mysql2 gemインストール時のトラブルシュート](https://qiita.com/HrsUed/items/ca2e0aee6a2402571cf6)**  
  **[Railsでmysql2がインストールできない](https://qiita.com/Yutazon/items/8d1e538b8c89fc7bda3c)**  
