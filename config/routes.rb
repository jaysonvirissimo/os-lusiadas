Rails.application.routes.draw do
  root 'lines#review'
  get 'lines/review'
  get 'lines/test'
end
