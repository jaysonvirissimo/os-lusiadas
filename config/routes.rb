# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'static_pages#root'
  get 'lines/read'
  get 'lines/test'
  post 'words/score'

  resources :users
  resources :sessions, only: %i[create destroy new]
end
