require 'rails_helper'

RSpec.describe User, type: :model do
  it "成功例：username, Email, Password" do
    user = User.new(
      username: Faker::Base.regexify("[aあ]{30}"),
      profile: Faker::Base.regexify("[aあかさたな123gkrogj]{150}"),
      email: Faker::Internet.email,
      password: Faker::Lorem.characters(number: 20),
    )
    expect(user).to be_valid
  end

  it "文字制限(上限)：usernameを31文字で登録する" do
    user = User.new(
      username: Faker::Base.regexify("[bごほ]{31}"),
      profile: Faker::Base.regexify("[aあかさたな123gkrogj]{151}"),
      email: "mail@mail.com",
      password: "s6bdtr7vfb",
    )
    expect(user.errors[:username]).to include("ユーザー名は30文字以内にしてください。")
  end

  it "文字制限(上限)：profileを151文字で登録する" do
    user = User.new(
      username: Faker::Base.regexify("[bごほ]{30}"),
      profile: Faker::Base.regexify("[aあかさたな123gkrogj]{151}"),
      email: "mail@mail.com",
      password: "s6bdtr7vfb",
    )
    expect(user.errors[:username]).to include("プロフィール文は150文字以内にしてください。")
  end

  it "文字制限(上限)：passwordを21文字で登録する" do
    user = User.new(
      username: Faker::Base.regexify("[bごほ]{30}"),
      profile: Faker::Base.regexify("[aあかさgsdfな123gkrogj]{150}"),
      email: "mail@mail.com",
      password: Faker::Lorem.characters(number: 21),
    )
    expect(user.errors[:username]).to include("パスワードは20文字以内にしてください。")
  end

  it "重複不可：既存ユーザーで使用されているemailを登録する" do
    User.create(
      username: "KONO",
      profile: "国王",
      email: "TARO@mail.com",
      password: "5fdsmh7ag",
    )
    user = User.new(
      username: "ASO",
      profile: "国王",
      email: "TARO@mail.com",
      password: "f54fasdas6",
    )
    expect(user.errors[:email]).to include("Eメールアドレスはすでに使用されています。")
  end

  it "必須入力：usernameの未入力" do
    user = User.new(
      username: nil,
      profile: "関白",
      email: "AAA@mail.com",
      password: "gd7a6dfvh",
    )
    user.valid?
    expect(user.errors[:username]).to include("ユーザー名は必須入力項目です。")
  end

  it "必須入力：emailの未入力" do
    user = User.new(
      username: "魚雷",
      profile: "関白",
      email: nil,
      password: "gd7a6dfvh",
    )
    user.valid?
    expect(user.errors[:email]).to include("Eメールは必須入力項目です。")
  end

  it "必須入力：passwordの未入力" do
    user = User.new(
      username: "魚雷",
      profile: "関白",
      email: "AAA@gmail.com",
      password: nil,
    )
    user.valid?
    expect(user.errors[:password]).to include("パスワードを入力してください。")
  end
end
