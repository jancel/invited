class Device < ActiveRecord::Base
  
  belongs_to :user
  
  validates_presence_of :identifier
  validates_uniqueness_of :identifier, :scope => :activated
  
end
