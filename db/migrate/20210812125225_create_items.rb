class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      
      t.string :name
      t.string :code
      t.string :price
      t.string :url
      t.integer :imageflag
      t.string :image
      
      t.timestamps
      
    end
  end
end
