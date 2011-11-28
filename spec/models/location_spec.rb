require 'spec_helper'

describe Location do
  before(:each) do
    @user = Factory(:user_with_events) 
    @event = @user.events[0]
  end
  
  it "should belong to a user" do
    lambda {
      @event.location = Location.create(:reference => FactoryGirl.generate(:place_reference))
      @location = @event.location
    }.should_not raise_error
    @location.event_id.should eql @event.id
    @location.user_id.should eql @user.id
  end

  describe "#from_places_hash" do
    before(:each) do
      @loc = Factory(:location)
    end

    it "should fail if no hash" do
      lambda {
        @loc.from_places_hash
      }.should raise_error
    end

    it "should not fail if empty hash" do
      lambda {
        @loc.from_places_hash({})
      }.should_not raise_error
    end

    it "should not fail with empty location" do
      lambda {
        @loc.from_places_hash({ :geometry => { "location" => "here"} })
      }.should_not raise_error
    end
  end
end
