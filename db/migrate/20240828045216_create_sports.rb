class CreateSports < ActiveRecord::Migration[7.2]
  def change
   create_table :sports do |t|
      t.string :name, null: false
      t.text :description
      t.text :image
      t.timestamps
    end

    add_index :sports, :name, unique: true
  end
end
