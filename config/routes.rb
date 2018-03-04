# frozen_string_literal: true

Rails.application.routes.draw do
  root 'lines#review'
  get 'lines/review'
  get 'lines/test'
  post 'words/score'
end
