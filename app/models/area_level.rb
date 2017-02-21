class AreaLevel < ApplicationRecord
  extend ActsAsTree::TreeView

  acts_as_tree order: "name"

  validates_uniqueness_of :name
  validates_presence_of :name

end
