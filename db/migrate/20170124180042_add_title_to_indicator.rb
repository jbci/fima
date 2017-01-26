class AddTitleToIndicator < ActiveRecord::Migration[5.0]
  def change
    add_column :indicators, :title, :string
  end
end
