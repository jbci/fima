class AddDescriptionToSection < ActiveRecord::Migration[5.0]
  def change
    add_column :sections, :description, :string
  end
end
