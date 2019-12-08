# DoingLog
### サービス開発の経緯
　個人で開発や勉強をしていると、行き詰まることはよくある。  
　その際、すぐには質問をせずに自分であれこれ調べて解決を試みるが、自己解決に限界を感じる直前で問題が解消するようなことが多い。  
  
　このような場合、質問文のように綺麗に事象や問題点をまとめないまま、Git上のCommit等の編集履歴はすっきりとしていて、後から見直しても開発中に試行錯誤したり、苦労したようなポイントが具体的な履歴として残らず、記憶の底に埋もれるという事態に至りやすい。  
　私は特に初期段階の学習においては、取り組んだことや調べたことの軌跡を可視化して、学習方法や開発方法の反省に生かしたいと考えた。  
  
　そこで、teratail等の質問サイトで推奨される質問文のテンプレートを参考にしつつ、(途中で躓いたか否かに関わらず)開発中の取り組み事項を都度整理して記録として残すためのサービスを検討した。
 
### 開発方針(2019/12/07記)
　私が企画したサービスの個性を具体化することを最重視する。  
そのため、技術的挑戦には拘らない。(インフラ技術や、その他必ずしも要件実現に直接的に繋がらない追加機能など)

### 要件(2019/12/07記)
- ユーザー(User)
  - ユーザー名（username）,
  - プロフィール（profile）,
  - Eメールアドレス（email）,
  - パスワード(password)
- 取り組み事項(DoingLog)
  - タイトル(title),
  - *タグ(Tags),
  - 概要(summary ; リッチテキスト),
  - 遭遇した問題点（Problem）
    - 問題タイトル(title),
    - 解決済みであるか？(solved ; チェックボックス),
    - *タグ(Tags),
    - 問題の概要(summary ; リッチテキスト),
    - 解決のために試したこと(Trying)
      - 試行のタイトル(title),
      - 問題解決に効果的な試行であるか？（effective ; チェックボックス）,
      - *タグ(Tags),
      - 試行の内容(body)
- *タグ(Tags)
  - タグ名(neme),
  - タグの概要(summary)
- タグ管理用の中間テーブル
  - DoingLogsTags
  - ProblemsTags
  - TriesTags

## 使用技術
- BASE
  - ruby 2.5.3
  - rails 6.0.1
  - SQLite (development)
  - MySQL (production)
  - Heroku
- TEST
  - RSpec
- FRONT
  - Bootstrap4
- DEBUG
  - bybug
  - better_errors
  - rails_panel

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

# Googleアナリティクス(気が向いたら使う)
gem 'google-analytics-rails'

# ページネーション
gem 'kaminari'

```

## Models

```models detail
// 下記はGem由来以外のもののみ
// 書式はSwagger Editorのものを真似て書いただけ。

definitions:  
  DoingLog:
    properties:
      id:
        type: "integer"
      title:
        type: "string"
      tag:
        $ref: "#/definitions/Tags"
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
      tag:
        $ref: "#/definitions/Tags"
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
      tagCategory:
        type: "string"
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
      tag:
        $ref: "#/definitions/Tags"
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
- Rails
  - **[Active Record の関連付け](https://railsguides.jp/association_basics.html#has-many-through%E3%81%A8has-and-belongs-to-many%E3%81%AE%E3%81%A9%E3%81%A1%E3%82%89%E3%82%92%E9%81%B8%E3%81%B6%E3%81%8B)**
  - **[gemのdeviseをインストールした直後のエラー](https://qiita.com/ryouzi/items/9c5324ba567109ab2a22)**  

  - Devise
    - **[[*Rails*] deviseの使い方（rails5版）](https://qiita.com/cigalecigales/items/f4274088f20832252374)**
    - **[deviseでUserテーブルの作成が出来ない。 - teratail](https://teratail.com/questions/210291)**
      - $ rails g devise UserでUserテーブルが"作成"ではなく"変更"としてマイグレーションファイルに記載されてしまう事象への対処。

- RSpec
  - **書籍：[Everyday Rails - RSpecによるRailsテスト入門](https://leanpub.com/everydayrailsrspec-jp)**
  - **[ruby – RSpecマッチャーを複数行に分割](https://codeday.me/jp/qa/20190727/1315872.html)**
    - expect後ろの改行について expect(...).to include

- DB  
  - **[mysql2 gemインストール時のトラブルシュート](https://qiita.com/HrsUed/items/ca2e0aee6a2402571cf6)**  
  - **[Railsでmysql2がインストールできない](https://qiita.com/Yutazon/items/8d1e538b8c89fc7bda3c)**  

## 本リポジトリについて覚書
既存リポジトリ[DoingLog - RailsとVueによる取り組み記録用アプリの試作](https://github.com/RiSEblackbird/DoingLog)において、初めて触れる概念で詰まることが相次ぐと思われるので、本リポジトリでおおよそ既知技術でアプリの雛形を制作する。ポートフォリオというよりは個人での実用を意識しているので、動く様子を早く見たい。  
  
もし本アプリがうまく作れれば、上記リポジトリに着手するかもしれない。(活動スケジュール次第)  
初期のGemセッティングは2019/11/27時点のDoingLogを踏襲。
