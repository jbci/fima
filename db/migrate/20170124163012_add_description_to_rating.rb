class AddDescriptionToRating < ActiveRecord::Migration[5.0]
  def change
    add_column :ratings, :description, :string
  end
end
