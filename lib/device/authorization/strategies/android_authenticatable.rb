require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class AndroidAuthenticatable < Authenticatable
      def valid? 
        # only valid if request is coming from Android-app/1.0?
        return valid_params? && valid_headers?
      end 

      def authenticate! 
        failure_message = "Authentication failed for device/user"

        klass = mapping.to
        begin
          user = klass.authenticate_by_app_token_and_device_identifier(params['app_token'], params['device_id'])

          if user.nil? || user.class != klass
            fail!(failure_message)
          else
            success!(user)
          end
          
        rescue
          fail!(failure_message)
        end
      end 
      
      protected
      def valid_params?
        params['app_token'].present? && params['device_id'].present?
      end
      
      def valid_headers?
        if agent = request.headers['HTTP_USER_AGENT']
          return !agent.match('Android').nil?
        end
        
        false
      end
    end
  end
end

