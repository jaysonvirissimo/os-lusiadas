# frozen_string_literal: true

Rails.application.routes.draw do
  root 'lines#read'
  get 'lines/read'
  get 'lines/test'
  post 'words/score'

  resources :users
  resources :sessions, only: [:create, :destroy, :new]
end
