require 'spec_helper'

describe GooglePlacesSearch do
  it "should require location" do
    lambda {
      g = GooglePlacesSearch.new
    }.should raise_error
  end
  it "should require location" do
    lambda {
      g = GooglePlacesSearch.new(:location => "123,321")
    }.should_not raise_error
  end
  it "should load proper params" do
    lambda {
      g = GooglePlacesSearch.new(:location => "123,321")
      g.params.should match /location=123\,321\&radius=/
    }.should_not raise_error
  end
  it "should fetch json from google" do
    options = { :lat => "38.780348", :lon => "-90.563662" }
    lambda {
      g = GooglePlacesSearch.new(options)
    }.should_not raise_error
    end

  it "should handle optional params" do
    params = {:language => "EN", :location => "123,321", :keyword => "test", :name => "Hello", :types => "one|two"}
    g = GooglePlacesSearch.new(params)
    g.url.should match "test"
    g.url.should match "EN"
    g.url.should match "keyword"
    g.url.should match "Hello"
    g.url.should match "one|two"
  end

  it "should complete types request" do
    params = {:location => "38,-90",:types => "restaurant|bar"}
    g = GooglePlacesSearch.new(params)
    g.should_receive(:get_data).and_return(FactoryGirl.generate(:get_places_json))
    lambda {
      g.get_data
    }.should_not raise_error
  end

  describe "#get_data" do
    it "should fetch json from google" do
      options = { :lat => "38.780348", :lon => "-90.563662" }
      g = GooglePlacesSearch.new(options)
      g.should_receive(:get_data).and_return(FactoryGirl.generate(:get_places_json))
      lambda {
        data = g.get_data
        data.should have_json_path("html_attributions")
        data.should have_json_path("results")
      }.should_not raise_error
    end
    it "should attempt to call google places" do
      options = { :lat => "38.780348", :lon => "-90.563662" }
      g = GooglePlacesSearch.new(options)
      lambda {
        no_web {
          data = g.get_data
        }
      }.should raise_error
    end
  end
end
