# frozen_string_literal: true

class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.float :rate
      t.text :comment
      t.boolean :is_deleted, null: false, default: false
      t.references :game, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
    add_foreign_key :reviews, :games, column: :game_id, primary_key: :jan
  end
end
