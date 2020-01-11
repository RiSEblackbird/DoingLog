require 'rails_helper'

RSpec.feature "DoingShows", type: :feature do
  scenario "Doingの詳細ページ表示まで" do
    user = FactoryBot.create(:user)
    doing_log = FactoryBot.create(:doing_log, title: "Swaggerの使用方法の学習",
      summary: "API開発でよく使用されるらしいSwagger Editorの使用方法を探る。", user: user)

    sign_in_as user

    expect {
      click_link "/doing_logs/#{doing_log.id}"

      expect(page).to have_content "Swaggerの使用方法の学習"
      expect(page).to have_content "API開発でよく使用されるらしいSwagger Editorの使用方法を探る。"
      expect(page).to have_content "User: #{user.username}"
    }.to be_success
  end
end
