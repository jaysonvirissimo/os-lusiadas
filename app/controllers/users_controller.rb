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

  def destroy
    @user = User.find(params[:id])

    # TODO: Use destroy with cleanup of Okubo records.
    # This may require modifying Okubo gem itself.
    if authorized? && @user.delete
      sign_out_user
      redirect_to :root
    else
      render :show
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

  def update
    # TODO: Allow users to edit their data.
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
