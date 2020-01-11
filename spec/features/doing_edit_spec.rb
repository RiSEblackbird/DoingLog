require 'rails_helper'

RSpec.feature "DoingLogEdits", type: :feature do
  scenario "ある特定のDoingLogの編集完了まで" do
    user = FactoryBot.create(:user)
    doing_log = FactoryBot.create(:doing_log, title: "Swaggerの使用方法の学習",
      summary: "API開発でよく使用されるらしいSwagger Editorの使用方法を探る。", user: user)

    sign_in_as user

    expect {
      click_link "/doing_logs/#{doing_log.id}"
      click_link "編集"
      fill_in "取り組みタイトル", with: "目玉焼きの改良"
      fill_in "概要", with: "鶏卵の調理行為が課税対象となったため、代替材料の模索と、適合する新たな調理方法を検討する。"
      click_button "編集を登録する"

      expect(page).to have_content "DoingLogの編集が完了しました。"
      expect(page).to have_content "目玉焼きの改良"
      expect(page).to have_content "鶏卵の調理行為が課税対象となったため、代替材料の模索と、適合する新たな調理方法を検討する。"
      expect(page).to have_content "User: #{user.username}"
    }.to be_success
  end
end
