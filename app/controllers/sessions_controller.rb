# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    if user&.authenticate(params[:password])
      sign_in(user)
      redirect_back_or_to(root_path)
    else
      flash.now.alert = 'Invalid email/password combination'
      render :new
    end
  end

  def destroy
    sign_out_user
    redirect_to :root
  end

  private

  def user
    @user ||= User.find_by(email: params[:email].strip.downcase)
  end
end
