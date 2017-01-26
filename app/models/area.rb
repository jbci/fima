class Area < ApplicationRecord
  acts_as_tree order: "name"

  belongs_to :area_level
  validates_presence_of :name

  scope :comunas, -> {
                      level = AreaLevel.find_by_name('Comuna')
                      where(area_level: level)
                    }

  scope :regiones, -> {
                      level = AreaLevel.find_by_name('Región')
                      where(area_level: level)
                    }

end
