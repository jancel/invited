class SessionsController < ApplicationController
  attr :errors
  respond_to :xml, :json
  
  before_filter :authenticate_user!, :only => :device_session
  
  def device_session
    if signed_in?
      respond_to do |f|
        f.json { render :json => {"Success" => true} }
        f.xml { render :xml =>  {"Success" => true} }
      end
    else
      respond_to do |f|
        f.json { render :json => {"Failed" => false} }
        f.xml { render :xml => {"Failed" => false} }
      end
    end
  end
  
  def device_activation
    errors = [:device_id, :email, :terms].map { | arg | params[arg.to_s].blank? ? "#{arg.to_s} is a required field" : nil }.compact

    # user accepted terms?
    errors << ["User must accept terms to use this application"] if params["terms"].blank?
    
    if !errors.blank?
      respond_to do |format|
        format.json { render :json => {:errors => errors} }
        format.xml { render :xml => {:errors => errors} }
      end and return
    end
    
    
    email = params["email"]
    device = params["device_id"]
    terms = params["terms"]
    # if User.email_exists?(email)
      # add device to user route
      # give user one hour to activate device
      # when we get closer to supporting multiple
      # devices, we will need to implement this
    # else
      # add new user route
      @user = User.create_by_device(device, terms, email)
    # end
    
    if @user.save
      sign_in User, @user
      respond_to do |format|
        format.json { render :json => { :user => @user }}
        format.xml { render :json => { :user => @user }}
      end
    else
      respond_to do |format|
        format.json { render :json => { :errors => @user.errors, :status => "Unprocessible entry" }}
        format.xml { render :json => { :errors => @user.errors, :status => "Unprocessible entry" }}
      end
    end
  end
  
end 