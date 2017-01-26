class AddAreaLevelRefToArea < ActiveRecord::Migration[5.0]
  def change
    add_reference :areas, :area_level, index: true
  end
end
