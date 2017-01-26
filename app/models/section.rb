class Section < ApplicationRecord

  has_many :indicators
  belongs_to :rating

  validates_presence_of :title, :description

  accepts_nested_attributes_for :indicators, reject_if: :all_blank, allow_destroy: true
end
