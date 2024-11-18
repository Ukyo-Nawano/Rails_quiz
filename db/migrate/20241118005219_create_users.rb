class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :image
      t.string :uid, null: false, unique: true  # Auth0のUIDを保存
      t.string :password

      t.timestamps
    end
  end
end
