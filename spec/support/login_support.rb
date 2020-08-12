module LoginSupport
    def sign_in_as(user)
        visit root_path
        click_button "ログイン"
        # fill_in "ユーザー名", with: user.username
        fill_in "Eメール", with: user.email
        fill_in "パスワード", with: user.password
    end
end

RSpec.configure do |config|
    config.include LoginSupport
end