class AddNosotrosToRatings < ActiveRecord::Migration[5.0]
  def change
    add_column :ratings, :nosotros, :string
  end
end
