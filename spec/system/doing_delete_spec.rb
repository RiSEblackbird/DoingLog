require 'rails_helper'

RSpec.feature "DoingDeletes", type: :system do
  scenario "ある特定のDoingの削除完了まで" do
    user = FactoryBot.create(:user)
    doing = FactoryBot.create(:doing, title: "Swaggerの使用方法の学習",
      summary: "API開発でよく使用されるらしいSwagger Editorの使用方法を探る。", user: user)

    sign_in_as user

    expect (
      click_link "Swaggerの使用方法の学習"
      click_link "削除"
      # page.accept_alert
      # expect(page).to have_content "削除しました。"
    ).to change(user.doings, :count).by(-1)
  end
end