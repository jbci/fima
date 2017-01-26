class AddNameToAreaLevel < ActiveRecord::Migration[5.0]
  def change
    add_column :area_levels, :name, :string
  end
end
