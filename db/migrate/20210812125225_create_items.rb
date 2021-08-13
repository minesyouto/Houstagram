class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      
      t.string :itemname
      t.string :itemcode
      t.string :itemprice
      t.string :itemurl
      t.integer :imageflag
      t.string :mediumimageurls
      
      t.timestamps
      
    end
  end
end
