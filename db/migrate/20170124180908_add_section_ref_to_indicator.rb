class AddSectionRefToIndicator < ActiveRecord::Migration[5.0]
  def change
    add_reference :indicators, :section, foreign_key: true
  end
end
