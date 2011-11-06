FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end
  
  sequence :device_identifier do |n|
    "device#{n}_id"
  end
end