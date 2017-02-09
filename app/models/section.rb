class Section < ApplicationRecord

  has_many :indicators, dependent: :destroy
  belongs_to :rating

  validates_presence_of :title, :description

  accepts_nested_attributes_for :indicators, reject_if: :all_blank, allow_destroy: true

  default_scope { order(created_at: :asc) }
end
