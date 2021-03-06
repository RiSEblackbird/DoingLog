require 'rails_helper'

RSpec.feature "ProblemIndices", type: :system do
  scenario "Problemの一覧ページの表示まで" do
    user = FactoryBot.create(:user)
    another_user = FactoryBot.create(:user)
    problem = FactoryBot.create(:problem, title: "Swaggerの使用方法の学習",
      summary: "API開発でよく使用されるらしいSwagger Editorの使用方法を探る。", user: user)
    another_problem = FactoryBot.create(:problem, title: "Postmanの使用方法の学習",
      summary: "API開発でよく使用されるらしいPostmanの使用方法を探る。", user: another_user)
      
    sign_in_as user

    click_link "/problems"

    expect(page).to have_content "取り組み事項一覧"
    expect(page).to have_content "Swaggerの使用方法の学習"
    expect(page).to have_content "API開発でよく使用されるらしいSwagger Editorの使用方法を探る。"
    expect(page).to have_content "Postmanの使用方法の学習"
    expect(page).to have_content "API開発でよく使用されるらしいPostmanの使用方法を探る。"
  end
end
