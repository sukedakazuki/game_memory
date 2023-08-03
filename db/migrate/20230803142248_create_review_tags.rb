class CreateReviewTags < ActiveRecord::Migration[6.1]
  def change
    create_table :review_tags do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :review_tags, :name, unique:true
  end
end
