require 'spec_helper'

describe Devise::Strategies::AndroidAuthenticatable do
  it "shold error out without request" do
    lambda {
      Devise::Strategies::AndroidAuthenticatable.new
    }.should raise_error
  end
  
  describe ".valid?" do
    before (:each) do
      @request = mock(:request)
      @strategy = Devise::Strategies::AndroidAuthenticatable.new(nil)
    end
    
    it "should be true" do
      @request.should_receive(:headers).and_return({'HTTP_USER_AGENT' => "Android-app/0.0"})
      @strategy.should_receive(:params).at_least(:once).and_return({'app_token' => "test", 'device_id' => "test_dev_id"})
      @strategy.should_receive(:request).and_return(@request)

      lambda {
        @strategy.should be_valid
      }.should_not raise_error
    
      @user = Factory(:user)
    end
    
    it "should be false when params aren't there" do
      @strategy.should_receive(:params).at_least(:once).and_return({})
      @strategy.should_not be_valid
    end
    
    it "should be false when params app_token isn't there" do
      @strategy.should_receive(:params).at_least(:once).and_return({'device_id' => 'test'})
      @strategy.should_not be_valid
    end
    
    it "should be false when params device_id isn't there" do
      @strategy.should_receive(:params).at_least(:once).and_return({'app_token' => 'test'})
      @strategy.should_not be_valid
    end
    
    it "should be false if user_agent is not Android" do
      @request.should_receive(:headers).and_return({'HTTP_USER_AGENT' => "iPhone-app/0.0"})
      @strategy.should_receive(:params).at_least(:once).and_return({'app_token' => "test", 'device_id' => "test_dev_id"})
      @strategy.should_receive(:request).and_return(@request)
      
      @strategy.should_not be_valid
    end
  end
  
  describe ".authenticate!" do
    before(:each) do
      @user = Factory(:user_with_device)
      @strategy = Devise::Strategies::AndroidAuthenticatable.new(nil)
      
      # Make sure mapping.to (Authentiatable) is working
      @mapping = mock(:mapping)
      @strategy.should_receive(:mapping).and_return(@mapping)
      @mapping.should_receive(:to).and_return(User)
    end
    
    it "should authenticate android devices" do
      user_hash = {'app_token' => @user.app_token, 'device_id' => @user.devices.first.dev_id}
      @strategy.should_receive(:params).at_least(:once).and_return(user_hash)

      lambda {
        @strategy.authenticate!.should eql :success
      }.should_not raise_error
    end
    it "should not authenticate on invalid data" do
      user_hash = {'app_token' => @user.app_token, 'device_id' => "fake"}
      @strategy.should_receive(:params).at_least(:once).and_return(user_hash)
      @strategy.authenticate!.should eql :failure
    end
    
    it "should not authenticate on invalid data" do
      user_hash = {'app_token' => "1234", 'device_id' => @user.devices.first.dev_id}
      @strategy.should_receive(:params).at_least(:once).and_return(user_hash)
      @strategy.authenticate!.should eql :failure
    end
    
    it "should not authenticate on invalid data" do
      user_hash = {'app_token' => "1234", 'device_id' => 'fake'}
      @strategy.should_receive(:params).at_least(:once).and_return(user_hash)
      @strategy.authenticate!.should eql :failure
    end
    
  end
end