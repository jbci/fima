class Project < ApplicationRecord
  belongs_to :area

  has_attached_file :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  def remaining_days
    (self.end_date - Date.today).to_i
  end

end
