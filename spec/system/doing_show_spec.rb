require 'rails_helper'

RSpec.feature "DoingShows", type: :system do
  scenario "Doingの詳細ページ表示まで" do
    user = FactoryBot.create(:user)
    doing = FactoryBot.create(:doing, title: "Swaggerの使用方法の学習",
      summary: "API開発でよく使用されるらしいSwagger Editorの使用方法を探る。", user: user)

    sign_in_as user

    click_link "Swaggerの使用方法の学習"

    expect(page).to have_content "Swaggerの使用方法の学習"
    expect(page).to have_content "API開発でよく使用されるらしいSwagger Editorの使用方法を探る。"
    expect(page).to have_content user.username
  end
end
