# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#show'
  get 'lines/read'
  get 'lines/test'
  post 'words/score'

  resources :users
  resources :sessions, only: [:create, :destroy, :new]
end
