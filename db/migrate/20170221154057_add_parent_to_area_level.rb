class AddParentToAreaLevel < ActiveRecord::Migration[5.0]
  def change
    add_reference :area_levels, :parent, references: :area_levels, index: true
  end
end
