FactoryGirl.define do

  factory :device do
    typel "Android"
    sequence(:dev_id) { |i| "unique_device_id_#{i}" }
    activated true
  end
  
end