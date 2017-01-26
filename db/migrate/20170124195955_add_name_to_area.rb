class AddNameToArea < ActiveRecord::Migration[5.0]
  def change
    add_column :areas, :name, :string
  end
end
