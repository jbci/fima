class AddDescriptionToIndicator < ActiveRecord::Migration[5.0]
  def change
    add_column :indicators, :description, :string
  end
end
