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
      g.params.should eql "location=123,321&radius=4.02336"
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
    # g.url.should eql "https://maps.googleapis.com/maps/api/place/search/json?location=123,321&radius=4.02336&keyword=test&name=Hello&types=one|two&language=EN&key=AIzaSyD9o7rTS8GW9N5NIamcaqYmTl9y9g4WxA0&sensor=false"
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


# {
#    "html_attributions" : [],
#    "results" : [
#       {
#          "geometry" : {
#             "location" : {
#                "lat" : 38.7817320,
#                "lng" : -90.56380930
#             }
#          },
#          "icon" : "http://maps.gstatic.com/mapfiles/place_api/icons/geocode-71.png",
#          "id" : "e158a87b638d396c9236ff0c658ae7d6d12b3a6a",
#          "name" : "Whetstone Dr",
#          "reference" : "CnRtAAAA2twcFbBmnQucS8zWLRmQ3No0bdsff8JMuzfhUQ5Z_gNrnFGzmeFoT4VELlxCQgDFkzwBuLkLLc-G-9np4Gj_p_oZhnF0xZI1m22-Vcif3k53E1R18A1wGGtX2EES6mUScZXlBGoFdP5UW1P30tkvfRIQCyM7yvYjSVTuyDqMDG0beRoU4Nkl74uNIegqdTGd4F_j05cJp8g",
#          "types" : [ "route" ],
#          "vicinity" : "St Charles"
#       },
#       {
#          "geometry" : {
#             "location" : {
#                "lat" : 38.78333330,
#                "lng" : -90.51666670
#             }
#          },
#          "icon" : "http://maps.gstatic.com/mapfiles/place_api/icons/geocode-71.png",
#          "id" : "f16370e1b263acaca2e383e00155cef470e8737a",
#          "name" : "St Charles",
#          "reference" : "CnRrAAAA2q5G-HH1gpoX0-4h-3goV928FQ8ibC36AlOXEpoQt6-vOB9YTGE92i0m94tV3Turv7ah8F9-n-2DysK28BYNi8jsBomMyIszJ5SgrORIxUs8y4CSKk3ejS3AwcEMY_wPi1u7vrog_6DwbQB4sCPn6xIQZd3_nQ4mlb8pIBNz3UG1tBoUzD0kROiQB8oFB0PjD2WWnaQMIDg",
#          "types" : [ "locality", "political" ],
#          "vicinity" : "St Charles"
#       }
#    ],
#    "status" : "OK"
# }
