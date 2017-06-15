class Project < ApplicationRecord
  has_and_belongs_to_many :areas

  has_attached_file :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  def remaining_days
    num = (self.end_date - Date.today).to_i
    num < 1 ? 0 : num
  end
  def remaining_days_2
    (self.end_date_2 - Date.today).to_i
  end

end
