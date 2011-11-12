FactoryGirl.define do
  
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    terms true
    password "whatevs"
    sequence(:app_token) { |t| "token_test#{t}" }
  end
  
  factory :user_with_device, :parent => :user do
    after_build do |u|
      u.devices = [Factory(:device)]
    end
  end
end