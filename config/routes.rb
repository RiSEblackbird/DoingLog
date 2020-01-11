# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  get 'users/index'
  get 'users/show'
  root 'doing_logs#index'
  get 'home' => 'doing_logs#index'

  resources :users, only: %i[index show]
  resources :doing_logs
end
