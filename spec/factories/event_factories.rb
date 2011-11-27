FactoryGirl.define do
  
  factory :event do
    sequence(:name) { |n| "event_name_#{n}" }
  end
  
end
