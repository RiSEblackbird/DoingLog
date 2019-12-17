require 'rails_helper'

RSpec.feature "DoingLogIndices", type: :feature do
  user = FactoryBot.create(:user)
  another_user = FactoryBot.create(:user)
  doing_log = FactoryBot.create(:doing_log, title: "Swaggerの使用方法の学習",
    summary: "API開発でよく使用されるらしいSwagger Editorの使用方法を探る。", user: user)
  another_doing_log = FactoryBot.create(:doing_log, title: "Postmanの使用方法の学習",
    summary: "API開発でよく使用されるらしいPostmanの使用方法を探る。", user: another_user)

  sign_in_as user

  expect {
    click_link "/doing_logs"

    expect(page).to have_content "取り組み事項一覧"
    expect(page).to have_content "Swaggerの使用方法の学習"
    expect(page).to have_content "API開発でよく使用されるらしいSwagger Editorの使用方法を探る。"
    expect(page).to have_content "Postmanの使用方法の学習"
    expect(page).to have_content "API開発でよく使用されるらしいPostmanの使用方法を探る。"
  }.to be_success
end
