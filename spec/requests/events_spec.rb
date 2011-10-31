require 'spec_helper'

describe "Events" do
  let(:event){ Event.create!(:name => "test event") }
  
  describe "json" do
    let(:json){ event.to_json }
    
    it "should include the ID" do
      json.should have_json_path("id")
      json.should have_json_type(Integer).at_path("id")
    end
    
  end
end