class AddSeatsToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :seats, :integer, null: false, default: 1
  end
end
