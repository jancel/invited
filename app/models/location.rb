class Location < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  validates_presence_of :reference
  
  before_save :update_user_id
  def update_user_id
    self.user_id = self.event.user_id unless event_id.blank?
  end
end
