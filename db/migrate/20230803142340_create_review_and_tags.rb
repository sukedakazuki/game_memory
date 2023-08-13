# frozen_string_literal: true

class CreateReviewAndTags < ActiveRecord::Migration[6.1]
  def change
    create_table :review_and_tags do |t|
      t.references :review, null: false, foreign_key: true
      t.references :review_tag, null: false, foreign_key: true

      t.timestamps
    end
    # 同じタグは２回保存出来ない
    add_index :review_and_tags, [:review_id, :review_tag_id], unique: true
  end
end
