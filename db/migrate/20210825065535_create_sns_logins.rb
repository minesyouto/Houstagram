class CreateSnsLogins < ActiveRecord::Migration[5.2]
  def change
    create_table :sns_logins do |t|
      t.string :provider
      t.string :uid
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
