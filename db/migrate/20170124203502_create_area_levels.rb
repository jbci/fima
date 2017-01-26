class CreateAreaLevels < ActiveRecord::Migration[5.0]
  def change
    create_table :area_levels do |t|

      t.timestamps
    end
  end
end
