require 'rails_helper'

RSpec.describe Try, type: :model do
  it "成功例：title, body" do
    try = FactoryBot.build(:problem)
    expect(try).to be_valid
  end

  it "文字制限(上限)：titleを101文字で登録する" do
    try = FactoryBot.build(:try, title: Faker::Base.regexify("[aふぃ5786おさgjgsgあ]{101}"))
    try.valid?
    expect(try.errors[:title]).to include("タイトルは100文字以内にしてください。")
  end

  it "文字制限(上限)：bodyを1001文字で登録する" do
    try = FactoryBot.build(:try, title: Faker::Base.regexify("[aふぃ5786おさgjgsgあ]{1001}"))
    try.valid?
    expect(try.errors[:body]).to include("概要は1000文字以内にしてください。")
  end

  it "重複不可：既存タイトル(title)を登録する" do
    FactoryBot.create(:try, title: "○○の適用.")
    try = FactoryBot.build(:try, title: "○○の適用.")
    try.valid?
    expect(try.errors[:title]).to include("既に使用されているタイトルは登録できません。")
  end

  it "必須入力：titleの未入力" do
    try = FactoryBot.build(:try, title: nil)
    try.valid?
    expect(try.errors[:title]).to include("取り組み事項のタイトルは必須入力項目です。")
  end
end
