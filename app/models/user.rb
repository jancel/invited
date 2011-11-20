class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, 
                  :remember_me, :token, :devices, :terms, :app_token
  
  has_many :devices, :dependent => :destroy
  accepts_nested_attributes_for :devices
  
  has_many :events, :dependent => :destroy
  accepts_nested_attributes_for :events

  validates :terms, :acceptance => {:accept => true}
  
  after_validation :generate_app_token
  def generate_app_token
    self.app_token ||= Digest::MD5.hexdigest(self.email + Time.now.to_s)
  end
  
  # Class methods
  class << self 
    
    def email_exists?(email_address)
      !User.find_by_email(email_address).nil?
    end
    
    def create_by_device(device_id, terms, email)
      require 'digest/sha2'
      
      #create the user
      app_token = Digest::MD5.hexdigest(device_id)
      create(
        :password => app_token,
        :email => email,
        :terms => terms,
        :devices => [Device.create(:dev_id => device_id, :activated => true)]
      )
      
    end
    
    def authenticate_by_app_token_and_device_identifier(app_token, device_identifier)
      user = find_by_app_token(app_token)
      if user.devices.find_by_dev_id_and_activated(device_identifier, true)
        return user
      end
      nil
    end
  end
  
  def to_xml(options={})
    options.merge!(:except => [:email, :terms])
    super(options)
  end
  
  def as_json(options={})
    options.merge!(:except => [:email, :terms])
    super(options)
  end
end
