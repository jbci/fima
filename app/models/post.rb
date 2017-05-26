class Post < ApplicationRecord
  validates_presence_of :title, :body

  belongs_to :area

  has_attached_file :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  ratyrate_rateable "problem", "implementation"

  def avg_rating
    p "average rating of post"
    average = self.average("problem").avg
    p average
    p "%0.2f" % [average]
    p "average rating of post"
    average.nan? ? 0 : "%0.1f" % [average]
  end

end
