require 'spec_helper'


describe LocationDetails do
  before(:each) do
    LocationDetails.stub!(:get_details).and_return(location_data)
  end

  describe "in general" do
    it "shoud perform" do
      LocationDetails.should_receive(:perform).and_return(true)
      LocationDetails.perform(FactoryGirl.generate(:place_reference)).should eql true
    end

    it "should not perform" do
      lambda {
        LocationDetails.peform
      }.should raise_error
    end
  end

  describe "#perform" do
    it "should update location attributes" do
      lambda {
        LocationDetails.perform(location.reference)
        loc = Location.find_by_reference(location.reference)        
        loc.name.should eql "St Charles"
        loc.lat.should eql 38.7833333
        loc.lon.should eql -90.5166667
        loc.places_id.should eql "f16370e1b263acaca2e383e00155cef470e8737a"
      }.should_not raise_error
    end
  end

  def location
    @location ||= Location.create(:reference => FactoryGirl.generate(:place_reference))
  end

  def location_data
    @data ||= FactoryGirl.generate(:get_details_json)
  end
end
