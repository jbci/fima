class Rating < ApplicationRecord

  has_many :sections
  validates_presence_of :title, :description

  accepts_nested_attributes_for :sections, reject_if: :all_blank, allow_destroy: true
end
