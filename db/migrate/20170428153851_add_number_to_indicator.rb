class AddNumberToIndicator < ActiveRecord::Migration[5.0]
  def change
    add_column :indicators, :number, :string
  end
end
