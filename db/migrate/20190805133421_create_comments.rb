class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :photo
      t.references :user
      t.text :content
      t.integer :parent_id

      t.timestamps
    end
  end
end
