require 'spec_helper'

class GooglePlacesTest
  include Google::Places

  attr_accessor :options
  def params
    ""
  end
end

describe Google::Places do
  describe "defaults" do
    it "should work with nothing passed in" do
      lambda {
        GooglePlacesTest.new
      }.should_not raise_error
    end

    it "should work inheriting properly" do
      lambda {
        GooglePlacesTest.new.url
      }.should_not raise_error
    end

    it "should not work without params defined" do
      class GooglePlacesTester
        include Google::Places
      end

      lambda {
        GooglePlacesTester.new.url
      }.should raise_error
    end

    it "should get type right" do
      GooglePlacesTest.new.type.should eql "test"
    end
  end

  describe "usage" do
   describe "#url" do
     before(:each) do
        @g ||= GooglePlacesTest.new
        @g.should_receive(:params).and_return("")
        @url = @g.url
      end
    it "should not be blank" do
      @url.should_not be_blank
    end
    it "should be eql to" do
      @url.should match /https:\/\/maps.googleapis.com\/maps\/ap/
    end
    it "should default to json" do
      @url.should match /json\?/
    end
   end

   describe "#type" do
     it "should equal test" do
       g = GooglePlacesTest.new
       g.type.should eql "test"
     end
   end

   describe "#get_data" do
     it "should raise error" do
       g = GooglePlacesTest.new
       lambda {
        g.get_data
       }.should raise_error
     end
    it "should not raise error" do
      g = GooglePlacesTest.new
      g.should_receive(:get_data).and_return true
      g.get_data.should eql true
    end
   end

   describe "#params" do
     it "should raise error" do
       g = GooglePlacesTest.new
       lambda {
        g.params
       }.should_not raise_error
     end
    it "should not raise error" do
      g = GooglePlacesTest.new
      g.should_receive(:params).and_return ""
      g.params.should eql ""
    end
   end
  
   describe "#location_from_lat_lon" do
     it "should compress two digits with comma" do
      g = GooglePlacesTest.new
      g.location_from_lat_lon(123, 321).should eql "123,321"
     end
     it "should work with strings" do
      g = GooglePlacesTest.new
      g.location_from_lat_lon("123", "321").should eql "123,321"
     end
   end

   describe "#set_location" do
    before(:each) do
      @g = GooglePlacesTest.new
    end

    it "should error" do
      lambda {
        @g.set_location
      }.should raise_error
    end
    it "should error" do
      lambda {
        @g.set_location(:locatin => "192.2.1,12345")
      }.should raise_error
    end
    it "should error" do
      lambda {
        @g.set_location(:lon => "192,192.1.2")
      }.should raise_error
    end
    it "should error" do
      lambda {
        @g.set_location(:lat => "123,123,133")
      }.should raise_error
    end
    it "should work" do
      lambda {
        @g.set_location(:location => "123,321")
      }.should_not raise_error
    end
    it "should work" do
      lambda {
        @g.set_location(:lon => "123", :lat => "321")
      }.should_not raise_error
    end
   end

   describe "#format" do
    it "should accept json" do
      g = GooglePlacesTest.new(:format => :json)
      g.url.should match /json\?/  
    end
    it "should accept xml" do
      g = GooglePlacesTest.new(:format => :xml)
      g.url.should match /xml\?/
    end
  end

   describe "#set_language" do
     it "should properly set language" do
       GooglePlacesTest.new(:language => "EN").options[:language].should eql "EN"
     end
   end

  end


end
