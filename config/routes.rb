# frozen_string_literal: true
# TODO: Default to landing page that explains the application.

Rails.application.routes.draw do
  root 'lines#read'
  get 'lines/read'
  get 'lines/test'
  post 'words/score'

  resources :users
  resources :sessions, only: [:create, :destroy, :new]
end
