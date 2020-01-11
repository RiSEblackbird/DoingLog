# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  get 'users/index'
  get 'users/show'
  root 'doings#index'
  get 'home' => 'doings#index'

  resources :users, only: %i[index show]
  resources :doings
end
