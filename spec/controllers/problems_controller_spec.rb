require 'rails_helper'

RSpec.describe ProblemsController, type: :controller do
    describe "#index" do
        before do
            @user = FactoryBot.create(:user)
            @problem = FactoryBot.create(:problem)
        end
    end

    describe "#show" do
        context "ログイン済みユーザーでの応答" do
            before do
                @user = FactoryBot.create(:user)
                @problem = FactoryBot.create(:problem)
            end

            it "成功：/problem/show" do
                sign_in @user
                get :show, params: { id: @problem.id }
                expect(response).to be_success
            end

            it "200レスポンス" do
                sign_in @user
                get :show, params: { id: @problem.id }
                expect(response).to have_http_status "200"
            end
        end

        context "ログイン無しの場合の応答" do
            it "サインインページへのリダイレクト：/problem/show" do
                get :show, params: { id: @problem.id }
                expext(response).to redirect_to "/users/sign_in"
            end

            it "302レスポンス：/problem/show" do
                get :show, params: { id: @problem.id }
                expect(response).to have_htttp_status "302"
            end
        end
    end
end
