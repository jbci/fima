class AddImageToProject < ActiveRecord::Migration[5.0]
  def self.up
    change_table :projects do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :projects, :image
  end
end
