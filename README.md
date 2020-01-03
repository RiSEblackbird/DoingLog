2019.12～2020.01を目安に制作に注力
# DoingLog
### サービス開発の経緯
　個人で開発や勉強をしていると、行き詰まることはよくある。  
　その際、すぐには質問をせずに自分であれこれ調べて解決を試みるが、自己解決に限界を感じる直前で問題が解消するようなことが多い。  
  
　このような場合、質問文のように綺麗に事象や問題点をまとめないまま、Git上のCommit等の編集履歴はすっきりとしていて、後から見直しても開発中に試行錯誤したり、苦労したようなポイントが具体的な履歴として残らず、記憶の底に埋もれるという事態に至りやすい。  
　私は特に初期段階の学習においては、取り組んだことや調べたことの軌跡を可視化して、学習方法や開発方法の反省に生かしたいと考えた。  
  
　そこで、teratail等の質問サービスで推奨される質問文のテンプレートを参考にしつつ、(途中で躓いたか否かに関わらず)開発中の取り組み事項を都度整理して記録として残すためのサービスを検討した。

### サービスの目的(2019/12/09記)
　質問サービスとは異なり、目的は取り組みそのものや途中の試行錯誤を記録として残すことにある。
また、質問サービスや技術ブログへの投稿の草稿補助アプリとして機能することも期待している。  
問題(problem)と対する試行(Try)をまとめながら、解決しなければそれらを元に質問文に落とし込み、技術ブログを書きたいときは取り組み記録全体(DoingLog)、或いは必要箇所を全体から抜き出して引用する。  
　フォーム自体は汎用性が高いと思うので、開発、料理、ゲームなど想定される用途の領域は制限しない。
 
### 開発方針(2019/12/07記)
　私が企画したサービスの具体化を最重視する。  
そのため、技術的挑戦には拘らない。(インフラ技術や、その他必ずしも要件実現に直接的に繋がらない機能の実装など)  
また、要件は先にRSpecのテストコード（単体・統合）に落とし込んでから実装に移る。

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
- LINTER
  - RuboCop
- FRONT
  - Bootstrap4
- DEBUG
  - bybug
  - better_errors
  - rails_panel

## その他の機能用Gem

```Gemfile
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

# ページネーション
gem 'kaminari'

```

<details><summary>Models</summary>

```json
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
</details>

## Reference articles
- 全般  
  - [Docker × Ruby on Rails × MySQLの環境構築](https://qiita.com/tatsuo-iriyama/items/0bf3b08de03280314c91)
    - 調べたきっかけ：Dockerの準備始めた時にMysqlの準備をしていなかったことに気づいた。
  - [【Rails】GithubとCircleCIを連携してcommit時にrspecとrubocopを動かす](https://qiita.com/junara/items/a40bb231c405be7983f7)
- CircleCI
  - [https://circleci.com/docs/2.0/postgres-config/#example-mysql-project](https://circleci.com/docs/2.0/postgres-config/#example-mysql-project)

- Docker
  - [Compose file version 3 reference](https://docs.docker.com/compose/compose-file/)
  - [SO - You must use Bundler 2 or greater with this lockfile. When running docker-compose up locally](https://stackoverflow.com/questions/55909543/you-must-use-bundler-2-or-greater-with-this-lockfile-when-running-docker-compos)
    - bundlerのバージョン不適合、$ docker-compose up　⇨　"bundle install"失敗。  
      Dockerfileに"RUN gem install bundler -v 2.0.1"を追記して解消。  
  - [Docker上でrails/webpackerなアプリケーションの開発用DockerfileではNODE_ENVを明示的にdevelopmentに指定してyarn installしよう](https://qiita.com/bananaumai/items/34e355a0fd25c3dd0185)
    - $ docker-compose run web rake db:create でyarnのチェックを促されてエラーとなる事象への対処。
      Dockerfileに"RUN NODE_ENV=development yarn install"を追記して
  - [【docker】mysqlのイメージを取得し起動](https://se-tomo.com/2019/09/23/%E3%80%90docker%E3%80%91mysql%E3%81%AE%E3%82%A4%E3%83%A1%E3%83%BC%E3%82%B8%E3%82%92%E5%8F%96%E5%BE%97%E3%81%97%E8%B5%B7%E5%8B%95/)
    - Mysqlイメージの導入から起動までの一連の流れを参照
  - [Use volumes](https://docs.docker.com/storage/volumes/)
    - Dockerでのdb永続化について
    - 関連質問：[Where is a mysql volume db-data:/var/lib/mysql/data stored?](https://stackoverflow.com/questions/58090668/where-is-a-mysql-volume-db-data-var-lib-mysql-data-stored)
  - [Docker で MySQL 8.0.4 を使う](https://qiita.com/yensaki/items/9e453b7320ca2d0461c7)
    - $ docker-compose run web rake db:create
    - Couldn't create 'DoingLog_development' database. Please check your configuration.
      rake aborted!
      Mysql2::Error: Authentication plugin 'caching_sha2_password' cannot be loaded: /usr/lib/x86_64-linux-gnu/mariadb18/plugin/caching_sha2_password.so: cannot open shared object file: No such file or directory

- Rails
  - [Active Record の関連付け](https://railsguides.jp/association_basics.html#has-many-through%E3%81%A8has-and-belongs-to-many%E3%81%AE%E3%81%A9%E3%81%A1%E3%82%89%E3%82%92%E9%81%B8%E3%81%B6%E3%81%8B)
  - [gemのdeviseをインストールした直後のエラー](https://qiita.com/ryouzi/items/9c5324ba567109ab2a22)
  - [Selenium [DEPRECATION] Selenium::WebDriver::Chrome#driver_path= is deprecated が出る件](https://blog.tamesuu.com/2019/06/08/274/)

  - Rails "6"
    - [Rails6 Webpackerでエラーが出た](https://qiita.com/libertyu/items/1eb74adc817ab8971100)
      - 初回および、やり直し1227初期での$ docker-compose up にて.
        - web_1  | /usr/local/bundle/gems/webpacker-4.2.2/lib/webpacker/configuration.rb:95:in `rescue in load': Webpacker configuration file not found /DoingLog/config/webpacker.yml. Please run rails webpacker:install Error: No such file or directory @ rb_sysopen - /DoingLog/config/webpacker.yml (RuntimeError)
        - $ docker-compose run web rails webpacker:install
          - sh: 1: node: not found
            Webpacker requires Node.js >= 8.16.0 and you are using 4.8.2
            Please upgrade Node.js https://nodejs.org/en/download/
        - やり直し1227前のDockerfileからyarn, nodeインストール用の設定を引用して解消
    - 初期構成での$ docker-compose run web rake db:create　成功(1228未明)
      - Starting railsonlyfordoinglog_db_1 ... done
        Created database 'DoingLog_development'
        Created database 'DoingLog_test'

  - Devise
    - [[*Rails*] deviseの使い方（rails5版）](https://qiita.com/cigalecigales/items/f4274088f20832252374)
    - [deviseでUserテーブルの作成が出来ない。 - teratail](https://teratail.com/questions/210291)
      - $ rails g devise UserでUserテーブルが"作成"ではなく"変更"としてマイグレーションファイルに記載されてしまう事象への対処。

  - ActsAsTaggableOn
    - [Railsでacts-as-taggable-onを使ってタグ管理を行う](https://ruby-rails.hatenadiary.com/entry/20150225/1424858414)
      - 扱い方をまとめてくれている。
    - [For MySql users](https://github.com/mbleigh/acts-as-taggable-on#for-mysql-users)
      - Mysqlユーザー用の必要操作
      - $ docker-compose run web rake acts_as_taggable_on_engine:tag_names:collate_bin
        Starting railsonlyfordoinglog_db_1 ... done
        -- execute("ALTER TABLE tags MODIFY name varchar(255) CHARACTER SET utf8 COLLATE utf8_bin;")
        -> 0.0735s

  - RSpec
    - 書籍：[Everyday Rails - RSpecによるRailsテスト入門](https://leanpub.com/everydayrailsrspec-jp)
    - [ruby – RSpecマッチャーを複数行に分割](https://codeday.me/jp/qa/20190727/1315872.html)
      - expect後ろの改行について expect(...).to include
    - [stackoverflow - サンプルデータにセットするための、一定の長さのランダムな文字列を生成するための簡単な方法](https://ja.stackoverflow.com/questions/4687/%E3%82%B5%E3%83%B3%E3%83%97%E3%83%AB%E3%83%87%E3%83%BC%E3%82%BF%E3%81%AB%E3%82%BB%E3%83%83%E3%83%88%E3%81%99%E3%82%8B%E3%81%9F%E3%82%81%E3%81%AE-%E4%B8%80%E5%AE%9A%E3%81%AE%E9%95%B7%E3%81%95%E3%81%AE%E3%83%A9%E3%83%B3%E3%83%80%E3%83%A0%E3%81%AA%E6%96%87%E5%AD%97%E5%88%97%E3%82%92%E7%94%9F%E6%88%90%E3%81%99%E3%82%8B%E3%81%9F%E3%82%81%E3%81%AE%E7%B0%A1%E5%8D%98%E3%81%AA%E6%96%B9%E6%B3%95)
      - 文字数のバリデーションをテストしたく、手っ取り早く任意の文字数の文字列を生成したかった。今回はgem fakerを採用する。
    - [FactoryBot(旧FactoryGirl) のバージョンを上げたらundefined methodになった問題](https://permanent-til-me.ssl-netowl.jp/archives/2516)
      - factoryの<model_name>.rb で記載するカラムの内容は{}で囲む必要がある。
        始めはそれがなく、$ docker-compose run web rake db:createでNoMethodErrorが生じた。
    - Capybara
      - [RSpecでブラウザのダイアログを操作する方法](http://kazukiyunoue-tech.hatenablog.com/entry/2018/06/13/134506)
        - 投稿物などの削除の際に表示されるダイアログの操作をテストする方法
      - 公式：[Method: Capybara::Session#accept_alert](https://www.rubydoc.info/github/jnicklas/capybara/master/Capybara%2FSession:accept_alert)

- DB  
  - [mysql2 gemインストール時のトラブルシュート](https://qiita.com/HrsUed/items/ca2e0aee6a2402571cf6)
  - [Railsでmysql2がインストールできない](https://qiita.com/Yutazon/items/8d1e538b8c89fc7bda3c)
  - [Cannot load `Rails.application.database_configuration`: (NoMethodError) with launching to Heroku](https://stackoverflow.com/questions/41905756/cannot-load-rails-application-database-configuration-nomethoderror-with-lau/41913290)
    - config/database.yml内の参照の仕組み。
    - 調べたきっかけ：$ docker-compose run web bundle exec rails g rspec:feature problem_edit 失敗時の
      (erb):31:in `<main>': Cannot load database configuration:  
      undefined method `[]' for nil:NilClass (NoMethodError)
  - [MySQLでBLOB/TEXT型のカラムにはデフォルト値を設定できない](https://easyramble.com/blob-text-column-default-value-error.html)
    - 記事タイトルまんま。下記エラー発生時の対処参考(※ 記事での環境はPHP - CakePHP)
    - Mysql2::Error: BLOB, TEXT, GEOMETRY or JSON column 'profile' can't have a default value
    - Docker構成前まではDBがSqlite指定だったので特にエラーにならなかった。
    - $ docker-compose run web rake db:migrate
      Starting railsonlyfordoinglog_db_1 ... done
      == 20191127054530 DeviseCreateUsers: migrating ================================
      -- create_table(:users)
      rake aborted!
      StandardError: An error has occurred, all later migrations canceled:

## 本リポジトリについて覚書
 ~~既存リポジトリ[DoingLog - RailsとVueによる取り組み記録用アプリの試作](https://github.com/RiSEblackbird/DoingLog)において、初めて触れる概念で詰まることが相次ぐと思われるので、本リポジトリでおおよそ既知技術でアプリの雛形を制作する。~~  
~~ポートフォリオというよりは個人での実用を意識しているので、動く様子を早く見たい。~~ 

余裕があれば部分的なVueの適用を行う。  
 ~~もし本アプリがうまく作れれば、上記リポジトリに着手するかもしれない。(活動スケジュール次第)~~  
初期のGemセッティングは2019/11/27時点のDoingLogを ~~踏襲~~ 参考。
