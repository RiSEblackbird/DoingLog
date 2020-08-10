# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it '成功例：username, Email, Password' do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it '文字制限(上限)：usernameを31文字で登録する' do
    user = FactoryBot.build(:user, username: Faker::Base.regexify('[aあア亜ｱ123gkａー-]{31}'))
    user.valid?
    expect(user.errors[:username]).to include('ユーザー名は30文字以内で入力してください')
  end

  it '文字制限(上限)：profileを151文字で登録する' do
    user = FactoryBot.build(:user, profile: Faker::Base.regexify('[aあア亜ｱ123gkａー-]{151}'))
    user.valid?
    expect(user.errors[:username]).to include('プロフィール文は150文字以内で入力してください')
  end

  it '文字制限(上限)：passwordを21文字で登録する' do
    user = FactoryBot.build(:user, password: Faker::Lorem.characters(number: 21))
    user.valid?
    expect(user.errors[:username]).to include('パスワードは20文字以内で入力してください')
  end

  it '重複不可：既存ユーザーで使用されているemailを登録する' do
    FactoryBot.create(:user, email: 'AAA@mail.com')
    user = FactoryBot.build(:user, email: 'AAA@mail.com')
    user.valid?
    expect(user.errors[:email]).to include('Eメールはすでに存在します')
  end

  it '必須入力：usernameの未入力' do
    user = FactoryBot.build(:user, username: nil)
    user.valid?
    expect(user.errors[:username]).to include('ユーザー名を入力してください')
  end

  it '必須入力：emailの未入力' do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include('Eメールを入力してください')
  end

  it '必須入力：passwordの未入力' do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include('パスワードを入力してください')
  end
end
