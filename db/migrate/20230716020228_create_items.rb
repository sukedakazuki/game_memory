class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :itemName
      t.text :itemCaption
      t.text :itemUrl
      t.text :smallImageUrls
      t.text :mediumImageUrls
      t.timestamps
    end
  end
end
