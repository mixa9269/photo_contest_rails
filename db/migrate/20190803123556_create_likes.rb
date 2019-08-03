class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :photo, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :likes, :photo
    add_index :likes, :user
    add_index :likes, [:photo, :user], unique: true
  end
end
