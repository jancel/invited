require "spec_helper"

describe ApplicationController do
  it 'should auth' do
    lambda {
      auth
    }.should_not raise_error
  end
  
  describe "other authentication" do
    it 'should auth device' do
      1.should eql 2
    end
  end
end