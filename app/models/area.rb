class Area < ApplicationRecord
  extend ActsAsTree::TreeView

  acts_as_tree order: "name"

  belongs_to :area_level
  has_many :evaluations, dependent: :destroy
  has_many :posts, dependent: :nullify
  has_many :projects, dependent: :nullify

  validates_presence_of :name

  scope :comunas, -> {
                      level = AreaLevel.find_by_name('Comuna')
                      where(area_level: level)
                    }

  scope :regiones, -> {
                      level = AreaLevel.find_by_name('Región')
                      where(area_level: level)
                    }

  scope :paises, -> {
                      level = AreaLevel.find_by_name('País')
                      where(area_level: level)
                    }

  def geojson
    geom = RGeo::GeoJSON.encode(self.geom)

    {:type => "Feature",
     :geometry => geom,
     :properties => { :name => self.name}}.to_json
  end

  def geojson_centroid
    geom = RGeo::GeoJSON.encode(self.geom.centroid)

    {:type => "Feature",
     :geometry => geom,
     :properties => { :name => self.name}}.to_json
  end

  def centroid_coordinates
    centroid = (self.geom.centroid)

    {lat: centroid.y, lng: centroid.x}.to_json
  end

  def posts_average
    array = self.posts.map{|p| p.average("problem").avg unless p.average("problem").nil?}.compact
    average = array.inject(0.0) { |sum, el| sum + el } / array.size
    average.nan? ? 0 : "%0.2f" % [average]
  end
end
