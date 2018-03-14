# frozen_string_literal: true

class ApplicationController < ActionController::Base
  authem_for :user
  protect_from_forgery with: :exception

  def viewing_user
    current_user || NullUser.new
  end

  helper_method :viewing_user
end
