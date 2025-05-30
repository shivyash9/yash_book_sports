class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.string :encrypted_password, null: false
      t.string :first_name
      t.string :last_name
      t.boolean :admin, default: false
      t.timestamps
    end

    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
  end
end
