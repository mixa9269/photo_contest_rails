class AddCommentsCountToPhotos < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :comments_count, :integer
  end
end
