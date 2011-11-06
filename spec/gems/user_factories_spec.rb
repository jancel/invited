describe "FactoryGirl" do
  it "should properly init user" do
    user = Factory(:user)
    user.email.should_not be_blank
    user.terms.should == true
    user.password.should eql "whatevs"
  end
end