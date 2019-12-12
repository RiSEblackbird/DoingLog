require 'rails_helper'

RSpec.describe Problem, type: :model do
  it "成功例：title, summary" do
    problem = FactoryBot.build(:problem)
    expect(problem).to be_valid
  end

  it "文字制限(上限)：titleを101文字で登録する" do
    problem = FactoryBot.build(:problem, title: Faker::Base.regexify("[aふぃ5786おさgjgsgあ]{101}"))
    problem.valid?
    expect(problem.errors[:title]).to include("タイトルは100文字以内にしてください。")
  end

  it "文字制限(上限)：summaryを1001文字で登録する" do
    problem = FactoryBot.build(:problem, summary: Faker::Base.regexify("[aふぃ5786おさgjgsgあ]{1001}"))
    problem.valid?
    expect(problem.errors[:summary]).to include("概要は1000文字以内にしてください。")
  end

  it "重複不可：既存タイトル(title)を登録する" do
    FactoryBot.create(:problem, title: "○○実装時のエラー. ~~~.")
    problem = FactoryBot.build(:problem, title: "○○実装時のエラー. ~~~.")
    problem.valid?
    expect(problem.errors[:title]).to include("既に使用されているタイトルは登録できません。")
  end

  it "必須入力：titleの未入力" do
    problem = FactoryBot.build(:problem, title: nil)
    problem.valid?
    expect(problem.errors[:title]).to include("取り組み事項のタイトルは必須入力項目です。")
  end
end
