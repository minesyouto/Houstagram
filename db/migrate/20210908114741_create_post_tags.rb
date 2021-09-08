class CreatePostTags < ActiveRecord::Migration[5.2]
  def change
    create_table :post_tags do |t|

      t.timestamps
      t.string :name
      t.integer :post_image_id
    end
  end
end
