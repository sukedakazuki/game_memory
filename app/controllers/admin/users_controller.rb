# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_user, only: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user.update(user_params) ? (redirect_to admin_user_path(@user)) : (render :edit)
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :is_deleted)
    end

    def ensure_user
      @user = User.find(params[:id])
    end
end
