class AddAuthsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :password, :string
    add_column :users, :token, :string
    add_index :users, :token, unique: true
  end
end
