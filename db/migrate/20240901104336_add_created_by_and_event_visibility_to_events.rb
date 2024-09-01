class AddCreatedByAndEventVisibilityToEvents < ActiveRecord::Migration[7.2]
  def change
    add_reference :events, :created_by, foreign_key: { to_table: :users }
    add_column :events, :event_visibility, :string, default: "public", null: false

    add_index :events, :event_visibility
  end
end
