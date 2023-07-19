class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.float :rate
      t.text :comment
      t.integer :user_id
      t.integer :game_id
      t.timestamps
    end
  end
end