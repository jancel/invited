require 'spec_helper'

describe GooglePlacesSearch do
  it "should have API_KEY" do
    lambda {
      Google::Places::API_KEY.should_not be_nil
    }.should_not raise_error
  end
  it "should be instantiable" do
    g = nil
    lambda {
      g = GooglePlacesSearch.new({:location => "1234,312"})
    }.should_not raise_error
  end
  it "should not require sensor value" do
    lambda {
      g = GooglePlacesSearch.new({:location => "123,321"})
    }.should_not raise_error
  end
  it "should require location" do
    lambda {
      g = GooglePlacesSearch.new({})
    }.should raise_error
    lambda {
      g = GooglePlacesSearch.new({:location => "123,321"})
    }.should_not raise_error
  end
  it "should fail if location isnt formatted properly" do
    lambda {
      GooglePlacesSearch.new({:location => "1,2.3.2"})
    }.should raise_error
  end
  it "should be valid for 1,1" do
    lambda {
      GooglePlacesSearch.new({:location => "1,1"})
    }.should_not raise_error
  end
  it "should accept location" do
    GooglePlacesSearch.new(:location => "1,1").location.should eql "1,1"
  end
  it "should accept lat,lon" do
    GooglePlacesSearch.new(:lat => 1, :lon => "2.1").location.should eql "1,2.1"
  end
  it "should accept sensor" do
    GooglePlacesSearch.new(:location => "1,1", :sensor => false).sensor.should eql false
    GooglePlacesSearch.new(:location => "1,1", :sensor => true).sensor.should eql true
    GooglePlacesSearch.new(:location => "1,1", :sensor => "true").sensor.should eql true
  end

  describe "url" do
    it "should build params properly" do
     GooglePlacesSearch.new(:location => "1,1").params.should eql "location=1,1&radius=4.02336"
    end
    it "should be a good url" do
      GooglePlacesSearch.new(:location => "1,1").url.should eql "https://maps.googleapis.com/maps/api/place/search/json?location=1,1&radius=4.02336&key=AIzaSyD9o7rTS8GW9N5NIamcaqYmTl9y9g4WxA0&sensor=false"
    end
  end

end
