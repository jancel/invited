require 'spec_helper'

describe Event do
  
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
  end
  
end
