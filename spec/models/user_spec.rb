require 'spec_helper'

describe User do
  describe "email_exists?" do
    it "should not error" do
      lambda {
        User.email_exists?(FactoryGirl.generate(:email))
      }.should_not raise_error
    end
    
    it "should raise error" do
      lambda {
        User.email_exists?()
      }.should raise_error
    end
    
    it "should return false" do
      User.email_exists?(FactoryGirl.generate(:email)).should eql false
    end
    
    it "should return true if exists" do
      User.stub!(:find_by_email).and_return([User.new])
      User.email_exists?(FactoryGirl.generate(:email)).should eql true
    end
  end
  
  describe "create_by_device" do
    describe "with required fields" do
      it "should create the user" do
        lambda {
          @user = User.create_by_device("device_id", true, FactoryGirl.generate(:email))
        }.should change(User, :count).by(1)
        Device.count.should eql(1)
        @user.devices.count.should eql(1)
        @user.devices.first.should be_activated
      end
    end
  end
  
  describe "user accepted terms" do
    it "should require true for terms" do
      user = Factory(:user)
      user.should be_valid
      user.terms = false
      user.should_not be_valid
    end
  end
  
  describe "authenticate_by_app_token_and_device_identifier(app_token, device_identifier)" do
    it "should work for user" do
      user = Factory(:user_with_device)
      user.devices.count.should eql 1
      User.authenticate_by_app_token_and_device_identifier(user.app_token, user.devices.first.identifier).should eql user
    end
    
    it "should be nil uness authentic" do
      user = Factory(:user_with_device)
      user.devices.count.should eql 1
      User.authenticate_by_app_token_and_device_identifier(user.app_token, "faker").should eql nil
    end
  end
  
  describe ".app_token" do
    it "should be findable" do
      current_user.app_token.should_not be_blank
      User.find_by_app_token(current_user.app_token).should eql(current_user)
    end
    
    it "should not change" do
      original_token = current_user.app_token
      original_token.should_not be_blank
      current_user.email = FactoryGirl.generate(:email)
      current_user.save
      original_token.should eql current_user.app_token
    end
  end
  
  describe "associations" do
    
    describe "events" do
      it "should have method events" do
        current_user.events.should eql []
      end
      it "should allow user to create an event" do
        current_user.events << Factory(:event)
        current_user.events.count.should eql 1
        current_user.events[0].id.should_not be_nil
      end
    end
    
    describe "devices" do
      it "should have devices" do
        current_user.devices.class.should eql Array
      end
    end
  end
  
  describe "deleting a user" do
    it "should destroy all related events" do
      u = Factory(:user_with_events_and_device)
      u.destroy
      Event.find_all_by_user_id(u.id).count.should eql 0
    end
    it "should destroy all related devices" do
      u = Factory(:user_with_events_and_device)
      u.destroy
      Device.find_all_by_user_id(u.id).count.should eql 0
    end
  end
  
  describe "nested attributes" do
    it "should accept attributes for device" do
      lambda {
        Factory(:user, :events_attributes => [{:name => "Hello"}])
      }.should change(Event, :count).by(1)
    end
    
    it "should accept nested attributes for event" do
      lambda {
        Factory(:user, :devices_attributes => [{:identifier => FactoryGirl.generate(:device_identifier)}])
      }.should change(Device, :count).by(1)
    end
  end
  
  def current_user
    @user ||= Factory(:user)
  end
end
