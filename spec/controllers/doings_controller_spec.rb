# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DoingsController, type: :controller do
  describe '#index' do
    before do
      @user = FactoryBot.create(:user)
      @doing_log = FactoryBot.create(:doing_log)
    end
  end

  describe '#show' do
    context 'ログイン済みユーザーでの応答' do
      before do
        @user = FactoryBot.create(:user)
        @doing_log = FactoryBot.create(:doing_log)
      end

      it '成功：/doing_log/show' do
        sign_in @user
        get :show, params: { id: @doing_log.id }
        expect(response).to be_success
      end

      it '200レスポンス' do
        sign_in @user
        get :show, params: { id: @doing_log.id }
        expect(response).to have_http_status '200'
      end
    end

    context 'ログイン無しの場合の応答' do
      it 'サインインページへのリダイレクト：/doing_log/show' do
        get :show, params: { id: @doing_log.id }
        expext(response).to redirect_to '/users/sign_in'
      end

      it '302レスポンス：/doing_log/show' do
        get :show, params: { id: @doing_log.id }
        expect(response).to have_htttp_status '302'
      end
    end
  end

  describe '#new' do
    context 'ログイン済みユーザーでの応答' do
      before do
        @user = FactoryBot.create(:user)
      end

      it '成功：/doing_log/new' do
        sign_in @user
        get :new
        expect(response).to be_success
      end

      it '200レスポンス' do
        sign_in @user
        get :new
        expect(response).to have_http_status '200'
      end
    end

    context 'ログイン無しの場合の応答' do
      it 'サインインページへのリダイレクト：/doing_log/new' do
        get :new
        expext(response).to redirect_to '/users/sign_in'
      end

      it '302レスポンス：/doing_log/show' do
        get :new
        expect(response).to have_htttp_status '302'
      end
    end
  end

  describe '#update' do
    context 'ログイン済みユーザーでの応答' do
      before do
        @user = FactoryBot.create(:user)
        @doing_log = FactoryBot.create(:doing_log, user: @user)
      end

      it 'doing_logの更新' do
        doing_log_params = FactoryBot.attributes_for(:doing_log,
                                                     title: 'Updated doing_log title')
        sign_in @user
        patch :update, params: { id: @doing_log.id,
                                 doing_log: doing_log_params }
        expect(@doing_log.reload.title).to eq 'Updated doing_log title'
      end
    end

    context '作成者以外のユーザーでの応答' do
      before do
        @user = FactoryBot.create(:user)
        other_user = FactoryBot.create(:user)
        @doing_log = FactoryBot.create(:doing_log, user: other_user,
                                                   title: "Other's")
      end

      it 'doing_logの更新不可' do
        doing_log_params = FactoryBot.attributes_for(:doing_log,
                                                     title: 'New doing_log title')
        sign_in @user
        patch :update, params: { id: @doing_log.id,
                                 doing_log: doing_log_params }
        expect(@doing_log.reload.title).to eq 'New doing_log title'
      end

      it 'ルートにリダイレクトすること' do
        doing_log_params = FactoryBot.attributes_for(:doing_log)
        sign_in @user
        patch :update, params: { id: @doing_log.id,
                                 doing_log: doing_log_params }
        expect(response).to redirect_to root_path
      end
    end

    context 'ログイン無しの場合の応答' do
      before do
        @doing_log = FactoryBot.create(:doing_log, title: "Other's")
      end

      it 'サインインページへのリダイレクト' do
        doing_log_params = FactoryBot.attributes_for(:doing_log,
                                                     title: 'New doing_log title')
        patch :update, params: { id: @doing_log.id,
                                 doing_log: doing_log_params }
        expext(response).to redirect_to '/users/sign_in'
      end

      it '302レスポンス' do
        doing_log_params = FactoryBot.attributes_for(:doing_log,
                                                     title: 'New doing_log title')
        patch :update, params: { id: @doing_log.id,
                                 doing_log: doing_log_params }
        expect(response).to have_htttp_status '302'
      end
    end
  end

  describe '#destroy' do
    context 'ログイン済みユーザーでの応答' do
      before do
        @user = FactoryBot.create(:user)
        @doing_log = FactoryBot.create(:doing_log, user: @user)
      end

      it 'doing_logの削除' do
        sign_in @user
        expect { delete :destroy, params: { id: @doing_log.id } }.to change(@user.doing_logs, :count).by(-1)
      end
    end

    context '作成者以外のユーザーでの応答' do
      before do
        @user = FactoryBot.create(:user)
        other_user = FactoryBot.create(:user)
        @doing_log = FactoryBot.create(:doing_log, user: other_user)
      end

      it 'doing_logの削除不可' do
        sign_in @user
        expect { delete :destroy, params: { id: @doing_log.id } }.to_not change(Doing, :count)
      end

      it 'ルートにリダイレクトすること' do
        sign_in @user
        delete :destroy, params: { id: @doing_log.id }
        expect(response).to redirect_to root_path
      end
    end

    context 'ログイン無しの場合の応答' do
      before do
        @doing_log = FactoryBot.create(:doing_log)
      end

      it 'サインインページへのリダイレクト' do
        delete :destroy, params: { id: @doing_log.id }
        expext(response).to redirect_to '/users/sign_in'
      end

      it '302レスポンス' do
        delete :destroy, params: { id: @doing_log.id }
        expect(response).to have_htttp_status '302'
      end

      it 'doing_logの削除不可' do
        expect { delete :destroy, params: { id: @doing_log.id } }.to_not change(Doing, :count)
      end
    end
  end

  describe '#create' do
    context 'ログイン済みユーザーでの応答' do
      before do
        @user = FactoryBot.create(:user)
      end

      context 'パラメータが有効な属性である場合' do
        it 'doing_logの追加に成功' do
          doing_log_params = FactoryBot.attributes_for(:doing_log)
          sign_in @user
          expect { post :create, params: { doing_log: doing_log_params } }.to change(@user.doing_logs, :count).by(1)
        end
      end

      context 'パラメータが無効な属性である場合' do
        it 'doing_logの追加に失敗' do
          doing_log_params = FactoryBot.attributes_for(:doing_log, :invalid)
          sign_in @user
          expect { post :create, params: { doing_log: doing_log_params } }.to_not change(@user.doing_logs, :count)
        end
      end
    end

    context 'ログイン無しの場合の応答' do
      it 'サインインページへのリダイレクト' do
        doing_log_params = FactoryBot.attributes_for(:doing_log)
        expect { post :create, params: { doing_log: doing_log_params } }.to redirect_to '/users/sign_in'
      end

      it 'doing_logの追加に失敗' do
        doing_log_params = FactoryBot.attributes_for(:doing_log)
        expect { post :create, params: { doing_log: doing_log_params } }.to_not change(Doing, :count)
      end
    end
  end
end
