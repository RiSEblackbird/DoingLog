# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#index' do
    context 'ログイン済みユーザーでの応答' do
      before do
        @user = FactoryBot.create(:user)
      end

      it '成功：/user/index' do
        sign_in @user
        get :index
        expect(response).to be_successful
      end

      it '200レスポンス' do
        sign_in @user
        get :index
        expect(response).to have_http_status '200'
      end
    end

    context 'ログイン無しの場合の応答' do
      it 'サインインページへのリダイレクト：/user/index' do
        get :index
        expext(response).to redirect_to '/users/sign_in'
      end

      it '302レスポンス：/user/index' do
        get :index
        expect(response).to have_htttp_status '302'
      end
    end
  end

  describe '#show' do
    context 'ログイン済みユーザーでの応答' do
      before do
        @user = FactoryBot.create(:user)
      end

      it '成功：/user/show' do
        sign_in @user
        get :show, params: { id: @user.id }
        expect(response).to be_successful
      end

      it '200レスポンス' do
        sign_in @user
        get :show, params: { id: @user.id }
        expect(response).to have_http_status '200'
      end
    end

    context 'ログイン無しの場合の応答' do
      it 'サインインページへのリダイレクト：/user/show' do
        get :show, params: { id: @user.id }
        expext(response).to redirect_to '/users/sign_in'
      end

      it '302レスポンス：/user/show' do
        get :show, params: { id: @user.id }
        expect(response).to have_htttp_status '302'
      end
    end
  end
end
