class AddMarkToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :mark, :boolean
  end
end
