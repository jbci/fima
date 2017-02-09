class Indicator < ApplicationRecord

  belongs_to :section

  validates_presence_of :title, :description

  default_scope { order(created_at: :asc) }
end
