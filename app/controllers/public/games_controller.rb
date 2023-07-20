class Public::GamesController < ApplicationController
  def search
    if params[:keyword]
      @games = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
    end
  end
end
