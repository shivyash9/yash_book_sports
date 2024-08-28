class CreateOrders < ActiveRecord::Migration[7.2]
  def change
     create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.string :status, default: 'pending'
      t.timestamps
    end

    add_index :orders, [:user_id, :event_id], unique: true
  end
end
