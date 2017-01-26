class AddParentToArea < ActiveRecord::Migration[5.0]
  def change
    add_reference :areas, :parent, references: :areas, index: true
  end
end
