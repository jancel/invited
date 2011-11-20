require 'spec_helper'

describe GooglePlacesDetails do
  it "should require fields" do
    lambda {
      g = GooglePlacesDetails.new({})
    }.should raise_error
  end
  it "should require reference" do
    lambda {
      g = GooglePlacesDetails.new(:reference => "test_reference")
    }.should_not raise_error
  end
  it "should load proper params" do
    lambda {
      g = GooglePlacesDetails.new(:reference => "test_reference")
      g.params.should eql "reference=test_reference"
    }.should_not raise_error
  end
  it "should fetch json from google" do
    options = { :reference => "test_reference" }
    lambda {
      g = GooglePlacesDetails.new(options)
    }.should_not raise_error
  end

  it "should handle optional params" do
    params = {:language => "EN", :reference => "test_reference"}
    g = GooglePlacesDetails.new(params)
    g.url.should match "EN"
    g.url.should match "test_reference"
    # g.url.should eql "https://maps.googleapis.com/maps/api/place/search/json?location=123,321&radius=4.02336&keyword=test&name=Hello&types=one|two&language=EN&key=AIzaSyD9o7rTS8GW9N5NIamcaqYmTl9y9g4WxA0&sensor=false"
  end

  describe "#get_data" do
    it "should fetch json from google" do
      options = { :reference => "CnRqAAAAG04GO9yJ8TNFVFR6h2MT61FFyr6TYlqWXIxGqzXHNbJsqa2eTWzB-K03N5znaF7duHfGy0orhKtHn_nb58ZYN5suFEmr446qG-lwEElvjVTxQjia2fzo58x5ywDpgfMlxEHVhsVHz1ROa0K8SOaGJBIQgukAGSzUPrAbH9vhSWFstBoUWsLBWP1rHUVeDpgjjml5f7L7obc" }
      g = GooglePlacesDetails.new(options)
      # FakeWeb.allow_net_connect = true
      # Should there be major issues, and you need to debug the actual request, 
      # comment out the mock method below.
      g.should_receive(:get_data).and_return(FactoryGirl.generate(:get_details_json))
      lambda {
        data = g.get_data
        data.should have_json_path("html_attributions")
        data.should have_json_path("result")
        data.should have_json_path("status")
      }.should_not raise_error
    end
    it "should attempt to call google places" do
      options = { :reference => "test_reference" }
      g = GooglePlacesDetails.new(options)
      
      lambda {
        no_web {
          data = g.get_data
        }
      }.should raise_error
    end
  end
end

