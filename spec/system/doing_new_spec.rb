require 'rails_helper'

RSpec.feature "DoingNews", type: :system do
  scenario "Doingの新規投稿" do
    user = FactoryBot.create(:user)

    sign_in_as user

    expect {
      click_link "新規Doing"
      fill_in "Title", with: "目玉焼きの改良"
      fill_in "Summary", with: "鶏卵の調理行為が課税対象となったため、代替材料の模索と、適合する新たな調理方法を検討する。"
      click_button "投稿する"

      expect(page).to have_content "新しいDoingが投稿されました！"
      expect(page).to have_content "目玉焼きの改良"
      expect(page).to have_content "鶏卵の調理行為が課税対象となったため、代替材料の模索と、適合する新たな調理方法を検討する。"
      expect(page).to have_content :user.username
    }.to change(user.doings, :count).by(1)
  end
end
