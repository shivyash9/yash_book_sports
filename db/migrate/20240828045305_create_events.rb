class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.text :description
      t.integer :total_seats, null: false
      t.references :sport, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.timestamps
    end

    add_index :events, [:start_time, :end_time]
  end
end
