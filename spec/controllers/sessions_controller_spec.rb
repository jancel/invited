require 'spec_helper'

describe SessionsController do
  before(:each) do
    auth
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
            :device_id => "device", 
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
          :device_id => "device", 
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
          :device_id => "device", 
          :terms => true, 
          :format => "json"
        response.should be_success
        response.body.should have_json_path('user')
        response.body.should have_json_path('user/app_token')
      end
      
    
      def new_user_expectations
        User.should_receive(:email_exists?).once
      end
    end
    
    
  end
end