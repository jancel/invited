FactoryGirl.define do

  factory :device do
    typel "Android"
    sequence(:identifier) { |i| "unique_device_id_#{i}" }
    activated true
  end
  
end