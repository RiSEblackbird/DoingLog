require 'rails_helper'

RSpec.feature "DoingIndices", type: :system do

  scenario "Doingの一覧ページの表示まで" do
    user = FactoryBot.create(:user)
    another_user = FactoryBot.create(:user)
    doing = FactoryBot.create(:doing, title: "Swaggerの使用方法の学習",
      summary: "API開発でよく使用されるらしいSwagger Editorの使用方法を探る。", user: user)
    another_doing = FactoryBot.create(:doing, title: "Postmanの使用方法の学習",
      summary: "API開発でよく使用されるらしいPostmanの使用方法を探る。", user: another_user)

    sign_in_as user

    expect {
      click_link "/doings"

      expect(page).to have_content "取り組み事項一覧"
      expect(page).to have_content "Swaggerの使用方法の学習"
      expect(page).to have_content "API開発でよく使用されるらしいSwagger Editorの使用方法を探る。"
      expect(page).to have_content "Postmanの使用方法の学習"
      expect(page).to have_content "API開発でよく使用されるらしいPostmanの使用方法を探る。"
    }.to be_successful
  end
end
