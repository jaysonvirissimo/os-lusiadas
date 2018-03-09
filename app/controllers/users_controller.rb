# frozen_string_literal: true

class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      sign_in(@user)
      redirect_to(@user)
    else
      render :new
    end
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])

    if authorized?
      render :show
    else
      redirect_to(root_url)
    end
  end

  private

  def authorized?
    current_user == @user
  end

  def user_params
    params
      .require(:user)
      .permit(:email, :name, :password, :password_confirmation)
  end
end
