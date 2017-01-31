class AddAreaRefToPost < ActiveRecord::Migration[5.0]
  def change
    add_reference :posts, :area, foreign_key: true
  end
end
