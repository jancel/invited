class Location < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  validates_presence_of :reference
  
  before_save :update_user_id
  def update_user_id
    self.user_id = self.event.user_id unless event_id.blank?
  end

  after_save :get_details
  def get_details
    if self.places_id.blank?
      Resque.enqueue(LocationDetails, self.reference)
    end
  end

  def from_places_hash(places_hash)
    # TODO: Implement and get this stuff out of a presenter
    self.places_id = places_hash[:id]
    self.name = places_hash[:name]
    self.vicinity = places_hash[:vicinity]
    if places_hash[:geometry] && places_hash[:geometry]["location"]
      self.lat = places_hash[:geometry]["location"]["lat"]
      self.lon = places_hash[:geometry]["location"]["lng"]
    end
    self.address = places_hash[:formatted_address]
    self.url = places_hash[:url]
    self.icon = places_hash[:icon]
    self.phone = places_hash[:formatted_phone_number]
    self.i18n_phone = places_hash[:international_phone_number]
    self.save
  end
end
