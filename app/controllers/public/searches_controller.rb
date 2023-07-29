class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

	def search
    @range = params[:range]

    if @range == "Game"
      @games = Game.looks(params[:search], params[:word])
    else
      @reviews = Review.looks(params[:search], params[:word])
    end
  end
end
