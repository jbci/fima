class AddAttachmentToIndicators < ActiveRecord::Migration[5.0]
  def self.up
    change_table :indicators do |t|
      t.attachment :icon
    end
  end

  def self.down
    remove_attachment :indicators, :icon
  end
end
