class Public::TagsearchesController < ApplicationController
  def search
    @model = Review
    @word = params[:content]
    @reviews = ReviewTag.where("name LIKE?","%#{@word}%")
    render "public/tagsearches/tagsearch"
  end
end
