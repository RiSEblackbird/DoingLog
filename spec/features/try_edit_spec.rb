require 'rails_helper'

RSpec.feature "TryEdits", type: :feature do
  scenario "ある特定のTryの編集完了まで" do
    user = FactoryBot.create(:user)
    try = FactoryBot.create(:try, title: "Godfab - Projectsによる更新履歴の分類",
      body: "Godfab - ProjectsとIssuesを関連付けてCommitとの紐付けによって更新履歴を詳細項目毎に分類することで振り返りや操作手順の確認などを容易にする。", user: user)

    sign_in_as user

    expect {
      click_link "/tries/#{try.id}"
      click_link "編集"
      fill_in "試したこと", with: "Github - Projectsによる更新履歴の分類"
      fill_in "概要", with: "Github - ProjectsとIssuesを関連付けてCommitとの紐付けによって更新履歴を詳細項目毎に分類することで振り返りや操作手順の確認などを容易にする。"
      click_button "編集を登録する"

      expect(page).to have_content "Doingの編集が完了しました。"
      expect(page).to have_content "Github - Projectsによる更新履歴の分類"
      expect(page).to have_content "Github - ProjectsとIssuesを関連付けてCommitとの紐付けによって更新履歴を詳細項目毎に分類することで振り返りや操作手順の確認などを容易にする。"
      expect(page).to have_content "User: #{user.username}"
    }.to be_success
  end
end
