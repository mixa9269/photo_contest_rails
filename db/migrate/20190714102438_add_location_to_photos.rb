class AddLocationToPhotos < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :location, :string
  end
end
