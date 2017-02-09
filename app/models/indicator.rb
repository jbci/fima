class Indicator < ApplicationRecord

  belongs_to :section
  has_many :evaluations, dependent: :destroy
  validates_presence_of :title, :description

  default_scope { order(created_at: :asc) }
end
