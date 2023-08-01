class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(current_user.id)
    @reviews = @user.reviews
    if params[:latest]
      @reviews = @user.reviews.latest
    elsif params[:old]
      @reviews = @user.reviews.old
    end
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      flash[:notice] = "ユーザーの編集に成功しました。"
      redirect_to users_information_path(@user.id)
    else
      flash.now[:alart_flash] = "ユーザーの編集に失敗しました。"
      render :edit
    end
  end
  
  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行しました。"
    redirect_to root_path
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
