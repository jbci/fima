class AddTitleToRating < ActiveRecord::Migration[5.0]
  def change
    add_column :ratings, :title, :string
  end
end
