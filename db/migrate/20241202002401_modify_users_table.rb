class ModifyUsersTable < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :password, :string

    add_column :users, :nickname, :string
  end
end
