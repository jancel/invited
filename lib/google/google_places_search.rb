class GooglePlacesSearch
  include Google::Places

  attr_accessor :location, :sensor, :options

  def initialize( values )
    @optional_params_array = [:keyword, :name, :types]

    set_location(values) # required for search
    set_radius(values)
    super(values)
  end

  def set_radius(options)
    @radius = RADIUS
    @radius = options[:radius] if !options[:radius].blank?
  end

  def params
    "location=#{@location}&radius=#{@radius}"
  end
end

# required
# location: lat,lon
# radius: 2.5 miles (in kilometers), default.  different if map is adjusted
# sensor: true if map isn't adjusted, false otherwise

# optional
# keyword: matches all fields
# language: later we may consider more languages
# name: if this is passed, it will only match against the name of places
# types: type1|type2|type3, if passed, it will only match the type of place

# Example Request
# https://maps.googleapis.com/maps/api/place/search/json?
      # location=-33.8670522,151.1957362
      # &radius=500
      # &types=food
      # &name=harbour
      # &sensor=false
      # &key=AIzaSyAiFpFd85eMtfbvmVNEYuNds5TEF9FjIPI?
