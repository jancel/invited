class Device < ActiveRecord::Base
  
  belongs_to :user
  
  validates_presence_of :dev_id
  validates_uniqueness_of :dev_id, :scope => :activated
end
