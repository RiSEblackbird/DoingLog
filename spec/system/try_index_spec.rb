require 'rails_helper'

RSpec.feature "TryIndices", type: :system do
  scenario "tryの一覧ページの表示まで" do
    user = FactoryBot.create(:user)
    another_user = FactoryBot.create(:user)
    try = FactoryBot.create(:try, title: "砂糖の増量",
      body: "甘すぎる現状への対処として更に砂糖を加えて甘味を打ち消す", user: user)
    another_try = FactoryBot.create(:try, title: "課税対象品目の拡大",
      body: "器で液体を摂取することは非常なる贅沢なので、コップの所有に対して月額の徴税を新たに実施する。", user: another_user)
      
      sign_in_as user
      
    expect {
      click_link "/tries"

      expect(page).to have_content "試したことの一覧"
      expect(page).to have_content "砂糖の増量"
      expect(page).to have_content "甘すぎる現状への対処として更に砂糖を加えて甘味を打ち消す"
      expect(page).to have_content "課税対象品目の拡大"
      expect(page).to have_content "器で液体を摂取することは非常なる贅沢なので、コップの所有に対して月額の徴税を新たに実施する。"
    }.to be_success
  end
end
