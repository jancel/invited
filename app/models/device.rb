class Device < ActiveRecord::Base
  
  belongs_to :user
  
  validates_presence_of :dev_id
  validates_uniqueness_of :dev_id, :scope => :activated
end

# app_token...4de9eed1fe4e44963a30d9763b17f6fb
# jancel@gmail.com
# identifier..easycheesy1