# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TriesController, type: :controller do
  describe '#index' do
    before do
      @user = FactoryBot.create(:user)
      @try = FactoryBot.create(:try)
    end
  end

  describe '#show' do
    context 'ログイン済みユーザーでの応答' do
      before do
        @user = FactoryBot.create(:user)
        @try = FactoryBot.create(:try)
      end

      it '成功：/try/show' do
        sign_in @user
        get :show, params: { id: @try.id }
        expect(response).to be_successful
      end

      it '200レスポンス' do
        sign_in @user
        get :show, params: { id: @try.id }
        expect(response).to have_http_status '200'
      end
    end

    context 'ログイン無しの場合の応答' do
      it 'サインインページへのリダイレクト：/try/show' do
        get :show, params: { id: @try.id }
        expect(response).to redirect_to '/users/sign_in'
      end

      it '302レスポンス：/try/show' do
        get :show, params: { id: @try.id }
        expect(response).to have_htttp_status '302'
      end
    end
  end

  describe '#update' do
    context 'ログイン済みユーザーでの応答' do
      before do
        @user = FactoryBot.create(:user)
        @try = FactoryBot.create(:try, user: @user)
      end

      it 'tryの更新' do
        try_params = FactoryBot.attributes_for(:try,
                                               title: 'Updated try title')
        sign_in @user
        patch :update, params: { id: @try.id,
                                 try: try_params }
        expect(@try.reload.title).to eq 'Updated try title'
      end
    end

    context '作成者以外のユーザーでの応答' do
      before do
        @user = FactoryBot.create(:user)
        other_user = FactoryBot.create(:user)
        @try = FactoryBot.create(:try, user: other_user,
                                       title: "Other's")
      end

      it 'tryの更新不可' do
        try_params = FactoryBot.attributes_for(:try,
                                               title: 'New try title')
        sign_in @user
        patch :update, params: { id: @try.id,
                                 try: try_params }
        expect(@try.reload.title).to eq 'New try title'
      end

      it 'ルートにリダイレクトすること' do
        try_params = FactoryBot.attributes_for(:try)
        sign_in @user
        patch :update, params: { id: @try.id,
                                 try: try_params }
        expect(response).to redirect_to root_path
      end
    end

    context 'ログイン無しの場合の応答' do
      before do
        @try = FactoryBot.create(:try, title: "Other's")
      end

      it 'サインインページへのリダイレクト' do
        try_params = FactoryBot.attributes_for(:try,
                                               title: 'New try title')
        patch :update, params: { id: @try.id,
                                 try: try_params }
        expect(response).to redirect_to '/users/sign_in'
      end

      it '302レスポンス' do
        try_params = FactoryBot.attributes_for(:try,
                                               title: 'New try title')
        patch :update, params: { id: @try.id,
                                 try: try_params }
        expect(response).to have_htttp_status '302'
      end
    end
  end

  describe '#destroy' do
    context 'ログイン済みユーザーでの応答' do
      before do
        @user = FactoryBot.create(:user)
        @try = FactoryBot.create(:try, user: @user)
      end

      it 'tryの削除' do
        try_params = FactoryBot.attributes_for(:try,
                                               title: 'Updated try title')
        sign_in @user
        expect { delete :destroy, params: { id: @try.id } }.to change(@user.tries, :count).by(-1)
      end
    end

    context '作成者以外のユーザーでの応答' do
      before do
        @user = FactoryBot.create(:user)
        other_user = FactoryBot.create(:user)
        @try = FactoryBot.create(:try, user: other_user)
      end

      it 'tryの削除不可' do
        sign_in @user
        expect { delete :destroy, params: { id: @try.id } }.to_not change(Try, :count)
      end

      it 'ルートにリダイレクトすること' do
        sign_in @user
        delete :destroy, params: { id: @try.id }
        expect(response).to redirect_to root_path
      end
    end

    context 'ログイン無しの場合の応答' do
      before do
        @try = FactoryBot.create(:try)
      end

      it 'サインインページへのリダイレクト' do
        try_params = FactoryBot.attributes_for(:try,
                                               title: 'New try title')
        delete :destroy, params: { id: @try.id }
        expect(response).to redirect_to '/users/sign_in'
      end

      it '302レスポンス' do
        try_params = FactoryBot.attributes_for(:try,
                                               title: 'New try title')
        delete :destroy, params: { id: @try.id }
        expect(response).to have_htttp_status '302'
      end

      it 'tryの削除不可' do
        expect { delete :destroy, params: { id: @try.id } }.to_not change(Try, :count)
      end
    end
  end

  describe '#create' do
    context 'ログイン済みユーザーでの応答' do
      before do
        @user = FactoryBot.create(:user)
      end

      context 'パラメータが有効な属性である場合' do
        it 'tryの追加に成功' do
          try_params = FactoryBot.attributes_for(:try)
          sign_in @user
          expect { post :create, params: { try: try_params } }.to change(@user.tries, :count).by(1)
        end
      end

      context 'パラメータが無効な属性である場合' do
        it 'tryの追加に失敗' do
          try_params = FactoryBot.attributes_for(:try, :invalid)
          sign_in @user
          expect { post :create, params: { try: try_params } }.to_not change(@user.tries, :count)
        end
      end
    end

    context 'ログイン無しの場合の応答' do
      it 'サインインページへのリダイレクト' do
        try_params = FactoryBot.attributes_for(:try)
        expect { post :create, params: { try: try_params } }.to redirect_to '/users/sign_in'
      end

      it 'tryの追加に失敗' do
        try_params = FactoryBot.attributes_for(:try)
        expect { post :create, params: { try: try_params } }.to_not change(Try, :count)
      end
    end
  end
end
