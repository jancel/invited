class Event < ActiveRecord::Base
  belongs_to :user
  has_one :location

  accepts_nested_attributes_for :location
end
