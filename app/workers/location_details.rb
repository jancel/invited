class LocationDetails
  cattr_accessor :queue
  
  @queue = :location_details_queue

  class << self
    def perform(location_reference)
      return unless location_reference.match(/^some_place_reference_id_\d*$/).nil?
      # Do some stuff
      #
      loc = Location.find_by_reference(location_reference)
      google_places_details = get_json_hash(location_reference)
      
      result = google_places_details[:result]
      loc.from_places_hash(result.symbolize_keys) 
      nil
    end

    def get_json_hash(reference)
      ActiveSupport::JSON.decode(get_details(reference)).symbolize_keys!
    end

    def get_details(reference)
      GooglePlacesDetails.new( :reference => reference ).get_data
    end
  end
end
