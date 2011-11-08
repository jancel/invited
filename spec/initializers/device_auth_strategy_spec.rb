require 'spec_helper'
require "active_support/all"

PARAMS = { :app_token => "123456", :device_id => FactoryGirl.generate(:device_identifier) }
HEADERS = { "HTTP_USER_AGENT" => "Android-app/1.0" }

describe 'DeviceAuthStrategy' do
  describe 'Authentication' do
    before(:each) do
      # @strategy = Devise::Strategies::DeviceStrategy
      # @mapping = mock(:mapping)
      # @mapping.should_receive(:to).and_return(User)
      # @strategy.should_receive(:mapping).and_return(@mapping)
      # @strategy.should_receive(:params).and_return(PARAMS)
      # @strategy.should_receive(:headers).and_return(HEADERS)
    end
    
    describe "application headers" do
      it "should be 1" do
        1.should eql 1
      end
    end
    
    describe "param values"
  end
end