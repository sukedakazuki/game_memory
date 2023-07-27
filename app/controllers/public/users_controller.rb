class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(current_user.id)
    @reviews = @user.reviews
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to users_information_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :email, :is_deleted)
  end

  def is_matching_login_user
    user = User.find(current_user.id)
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
end
