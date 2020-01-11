require 'rails_helper'

RSpec.feature "ProblemNews", type: :feature do
  scenario "Doing詳細にてProblemの新規追加完了まで" do
    user = FactoryBot.create(:user)
    doing_log = FactoryBot.create(:doing_log, title: "住環境の改善活動",
      summary: "劣悪な生活環境を総合的に見直す。", user: user)

    sign_in_as user

    expect {
      click_link "/doing_logs/#{doing_log.id}"

      expect(page).to have_content "住環境の改善活動"
      expect(page).to have_content "劣悪な生活環境を総合的に見直す。"
      expect(page).to have_content "User: #{user.username}"

      click_link "Problemの追加"
      fill_in "問題タイトル", with: "日中の室内照度不足"
      fill_in "概要", with: "部屋がビルの陰に位置するため、自然光による照度が確保できない。"
      click_button "登録する"

      expect(page).to have_content "新しいProblemが投稿されました！"
      expect(page).to have_content "日中の室内照度不足"
      expect(page).to have_content "部屋がビルの陰に位置するため、自然光による照度が確保できない。"
      expect(page).to have_content "User: #{user.username}"
    }.to change(user.problems, :count).by(1)
  end
end
