# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DoingsController, type: :controller do
  describe '#index' do
    before do
      @user = FactoryBot.create(:user)
      @doing = FactoryBot.create(:doing)
    end
  end

  describe '#show' do
    context 'ログイン済みユーザーでの応答' do
      before do
        @user = FactoryBot.create(:user)
        @doing = FactoryBot.create(:doing)
      end

      it '成功：/doing/show' do
        sign_in @user
        get :show, params: { id: @doing.id }
        expect(response).to be_successful
      end

      it '200レスポンス' do
        sign_in @user
        get :show, params: { id: @doing.id }
        expect(response).to have_http_status '200'
      end
    end

    context 'ログイン無しの場合の応答' do
      it 'ログインページへのリダイレクト：/doing/show' do
        get :show, params: { id: @doing.id }
        expect(response).to redirect_to '/users/sign_in'
      end

      it '302レスポンス：/doing/show' do
        get :show, params: { id: @doing.id }
        expect(response).to have_htttp_status '302'
      end
    end
  end

  describe '#new' do
    context 'ログイン済みユーザーでの応答' do
      before do
        @user = FactoryBot.create(:user)
      end

      it '成功：/doing/new' do
        sign_in @user
        get :new
        expect(response).to be_successful
      end

      it '200レスポンス' do
        sign_in @user
        get :new
        expect(response).to have_http_status '200'
      end
    end

    context 'ログイン無しの場合の応答' do
      it 'ログインページへのリダイレクト：/doing/new' do
        get :new
        expect(response).to redirect_to '/users/sign_in'
      end

      it '302レスポンス：/doing/show' do
        get :new
        expect(response).to have_htttp_status '302'
      end
    end
  end

  describe '#update' do
    context 'ログイン済みユーザーでの応答' do
      before do
        @user = FactoryBot.create(:user)
        @doing = FactoryBot.create(:doing, user: @user)
      end

      it 'doingの更新' do
        doing_params = FactoryBot.attributes_for(:doing,
                                                     title: 'Updated doing title')
        sign_in @user
        patch :update, params: { id: @doing.id,
                                 doing: doing_params }
        expect(@doing.reload.title).to eq 'Updated doing title'
      end
    end

    context '作成者以外のユーザーでの応答' do
      before do
        @user = FactoryBot.create(:user)
        other_user = FactoryBot.create(:user)
        @doing = FactoryBot.create(:doing, user: other_user,
                                                   title: "Other's")
      end

      it 'doingの更新不可' do
        doing_params = FactoryBot.attributes_for(:doing,
                                                     title: 'New doing title')
        sign_in @user
        patch :update, params: { id: @doing.id,
                                 doing: doing_params }
        expect(@doing.reload.title).to eq 'New doing title'
      end

      it 'ルートにリダイレクトすること' do
        doing_params = FactoryBot.attributes_for(:doing)
        sign_in @user
        patch :update, params: { id: @doing.id,
                                 doing: doing_params }
        expect(response).to redirect_to root_path
      end
    end

    context 'ログイン無しの場合の応答' do
      before do
        @doing = FactoryBot.create(:doing, title: "Other's")
      end

      it 'ログインページへのリダイレクト' do
        doing_params = FactoryBot.attributes_for(:doing,
                                                     title: 'New doing title')
        patch :update, params: { id: @doing.id,
                                 doing: doing_params }
        expect(response).to redirect_to '/users/sign_in'
      end

      it '302レスポンス' do
        doing_params = FactoryBot.attributes_for(:doing,
                                                     title: 'New doing title')
        patch :update, params: { id: @doing.id,
                                 doing: doing_params }
        expect(response).to have_htttp_status '302'
      end
    end
  end

  describe '#destroy' do
    context 'ログイン済みユーザーでの応答' do
      before do
        @user = FactoryBot.create(:user)
        @doing = FactoryBot.create(:doing, user: @user)
      end

      it 'doingの削除' do
        sign_in @user
        expect { delete :destroy, params: { id: @doing.id } }.to change(@user.doings, :count).by(-1)
      end
    end

    context '作成者以外のユーザーでの応答' do
      before do
        @user = FactoryBot.create(:user)
        other_user = FactoryBot.create(:user)
        @doing = FactoryBot.create(:doing, user: other_user)
      end

      it 'doingの削除不可' do
        sign_in @user
        expect { delete :destroy, params: { id: @doing.id } }.to_not change(Doing, :count)
      end

      it 'ルートにリダイレクトすること' do
        sign_in @user
        delete :destroy, params: { id: @doing.id }
        expect(response).to redirect_to root_path
      end
    end

    context 'ログイン無しの場合の応答' do
      before do
        @doing = FactoryBot.create(:doing)
      end

      it 'ログインページへのリダイレクト' do
        delete :destroy, params: { id: @doing.id }
        expect(response).to redirect_to '/users/sign_in'
      end

      it '302レスポンス' do
        delete :destroy, params: { id: @doing.id }
        expect(response).to have_htttp_status '302'
      end

      it 'doingの削除不可' do
        expect { delete :destroy, params: { id: @doing.id } }.to_not change(Doing, :count)
      end
    end
  end

  describe '#create' do
    context 'ログイン済みユーザーでの応答' do
      before do
        @user = FactoryBot.create(:user)
      end

      context 'パラメータが有効な属性である場合' do
        it 'doingの追加に成功' do
          doing_params = FactoryBot.attributes_for(:doing)
          sign_in @user
          expect { post :create, params: { doing: doing_params } }.to change(@user.doings, :count).by(1)
        end
      end

      context 'パラメータが無効な属性である場合' do
        it 'doingの追加に失敗' do
          doing_params = FactoryBot.attributes_for(:doing, :invalid)
          sign_in @user
          expect { post :create, params: { doing: doing_params } }.to_not change(@user.doings, :count)
        end
      end
    end

    context 'ログイン無しの場合の応答' do
      it 'ログインページへのリダイレクト' do
        doing_params = FactoryBot.attributes_for(:doing)
        expect { post :create, params: { doing: doing_params } }.to redirect_to '/users/sign_in'
      end

      it 'doingの追加に失敗' do
        doing_params = FactoryBot.attributes_for(:doing)
        expect { post :create, params: { doing: doing_params } }.to_not change(Doing, :count)
      end
    end
  end
end
