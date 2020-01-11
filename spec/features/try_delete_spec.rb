require 'rails_helper'

RSpec.feature "TryDeletes", type: :feature do
  scenario "ある特定のTryの削除完了まで" do
    user = FactoryBot.create(:user)
    doing = FactoryBot.create(:doing, title: "Swaggerの使用方法の学習",
      summary: "API開発でよく使用されるらしいSwagger Editorの使用方法を探る。", user: user)
    problem = FactoryBot.create(:problem, title: "日中の室内照度不足",
      summary: "部屋がビルの陰に位置するため、自然光による照度が確保できない。", user: user, doing: doing)
    try = FactoryBot.create(:try, title: "時刻指定で起動するライトの設置",
      body: "照度の高い照明による目覚まし時計を枕元に設置し、日中はカーテンレールに下げて窓際から室内に向けることで照度を増強させた。", user: user, doing: doing, problem: problem)

    sign_in_as user

    expect {
      click_link "/tries/#{try.id}"
      click_link "削除"
      page.accept_alert
      expect(page).to have_content "削除しました。"
    }.to change(user.tries, :count).by(-1)
  end
end
