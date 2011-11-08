require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class DeviceStrategy < ::Devise::Strategies::Base
      def valid? 
        # only valid if request is coming from Android-app/1.0?
        user_agent = request.env['HTTP_USER_AGENT']
        return !user_agent.match('Android').nil? && params['app_token'].present? && params['device_id'].present?
      end 

      def authenticate! 
        failure_message = "Authentication failed for device/user"
        # code here for doing authentication; if successful, call success! 
        # (resource) where resource is the 
        # whatever you've authenticated, e.g. user; if fail, call fail! 
        # (message) where message is the failure message 
        begin
          user = User.find_by_app_token(params[:app_token])

          if user.nil?
            fail!(failure_message)
          else
            device = user.devices.find(:identifier => params[:device_id], :activated => true)

            if device.nil?
              fail!(failure_message)
            end

            success!(user)
          end
        rescue
          fail!(failure_message)
        end
      end 
    end
  end
end

Warden::Strategies.add(:device_auth_strategy, Devise::Strategies::DeviceStrategy)
# 
# 
# 
# Warden::Strategies.add(:device_auth_strategy) do 
#   def valid? 
#     # only valid if request is coming from Android-app/1.0?
#     user_agent = request.env['HTTP_USER_AGENT']
#     return !user_agent.match('Android').nil? && params['app_token'].present? && params['device_id'].present?
#   end 
# 
#   def authenticate! 
#     failure_message = "Authentication failed for device/user"
#     # code here for doing authentication; if successful, call success! 
#     # (resource) where resource is the 
#     # whatever you've authenticated, e.g. user; if fail, call fail! 
#     # (message) where message is the failure message 
#     begin
#       user = User.find_by_app_token(params[:app_token])
#       
#       if user.nil?
#         fail!(failure_message)
#       else
#         device = user.devices.find(:identifier => params[:device_id], :activated => true)
#         
#         if device.nil?
#           fail!(failure_message)
#         end
#         
#         success!(user)
#       end
#     rescue
#       fail!(failure_message)
#     end
#   end 
# end
