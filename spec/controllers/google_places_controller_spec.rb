require 'spec_helper'

describe GooglePlacesController do
  describe "#search" do
    before(:each) do
      GooglePlacesSearch.any_instance.should_receive(:get_data).any_number_of_times.and_return(FactoryGirl.generate(:get_places_json))
    end
    it "should not accept blank get" do
      lambda {
        get :search, :format => :json
      }.should raise_error
    end
    it "should accept get" do
      lambda {
        get :search, :location => location, :format => :json
      }.should_not raise_error
    end
    it "should return json" do
      get :search, :location => location, :format => :json
      response.should be_success
      response.body.should have_json_path("status")
    end
    it "should accept formats" do
      get :search, :format => :xml, :location => location, :format => :json
      response.should be_success
    end
    it "should accept location" do
      get :search, :location => location, :format => :json
      response.should be_success
    end
    it "should accept lat/lon" do
      get :search, lat_lon
      response.should be_success
    end
    it "should accept radius" do
      get :search, :location => location, :radius => 10, :format => :json
      response.should be_success
    end
    it "should accept sensor" do
      get :search, :location => location, :sensor => true, :format => :json
      response.should be_success
    end
  end
  describe "#details" do
    before(:each) do
      GooglePlacesDetails.any_instance.should_receive(:get_data).any_number_of_times.and_return(FactoryGirl.generate(:get_details_json))
    end
    
    it "should accept get" do
      lambda {
        get :details, :reference => details_reference , :format => :json
      }.should_not raise_error
    end
    it "should require reference" do
      lambda {
        get :details, :format => :json
      }.should raise_error
    end
  end

  def details_reference
    @details_reference ||= "details_reference_key"
  end

  def location
    @location ||= FactoryGirl.generate(:location)
  end
  
  def lat_lon
    vals = location.split(",")
    @lat_lon ||= { :lat => vals[0], :lon => vals[1], :format => :json }
  end
end
