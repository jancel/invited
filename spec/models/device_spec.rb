require 'spec_helper'

describe Device do
  describe "validations" do
    it "should work when user assigned" do
      lambda {
        user = Factory(:user)
        user.devices << Device.create(:dev_id => FactoryGirl.generate(:device_identifier))
        user.devices.count.should eql 1
      }.should change(Device, :count).by(1)
    end
    
    it "should not be missing identifier" do
      user = Factory(:user)
      lambda {
        device = Device.create(:user_id => user.id, :activated => true)
        device.valid?.should be false
        device.save!
      }.should(raise_error)
    end
    
    it "should work when all is well" do
      lambda {
        user = Factory(:user)
        device = Device.create(:dev_id => FactoryGirl.generate(:device_identifier), :user_id => user.id, :activated => true)
        device.valid?.should be true
      }.should change(Device, :count).by(1)
    end
    
    it "should only have one active device" do
      lambda {
        subscribe_several_users
      }.should_not raise_error
    end
  end
  
  describe "callbacks" do
    it "find and deactivate all devices before save" do
      subscribe_several_users
    end
  end
  
  
  def subscribe_several_users
    user1 = Factory(:user)
    user2 = Factory(:user)
    device_id = FactoryGirl.generate(:device_identifier)
    user1.devices << Device.create(:dev_id => device_id, :activated => true)
    user1.save
    user1.devices.count.should eql 1
    #In the future when this hapens, we will want to send
    # an email to the original registrar to remove device from
    # their unit
    Device.find_all_by_dev_id_and_activated(device_id, true).count.should eql 1
    user2.devices << Device.create(:dev_id => device_id, :activated => true)
    user2.save
    user2.devices.count.should eql 0
    Device.find_all_by_dev_id_and_activated(device_id, true).count.should eql 1
    Device.find_all_by_user_id_and_dev_id(user2.id, true).count.should eql 0
  end
end
