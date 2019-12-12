require 'rails_helper'

RSpec.describe DoingLogsController, type: :controller do
    describe "#index" do
        before do
            @user = FactoryBot.create(:user)
            @doing_log = FactoryBot.create(:doing_log)
        end
    end

    describe "#show" do
        context "ログイン済みユーザーでの応答" do
            before do
                @user = FactoryBot.create(:user)
                @doing_log = FactoryBot.create(:doing_log)
            end

            it "成功：/doing_log/show" do
                sign_in @user
                get :show, params: { id: @doing_log.id }
                expect(response).to be_success
            end

            it "200レスポンス" do
                sign_in @user
                get :show, params: { id: @doing_log.id }
                expect(response).to have_http_status "200"
            end
        end

        context "ログイン無しの場合の応答" do
            it "サインインページへのリダイレクト：/doing_log/show" do
                get :show, params: { id: @doing_log.id }
                expext(response).to redirect_to "/users/sign_in"
            end

            it "302レスポンス：/doing_log/show" do
                get :show, params: { id: @doing_log.id }
                expect(response).to have_htttp_status "302"
            end
        end
    end
end
