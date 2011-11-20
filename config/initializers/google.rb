GOOGLE_CONFIG = YAML.load_file("#{Rails.root}/config/google_apis.yml")[Rails.env]
# load 'lib/google/places.rb'

load 'lib/google/google_places_search.rb'
load 'lib/google/google_places_details.rb'
