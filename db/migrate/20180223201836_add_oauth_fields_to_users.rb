class AddOauthFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :uid, :string, null: false
    add_index :users, :uid, unique: true
    add_column :users, :oauth_token, :string, null: false
    add_column :users, :oauth_secret, :string, null: false
    add_column :users, :picture, :string
  end
end
