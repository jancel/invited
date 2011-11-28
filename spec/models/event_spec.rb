require 'spec_helper'

describe Event do
  before(:each) do
    Resque.stub!(:enqueue).and_return(true)
  end
  describe "create" do
    it "should not error" do
      lambda {
        Event.create()
      }.should_not raise_error
    end
    
    it "should have new event" do
      lambda {
        Event.create()
      }.should change(Event, :count).by(1)
    end

    it "should accept location reference" do
      user = Factory(:user_with_events)
      event = user.events[0]
      reference =  FactoryGirl.generate(:place_reference)
      lambda {
        event.update_attributes(:location_attributes => { :reference =>reference} )
      }.should_not raise_error
      event.location.reference.should eql reference
    end
  end
  
end
