FactoryGirl.define do
  
  factory :event do
    sequence(:name) { |n| "event_name_#{n}" }
    sequence(:location) { |n| "event_location_#{n}" }
  end
  
end