require 'rails_helper'

RSpec.feature "ProblemDeletes", type: :system do
  scenario "ある特定のProblemの削除完了まで" do
    user = FactoryBot.create(:user)
    problem = FactoryBot.create(:problem, title: "×実装時の○○エラー",
      summary: "API開発でよく使用されるらしいSwagger Editorの使用方法を探る。", user: user)

    sign_in_as user

    expect {
      click_link "/problems/#{problem.id}"
      click_link "削除"
      page.accept_alert
      expect(page).to have_content "削除しました。"
    }.to change(user.problems, :count).by(-1)
  end
end
