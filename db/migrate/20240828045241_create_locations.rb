class CreateLocations < ActiveRecord::Migration[7.2]
  def change
     create_table :locations do |t|
      t.string :name, null: false
      t.string :address
      t.string :pincode
      t.timestamps
    end

    add_index :locations, :pincode
  end
end
