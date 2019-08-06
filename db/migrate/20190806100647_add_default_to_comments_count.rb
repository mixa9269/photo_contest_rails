class AddDefaultToCommentsCount < ActiveRecord::Migration[5.2]
  def change
    change_column_default :photos, :comments_count, 0
  end
end
