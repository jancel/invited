FactoryGirl.define do
  
  factory :user do
    sequence(:email) {|n| "person#{n}@example.com" }
    terms true
    password "whatevs"
  end
  
end