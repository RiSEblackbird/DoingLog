module LoginSupport
    def sign_in_as(user)
        visit root_path
        # fill_in "ユーザー名", with: user.username
        fill_in "Eメール", with: user.email
        fill_in "パスワード", with: user.password
        click_button "ログイン"
    end
end

RSpec.configure do |config|
    config.include LoginSupport
end