class AddAuthTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :auth_token, :string
    add_index :users, :auth_token, unique: true

    ActiveRecord::Base.transaction do 
      User.find_each do |user|
        user.regenerate_auth_token
        user.save
      end
    end
  end
end
