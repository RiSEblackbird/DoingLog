require 'rails_helper'

RSpec.describe Try, type: :model do
  it "成功例：title, body" do
    try = Try.new(
      title: Faker::Base.regexify("[aふぃ5786おさgjgsgあ]{100}"),
      body: Faker::Base.regexify("[aふぃ5786おさgjgsgあ]{1000}"),
    )
  end

  it "文字制限(上限)：titleを101文字で登録する" do
    try = Try.new(
      title: Faker::Base.regexify("[aふぃ5786おさgjgsgあ]{101}"),
      body: Faker::Base.regexify("[aふぃ5786おさgjgsgあ]{1000}"),
    )
    expect(try.errors[:title]).to include("タイトルは100文字以内にしてください。")
  end

  it "文字制限(上限)：bodyを1001文字で登録する" do
    try = Try.new(
      title: Faker::Base.regexify("[aふぃ5786おさgjgsgあ]{100}"),
      body: Faker::Base.regexify("[aふぃ5786おさgjgsgあ]{1001}"),
    )
    expect(try.errors[:body]).to include("概要は1000文字以内にしてください。")
  end

  it "重複不可：既存タイトル(title)を登録する" do
    Try.create(
      title: "gem ○○○の導入",
      body: "退勤ラッシュの京王井の頭線の外側方面で、停車時に扉が開くと車外に弾き飛ばされてしまう人を受けるネットの設置。",
    )
    try = Try.new(
      title: "gem ○○○の導入",
      body: "新しい昼寝のあり方をプロデュースするも全くウケないので聴衆にサクラを仕込む。",
    )
    expect(try.errors[:title]).to include("既に使用されているタイトルは登録できません。")
  end

  it "必須入力：titleの未入力" do
    try = Try.new(
      title: nil,
      body: "退勤ラッシュの京王井の頭線の外側方面で、停車時に扉が開くと数人が車外に弾き飛ばされてしまう。",
    )
    try.valid?
    expect(try.errors[:title]).to include("取り組み事項のタイトルは必須入力項目です。")
  end
end
