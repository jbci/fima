class Area < ApplicationRecord
  extend ActsAsTree::TreeView

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
  #
  # AreaLevel.all.each do |level|
  #   scope level.name.downcase.pluralize.to_sym , -> { where(area_level: level) }
  # end
  # AreaLevel.all.each do |level|
  #   p level.name.downcase.pluralize.to_sym
  # end

end
