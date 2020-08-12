require 'rails_helper'

RSpec.feature "ProblemShows", type: :system do
  scenario "Problemの詳細ページ表示まで" do
    user = FactoryBot.create(:user)
    doing = FactoryBot.create(:doing, title: "Swaggerの使用方法の学習",
      summary: "API開発でよく使用されるらしいSwagger Editorの使用方法を探る。", user: user)
    problem = FactoryBot.create(:problem, title: "日中の室内照度不足",
      summary: "部屋がビルの陰に位置するため、自然光による照度が確保できない。", user: user, doing: doing)

    sign_in_as user

    expect (
      click_link "/problems/#{problem.id}"

      expect(page).to have_content "日中の室内照度不足"
      expect(page).to have_content "部屋がビルの陰に位置するため、自然光による照度が確保できない。"
    ).to be_successful
  end
end
