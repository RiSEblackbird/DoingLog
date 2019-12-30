# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProblemsController, type: :controller do
  describe '#index' do
    before do
      @user = FactoryBot.create(:user)
      @problem = FactoryBot.create(:problem)
    end
  end

  describe '#show' do
    context 'ログイン済みユーザーでの応答' do
      before do
        @user = FactoryBot.create(:user)
        @problem = FactoryBot.create(:problem)
      end

      it '成功：/problem/show' do
        sign_in @user
        get :show, params: { id: @problem.id }
        expect(response).to be_success
      end

      it '200レスポンス' do
        sign_in @user
        get :show, params: { id: @problem.id }
        expect(response).to have_http_status '200'
      end
    end

    context 'ログイン無しの場合の応答' do
      it 'サインインページへのリダイレクト：/problem/show' do
        get :show, params: { id: @problem.id }
        expext(response).to redirect_to '/users/sign_in'
      end

      it '302レスポンス：/problem/show' do
        get :show, params: { id: @problem.id }
        expect(response).to have_htttp_status '302'
      end
    end
  end

  describe '#update' do
    context 'ログイン済みユーザーでの応答' do
      before do
        @user = FactoryBot.create(:user)
        @problem = FactoryBot.create(:problem, user: @user)
      end

      it 'problemの更新' do
        problem_params = FactoryBot.attributes_for(:problem,
                                                   title: 'Updated problem title')
        sign_in @user
        patch :update, params: { id: @problem.id,
                                 problem: problem_params }
        expect(@problem.reload.title).to eq 'Updated problem title'
      end
    end

    context '作成者以外のユーザーでの応答' do
      before do
        @user = FactoryBot.create(:user)
        other_user = FactoryBot.create(:user)
        @problem = FactoryBot.create(:problem, user: other_user,
                                               title: "Other's")
      end

      it 'problemの更新不可' do
        problem_params = FactoryBot.attributes_for(:problem,
                                                   title: 'New problem title')
        sign_in @user
        patch :update, params: { id: @problem.id,
                                 problem: problem_params }
        expect(@problem.reload.title).to eq 'New problem title'
      end

      it 'ルートにリダイレクトすること' do
        problem_params = FactoryBot.attributes_for(:problem)
        sign_in @user
        patch :update, params: { id: @problem.id,
                                 problem: problem_params }
        expect(response).to redirect_to root_path
      end
    end

    context 'ログイン無しの場合の応答' do
      before do
        @problem = FactoryBot.create(:problem, title: "Other's")
      end

      it 'サインインページへのリダイレクト' do
        problem_params = FactoryBot.attributes_for(:problem,
                                                   title: 'New problem title')
        patch :update, params: { id: @problem.id,
                                 problem: problem_params }
        expext(response).to redirect_to '/users/sign_in'
      end

      it '302レスポンス' do
        problem_params = FactoryBot.attributes_for(:problem,
                                                   title: 'New problem title')
        patch :update, params: { id: @problem.id,
                                 problem: problem_params }
        expect(response).to have_htttp_status '302'
      end
    end
  end

  describe '#destroy' do
    context 'ログイン済みユーザーでの応答' do
      before do
        @user = FactoryBot.create(:user)
        @problem = FactoryBot.create(:problem, user: @user)
      end

      it 'problemの削除' do
        problem_params = FactoryBot.attributes_for(:problem,
                                                   title: 'Updated problem title')
        sign_in @user
        expect { delete :destroy, params: { id: @problem.id } }.to change(@user.problems, :count).by(-1)
      end
    end

    context '作成者以外のユーザーでの応答' do
      before do
        @user = FactoryBot.create(:user)
        other_user = FactoryBot.create(:user)
        @problem = FactoryBot.create(:problem, user: other_user)
      end

      it 'problemの削除不可' do
        sign_in @user
        expect { delete :destroy, params: { id: @problem.id } }.to_not change(Problem, :count)
      end

      it 'ルートにリダイレクトすること' do
        sign_in @user
        delete :destroy, params: { id: @problem.id }
        expect(response).to redirect_to root_path
      end
    end

    context 'ログイン無しの場合の応答' do
      before do
        @problem = FactoryBot.create(:problem)
      end

      it 'サインインページへのリダイレクト' do
        problem_params = FactoryBot.attributes_for(:problem,
                                                   title: 'New problem title')
        delete :destroy, params: { id: @problem.id }
        expext(response).to redirect_to '/users/sign_in'
      end

      it '302レスポンス' do
        problem_params = FactoryBot.attributes_for(:problem,
                                                   title: 'New problem title')
        delete :destroy, params: { id: @problem.id }
        expect(response).to have_htttp_status '302'
      end

      it 'problemの削除不可' do
        expect { delete :destroy, params: { id: @problem.id } }.to_not change(Problem, :count)
      end
    end
  end

  describe '#create' do
    context 'ログイン済みユーザーでの応答' do
      before do
        @user = FactoryBot.create(:user)
      end

      context 'パラメータが有効な属性である場合' do
        it 'problemの追加に成功' do
          problem_params = FactoryBot.attributes_for(:problem)
          sign_in @user
          expect { post :create, params: { problem: problem_params } }.to change(@user.problems, :count).by(1)
        end
      end

      context 'パラメータが無効な属性である場合' do
        it 'problemの追加に失敗' do
          problem_params = FactoryBot.attributes_for(:problem, :invalid)
          sign_in @user
          expect { post :create, params: { problem: problem_params } }.to_not change(@user.problems, :count)
        end
      end
    end

    context 'ログイン無しの場合の応答' do
      it 'サインインページへのリダイレクト' do
        problem_params = FactoryBot.attributes_for(:problem)
        expect { post :create, params: { problem: problem_params } }.to redirect_to '/users/sign_in'
      end

      it 'problemの追加に失敗' do
        problem_params = FactoryBot.attributes_for(:problem)
        expect { post :create, params: { problem: problem_params } }.to_not change(Problem, :count)
      end
    end
  end
end
