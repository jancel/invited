require 'spec_helper'

HEADERS = { "HTTP_USER_AGENT" => "Android-app/1.0" }
PARAMS = { :app_token => "123456", :device_id => FactoryGirl.generate(:device_identifier) }

describe EventsController do
  before(:each) do
    auth
    
    @user = Factory(:user)
    sign_in @user
  end

  let(:event){ Event.create(:name => "fake Event") }
  
  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
    
    describe 'json' do
      it "returns json" do
        get 'new', :format => 'json'
        response.should be_success
      end
    end
  end

  describe "GET 'show'" do
    
    it "returns http success" do
      get "show", :id => event.id
      response.should be_success
    end
    
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get "edit", :id => event.id
      response.should be_success
    end
    
    describe "json" do
      it "should return event" do
        get "show", :id => event.id, :format => "json"
        response.should be_success
        response.body.should have_json_path("id")
        response.body.should have_json_type(Integer).at_path("id")
        response.body.should be_json_eql(event.to_json)
      end
    end
  end
  
  describe "PUT 'update'" do   
    describe "successful" do
      before(:each) do
        @user.events << [Factory(:event), Factory(:event)]
        @event = @user.events[0]
      end
      
      it "should call find method" do
        put :update, :id => @event, :event => { :name => "some_other_name"}
      end
      
      it "should update attributes" do
        put :update, :id => @event, :event => { :name => "new_name" }
        @user.events.find(@event.id).name.should eql "new_name"
      end
      
      it "should redirect response" do
        post :create, :event => {} 
        response.should be_redirect
      end
    end
  end

  describe "POST 'create'" do
    describe "successful" do
      before(:each) do
        @event = mock_model(Event)
        @event.stub!(:save).and_return(@event)
        Event.stub!(:new).and_return(@event)
      end
      
      it "should create the new record" do
        Event.should_receive(:new).once
        @event.should_receive(:save).once
        post :create, :event => { :name => "Special Event" }
      end
      
      it "should redirect response" do
        post :create, :event => {} 
        response.should be_redirect
      end
    end
  end
  
  describe "DELETE 'destroy'" do
    before(:each) do
      
    end
    
    it "should delete the event"
    it "should redirect the response"
    
    describe "json" do
      it "should return success"
      it "should return failure"
    end
  end
  
  describe 'security' do
    describe "a users events" do
      describe "by unrelated other users" do
        before(:each) do
          @other_user = Factory(:user_with_events)
        end
        
        it "should not readable" do
          get 'index', :format => :json
          response.should be_success
          response.body.should be_json_eql("[]")
        end
        
        it "should not be editable" do
          lambda {
            put :update, :id => @other_user.events[0].id, :event => { :name => "other_name" }, :format => :json
          }.should raise_error
        end
        it "should not be deletable" do
          lambda {
            delete :destroy, :id => @other_user.events[0].id, :format => :json
          }.should raise_error
        end
      end
    end
  end
  
end
