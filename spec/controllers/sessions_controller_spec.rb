require 'spec_helper'

describe SessionsController do
  before(:each) do
    auth
  end
  
  describe "failuer" do
    it "should be a failure, to test hudson tracker" do
     1.should eql 2
    end
  end
  describe "#device_session" do
    describe "success" do
      it "should allow device to establish a session" do
        user = Factory(:user_with_device)
        request.env['HTTP_USER_AGENT'] = "Android-app/0.0"        
        post :device_session,
          {:device_id => user.devices[0].dev_id,
          :app_token => user.app_token}
        session["warden.user.user.key"].should_not be_blank
        response.should_not be_redirect
      end
    end
    describe "failure" do
      it "should not create a session" do
        user = Factory(:user_with_device)
        post :device_session,
          {:device_id => user.devices[0].dev_id,
          :app_token => user.app_token}
        session["warden.user.user.key"].should be_blank
        response.should be_redirect
      end
    end
  end
  describe "#device_activation" do
    describe "requirements" do
      describe "should require device_id" do
        it "blank device_id responds with error" do
          failure_requirements_expectations
          post :device_activation, 
            :email => "test@example.com", 
            :terms => true, 
            :format => 'json'
          response.should be_success
          response.body.should have_json_path('errors')
          response.body.should have_json_size(1).at_path("errors")
        end
      end
      describe "should require terms acceptance" do
        it "blank terms responds with error" do
          failure_requirements_expectations
          post :device_activation, :format => 'json'
          response.should be_success
          response.body.should have_json_path('errors')
          response.body.should have_json_size(4).at_path("errors")
        end
      end
      describe "should require email address" do
        it "blank email responds with error" do
          failure_requirements_expectations
          post :device_activation,
            :device_id => FactoryGirl.generate(:device_identifier), 
            :terms => true, 
            :format => 'json'
          response.should be_success
          response.body.should have_json_path('errors')
          response.body.should have_json_size(1).at_path("errors")
        end
      end
      describe "expectations" do
        it "should have expectations" do
          failure_requirements_expectations
          post :device_activation, :format => 'json'
          response.should be_success
          response.body.should have_json_path('errors')
          response.body.should have_json_size(4).at_path("errors")
        end
      end
      
      def failure_requirements_expectations

      end
    end
    
    describe "New User" do
      before(:each) do
      end
      
      it "should require user to accept terms"  do
        post :device_activation, 
          :email => FactoryGirl.generate(:email), 
          :device_id => FactoryGirl.generate(:device_identifier), 
          :terms => false, 
          :format => "json"
          response.should be_success
          response.body.should have_json_path('errors')
          response.body.should have_json_size(2).at_path("errors")
      end
    
      it "should create a new user" do
        User.stub!(:email_exists?).and_return(false)
        new_user_expectations
        post :device_activation, 
          :email => FactoryGirl.generate(:email), 
          :device_id => FactoryGirl.generate(:device_identifier), 
          :terms => true, 
          :format => "json"
        response.should be_success
        response.body.should have_json_path('user')
        response.body.should have_json_path('user/app_token')
        response.body.should_not have_json_path('user/email')
        response.body.should_not have_json_path('user/terms')
      end
      
      it "should establish a session" do
        post :device_activation, 
          :email => FactoryGirl.generate(:email), 
          :device_id => FactoryGirl.generate(:device_identifier), 
          :terms => true, 
          :format => "json"
        session["warden.user.user.key"].should_not be_blank
      end
    
      def new_user_expectations
        # User.should_receive(:email_exists?).once
      end
      
      describe "Duplicate device activation" do
        it "should return errors for second device activation" do
          User.stub!(:email_exists?).and_return(false)
          device_id = FactoryGirl.generate(:device_identifier)
          post :device_activation, 
            :email => FactoryGirl.generate(:email), 
            :device_id => device_id, 
            :terms => true, 
            :format => "json"
          response.should be_success
          response.body.should have_json_path('user')
          response.body.should have_json_path('user/app_token')
          post :device_activation, 
            :email => FactoryGirl.generate(:email), 
            :device_id => device_id, 
            :terms => true, 
            :format => "json"
          response.should be_success
          response.body.should have_json_path('errors/devices.dev_id')
        end
      end
    end
    
    
  end
end