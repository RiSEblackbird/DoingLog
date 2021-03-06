# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DoingLog, type: :model do
  it '成功例：title, summary' do
    doing = FactoryBot.build(:doing)
    expect(doing).to be_valid
  end

  it '文字制限(上限)：titleを101文字で登録する' do
    doing = FactoryBot.build(:doing, title: Faker::Base.regexify('[/\A[ぁ-んァ-ン一-龥]/]{101}'))
    doing.valid?
    expect(doing.errors[:title]).to include('タイトルは100文字以内にしてください')
  end

  it '文字制限(上限)：summaryを1001文字で登録する' do
    doing = FactoryBot.build(:doing, summary: Faker::Base.regexify('[aふぃ5786おさgjgsgあ]{1001}'))
    doing.valid?
    expect(doing.errors[:summary]).to include('概要は1000文字以内にしてください')
  end

  it '重複不可：既存タイトル(title)を登録する' do
    FactoryBot.create(:doing, title: "オリジナルアプリ'DoingLog'へのRSpecの導入(TDDを意識した開発の準備)")
    doing = FactoryBot.build(:doing, title: "オリジナルアプリ'DoingLog'へのRSpecの導入(TDDを意識した開発の準備)")
    doing.valid?
    expect(doing.errors[:title]).to include('既に使用されているタイトルは登録できません')
  end

  it '必須入力：titleの未入力' do
    doing = FactoryBot.build(:doing, title: nil)
    doing.valid?
    expect(doing.errors[:title]).to include('取り組み事項のタイトルは必須入力項目です')
  end
end
