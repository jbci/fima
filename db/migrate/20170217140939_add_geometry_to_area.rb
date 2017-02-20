class AddGeometryToArea < ActiveRecord::Migration[5.0]
  def change
    add_column :areas, :geom, :geometry, :srid => 4326
  end
end
