module Google
  module Places
    API_KEY = GOOGLE_CONFIG['google_places'].freeze unless defined? API_KEY
    RADIUS = 4023.36.freeze  unless defined? RADIUS # 2.5 miles
    FORMAT = "json".freeze  unless defined? FORMAT

    def initialize(options = {})
      set_sensor(options)
      set_optional_params(options)
      set_format(options)
    end

    def set_format(options)
      @format = FORMAT
      @format = options[:format].to_s unless options[:format].blank?
    end

    def set_sensor(options)
      @sensor = false
      @sensor = true if options[:sensor] || options[:sensor] == "true"
    end

    def set_location(options)
      raise "Location or Lat/Long is required" if options[:location].blank? && (options[:lat].blank? && options[:lon].blank?)

      if options[:location].blank?
        location_from_lat_lon(options[:lat], options[:lon])
      else
        @location ||= options[:location]
      end

      raise "Location not in proper lat,lon format" if @location.match(/^-?\d*\.?\d+,-?\d*\.?\d+$/).nil?
    end

    def set_optional_params( options )
      @options ||= {}
      @optional_params_array ||= []
      @optional_params_array.push(:language)
      @optional_params_array.each do |key|
        @options[key] = options[key]
      end
      @options.delete_if { |k, v| v.nil? }
    end
    
    def location_from_lat_lon(lat, lon)
      @location ||= "#{lat},#{lon}"
    end

    def url
      "https://maps.googleapis.com/maps/api/place/#{type}/#{@format}?#{params}&key=#{API_KEY}&sensor=#{@sensor}#{optional_params}"
    end

    def params
      raise "Must implement params method"
    end

    def optional_params
      params_string = ""
      @options.each do |k, v|
        params_string += "&#{k.to_s}=#{v.gsub(/\|/,'%7C')}"
      end unless @options.blank?
      params_string
    end

    def get_data
      require 'net/https'
      require 'uri'

      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      
      
      
#      File.open("#{Rails.root}/lib/google/detail_request.js", 'w') { |f| f.write(response.body) }
      
      response.body
    end

    def type
      self.class.name.to_s.downcase.gsub("googleplaces", "")
    end

  end
end
