# frozen_string_literal: true

class Public::GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
  end

  def search
    # ここで空の配列を作ります
    @games = []
    @title = params[:title]
    if @title.present?
      # この部分でresultsに楽天APIから取得したデータ（jsonデータ）を格納します。
      # 今回はゲームのタイトルを検索して、一致するデータを格納するように設定しています。
      results = RakutenWebService::Books::Game.search({
        title: @title,
      })
      # この部分で「@games」にAPIからの取得したJSONデータを格納していきます。
      # read(result)については、privateメソッドとして、設定しております。
      results.each do |result|
        game = Game.new(read(result))
        @games << game
      end
    end
    # 「@games」内の各データをそれぞれ保存していきます。
    # すでに保存済の本は除外するためにunlessの構文を記載しています。
    @games.each do |game|
      unless Game.all.include?(game)
        game.save
      end
    end
  end

  private
    # 「楽天APIのデータから必要なデータを絞り込む」、且つ「対応するカラムにデータを格納する」メソッドを設定していきます。
    def read(result)
      title = result["title"]
      url = result["itemUrl"]
      jan = result["jan"]
      image_url = result["mediumImageUrl"]
      item_caption = result["itemCaption"]
      {
        title: title,
        url: url,
        jan: jan,
        image_url: image_url,
        item_caption: item_caption
      }
    end
end
