# frozen_string_literal: true

class UsersController < ApplicationController
  ALLOWED_ATTRIBUTES = %i[
    email
    name
    password
    password_confirmation
    read_translation
    test_translation
  ].freeze

  before_action :set_user, only: %i[edit destroy show update]
  before_action :verify_authorization, only: %i[edit destroy show update]

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in(@user)
      redirect_to(@user)
    else
      flash.now.alert = @user.pretty_errors
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    # TODO: Use destroy with cleanup of Okubo records.
    # This may require modifying Okubo gem itself.
    if @user.delete
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
    if @user
      render :show
    else
      redirect_to(root_url)
    end
  end

  def update
    if @user.update(user_params)
      redirect_to(@user)
    else
      render :edit
    end
  end

  private

  def verify_authorization
    deny_user_access unless current_user && current_user == @user
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(*ALLOWED_ATTRIBUTES)
  end
end
