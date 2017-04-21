class Indicator < ApplicationRecord

  belongs_to :section
  has_many :evaluations, dependent: :destroy
  validates_presence_of :title, :description

  has_attached_file :icon
  validates_attachment_content_type :icon, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_size :icon, :less_than => 10.kilobytes

  default_scope { order(created_at: :asc) }
end
