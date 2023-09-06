# frozen_string_literal: true

class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @review = Review.page(params[:page])

    if @range == "Review"
      @reviews = Review.looks(params[:search], params[:word]).page(params[:page])
    else
      @users = User.looks(params[:search], params[:word]).page(params[:page])
    end
  end
end
