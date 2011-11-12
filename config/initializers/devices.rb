Dir["#{Rails.root}/lib/device/authorization/strategies/**/*authenticatable.rb"].each do |device|
  load device
end


Warden::Strategies.add(:android, Devise::Strategies::AndroidAuthenticatable)
