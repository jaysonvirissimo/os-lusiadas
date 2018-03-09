# frozen_string_literal: true

class ApplicationController < ActionController::Base
  authem_for :user
  protect_from_forgery with: :exception
end
