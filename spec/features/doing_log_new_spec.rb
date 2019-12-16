require 'rails_helper'

RSpec.feature "DoingLogNews", type: :feature do
  scenario "DoingLogの新規投稿" do
    user = FactoryBot.create(:user)

    sign_in_as user

    expect {
      click_link "新規DoingLog"
      fill_in "取り組みタイトル", with: "目玉焼きの改良"
      fill_in "概要", with: "鶏卵の調理行為が課税対象となったため、代替材料の模索と、適合する新たな調理方法を検討する。"
      click_button "投稿する"

      expect(page).to have_content "新しいDoingLogが投稿されました！"
      expect(page).to have_content "目玉焼きの改良"
      expect(page).to have_content "鶏卵の調理行為が課税対象となったため、代替材料の模索と、適合する新たな調理方法を検討する。"
      expect(page).to have_content "User: #{user.username}"
    }.to change(user.doing_logs, :count).by(1)
  end
end
