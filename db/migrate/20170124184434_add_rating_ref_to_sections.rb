class AddRatingRefToSections < ActiveRecord::Migration[5.0]
  def change
    add_reference :sections, :rating, foreign_key: true
  end
end
