require 'rails_helper'

RSpec.feature "DoingLogDeletes", type: :feature do
  scenario "ある特定のDoingLogの削除完了まで" do
    user = FactoryBot.create(:user)
    doing_log = FactoryBot.create(:doing_log, title: "Swaggerの使用方法の学習",
      summary: "API開発でよく使用されるらしいSwagger Editorの使用方法を探る。", user: user)

    sign_in_as user

    expect {
      click_link "/doing_logs/#{doing_log.id}"
      click_link "削除"
      page.accept_alert
      expect(page).to have_content "削除しました。"
    }.to change(user.doing_logs, :count).by(-1)
  end
end