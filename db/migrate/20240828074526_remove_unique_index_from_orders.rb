class RemoveUniqueIndexFromOrders < ActiveRecord::Migration[7.2]
  def change
      remove_index :orders, name: 'index_orders_on_user_id_and_event_id'
  end
end
