class AddAreaToProject < ActiveRecord::Migration[5.0]
  def change
    add_reference :projects, :area, foreign_key: true
  end
end
