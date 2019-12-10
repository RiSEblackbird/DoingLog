require 'rails_helper'

RSpec.describe DoingLog, type: :model do
  it "成功例：title, summary" do
    doing_log = DoingLog.new(
      title: Faker::Base.regexify("[aふぃ5786おさgjgsgあ]{100}"),
      summary: Faker::Base.regexify("[aふぃ5786おさgjgsgあ]{1000}"),
    )
  end

  it "文字制限(上限)：titleを101文字で登録する" do
    doing_log = DoingLog.new(
      title: Faker::Base.regexify("[aふぃ5786おさgjgsgあ]{101}"),
      summary: "当アプリでは、私個人のアイデアがアプリの個性として具体化されていること、
      およびテスト駆動開発を意識して開発を進めることを重要視している。",
    )
    expect(doing_log.errors[:title]).to include("タイトルは100文字以内にしてください。")
  end

  it "文字制限(上限)：summaryを1001文字で登録する" do
    doing_log = DoingLog.new(
      title: "オリジナルアプリ'DoingLog'へのRSpecの導入(TDDを意識した開発の準備)",
      summary: Faker::Base.regexify("[aふぃ5786おさgjgsgあ]{1001}"),
    )
    expect(doing_log.errors[:summary]).to include("概要は1000文字以内にしてください。")
  end

  it "重複不可：既存タイトル(title)を登録する" do
    DoingLog.create(
      title: "オリジナルアプリ'DoingLog'へのRSpecの導入(TDDを意識した開発の準備)",
      summary: "当アプリでは、私個人のアイデアがアプリの個性として具体化されていること、
        およびテスト駆動開発を意識して開発を進めることを重要視している。",
    )
    doing_log = DoingLog.new(
      title: "オリジナルアプリ'DoingLog'へのRSpecの導入(TDDを意識した開発の準備)",
      summary: "当アプリでは、新しい昼寝のあり方をプロデュースする。",
    )
    expect(doing_log.errors[:title]).to include("既に使用されているタイトルは登録できません。")
  end

  it "必須入力：titleの未入力" do
    doing_log = DoingLog.new(
      title: nil,
      summary: "当アプリでは、新しい昼寝のあり方をプロデュースする。",
    )
    doing_log.valid?
    expect(doing_log.errors[:title]).to include("取り組み事項のタイトルは必須入力項目です。")
  end
end
