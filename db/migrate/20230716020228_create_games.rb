class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :item_name
      t.text :item_caption
      t.text :item_url
      t.text :small_image_urls
      t.text :medium_image_urls
      t.timestamps
    end
  end
end
