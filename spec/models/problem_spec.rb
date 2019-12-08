require 'rails_helper'

RSpec.describe Problem, type: :model do
  it "成功例：title, summary" do
    problem = Problem.new(
      title: Faker::Base.regexify("[aふぃ5786おさgjgsgあ]{100}"),
      summary: Faker::Base.regexify("[aふぃ5786おさgjgsgあ]{1000}"),
    )
  end

  it "失敗例：titleを101文字で登録する" do
    problem = Problem.new(
      title: Faker::Base.regexify("[aふぃ5786おさgjgsgあ]{101}"),
      summary: Faker::Base.regexify("[aふぃ5786おさgjgsgあ]{1000}"),
    )
    expect(problem.errors[:title]).to include("タイトルは100文字以内にしてください。")
  end

  it "失敗例：summaryを1001文字で登録する" do
    problem = Problem.new(
      title: Faker::Base.regexify("[aふぃ5786おさgjgsgあ]{100}"),
      summary: Faker::Base.regexify("[aふぃ5786おさgjgsgあ]{1001}"),
    )
    expect(problem.errors[:summary]).to include("概要は1000文字以内にしてください。")
  end

  it "失敗例：既存タイトル(title)を登録する" do
    Problem.create(
      title: "○○実装時のエラー. ~~~.",
      summary: "退勤ラッシュの京王井の頭線の外側方面で、停車時に扉が開くと数人が車外に弾き飛ばされてしまう。",
    )
    problem = Problem.new(
      title: "○○実装時のエラー. ~~~.",
      summary: "新しい昼寝のあり方をプロデュースするも全くウケない。",
    )
    expect(problem.errors[:title]).to include("既に使用されているタイトルは登録できません。")
  end

  it "失敗例：必須入力項目(title)の未入力" do
    problem = Problem.new(
      title: nil,
      summary: "退勤ラッシュの京王井の頭線の外側方面で、停車時に扉が開くと数人が車外に弾き飛ばされてしまう。",
    )
    problem.valid?
    expect(problem.errors[:title]).to include("取り組み事項のタイトルは必須入力項目です。")
  end
end
