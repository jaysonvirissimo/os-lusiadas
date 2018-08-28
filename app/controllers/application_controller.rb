# frozen_string_literal: true

class ApplicationController < ActionController::Base
  authem_for :user
  protect_from_forgery with: :exception

  def deny_user_access
    redirect_to new_session_path
  end

  def nav_presenter
    @nav_presenter ||= NavPresenter.new(viewing_user: viewing_user)
  end

  def viewing_user
    current_user || NullUser.new
  end

  helper_method :nav_presenter
  helper_method :viewing_user
end
