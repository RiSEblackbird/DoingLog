require 'rails_helper'

RSpec.describe TriesController, type: :controller do
    describe "#index" do
        before do
            @user = FactoryBot.create(:user)
            @try = FactoryBot.create(:try)
        end
    end

    describe "#show" do
        context "ログイン済みユーザーでの応答" do
            before do
                @user = FactoryBot.create(:user)
                @try = FactoryBot.create(:try)
            end

            it "成功：/try/show" do
                sign_in @user
                get :show, params: { id: @try.id }
                expect(response).to be_success
            end

            it "200レスポンス" do
                sign_in @user
                get :show, params: { id: @try.id }
                expect(response).to have_http_status "200"
            end
        end

        context "ログイン無しの場合の応答" do
            it "サインインページへのリダイレクト：/try/show" do
                get :show, params: { id: @try.id }
                expext(response).to redirect_to "/users/sign_in"
            end

            it "302レスポンス：/try/show" do
                get :show, params: { id: @try.id }
                expect(response).to have_htttp_status "302"
            end
        end
    end
end
