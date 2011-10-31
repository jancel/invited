require 'spec_helper'

describe EventsController do
  
  before(:each) do
    auth
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
        @event = mock_model(Event)
        Event.stub!(:find).and_return(@event)
        @event.stub!(:update_attributes).and_return(true)
      end
      
      it "should call find method" do
        Event.should_receive(:find).with("#{@event.id}").and_return(@event)
        put :update, :id => @event, :event => {}
      end
      
      it "should update attributes" do
        @event.should_receive(:update_attributes).and_return(true)
        put :update, :id => @event, :event => {}
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
        post :create, :event => {}
      end
      
      it "should redirect response" do
        post :create, :event => {} 
        response.should be_redirect
      end
    end
  end
  
end
