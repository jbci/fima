class Indicator < ApplicationRecord

  belongs_to :section

  validates_presence_of :title, :description

end
