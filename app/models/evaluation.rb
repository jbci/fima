class Evaluation < ApplicationRecord
  belongs_to :area
  belongs_to :indicator

  validates_presence_of :value
end
