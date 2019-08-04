class FixLikesIndex < ActiveRecord::Migration[5.2]
  def change
    remove_index :likes, name: :index_likes_on_photo
    remove_index :likes, name: :index_likes_on_user
    remove_index :likes, name: :index_likes_on_photo_and_user
    add_index :likes, [:photo_id, :user_id], unique: true
  end
end
