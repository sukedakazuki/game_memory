# frozen_string_literal: true

class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games, id: false do |t|
      t.string :title
      t.text :item_caption
      t.bigint :jan, null: false, primary_key: true
      t.text :url
      t.text :image_url
      t.timestamps
    end
  end
end
