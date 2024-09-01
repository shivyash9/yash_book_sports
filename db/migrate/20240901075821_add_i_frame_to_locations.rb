class AddIFrameToLocations < ActiveRecord::Migration[7.2]
  def change
    add_column :locations, :iframe, :string
  end
end
