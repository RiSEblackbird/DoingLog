require 'rails_helper'

RSpec.feature "ProblemEdits", type: :system do
  scenario "ある特定のproblemの編集完了まで" do
    user = FactoryBot.create(:user)
    problem = FactoryBot.create(:problem, title: "日中の室内照度不足",
      summary: "部屋がビルの陰に位置するため、自然光による照度が確保できない。", user: user)

    sign_in_as user

    expect {
      click_link "/problems/#{problem.id}"
      click_link "編集"
      fill_in "問題タイトル", with: "室内照度不足"
      fill_in "概要", with: "部屋がビルの陰に位置するので、自然光による照度が確保できない。"
      click_button "編集を登録する"
      check "解決済み"

      expect(page).to have_content "DoingLogの編集が完了しました。"
      expect(page).to have_content "室内照度不足"
      expect(page).to have_content "部屋がビルの陰に位置するので、自然光による照度が確保できない。"
      expect(page).to have_checked_field('解決済み')
      expect(page).to have_content "User: #{user.username}"
    }.to be_success
  end
end
