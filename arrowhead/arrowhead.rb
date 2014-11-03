class Arrowhead
  # This seriously belongs in a database.
  CLASSIFICATIONS = {
    far_west: {
      notched: "Archaic Side Notch",
      stemmed: "Archaic Stemmed",
      lanceolate: "Agate Basin",
      bifurcated: "Cody",
    },
    northern_plains: {
      notched: "Besant",
      stemmed: "Archaic Stemmed",
      lanceolate: "Humboldt Constricted Base",
      bifurcated: "Oxbow",
    },
  }

  # FIXME: I don't have time to deal with this.
  def self.classify(region, arrowhead_shape)
    regional_shapes = CLASSIFICATIONS[region]
    raise "Unknown region, please provide a valid region." unless region_exists?(region)
    determine_arrowhead(regional_shapes, arrowhead_shape)
  end

  def self.determine_arrowhead(shapes_in_region, arrowhead_shape)
    raise "Unknown shape value. Are you sure you know what you're talking about?" unless shape_in_region?(shapes_in_region, arrowhead_shape)
    arrowhead = shapes_in_region[arrowhead_shape]
    puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end

  def self.region_exists?(region)
    CLASSIFICATIONS.include? region
  end

  def self.shape_in_region?(regional_shapes, arrowhead_shape)
    regional_shapes.include? arrowhead_shape
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
