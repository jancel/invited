APP_CONFIG = YAML.load_file("#{Rails.root}/config/application.yml")[Rails.env] unless defined? APP_CONFIG
Resque::Server.use(Rack::Auth::Basic) do |user, password|
  password == APP_CONFIG["resque_pass"]
end
