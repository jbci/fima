class AddExtraInfoToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :names, :string
    add_column :users, :surnames, :string
    add_reference :users, :area_of_residence, foreign_key: { to_table: :areas }
    add_reference :users, :area_of_interest, foreign_key: { to_table: :areas }
  end
end
