class EventsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :xml, :json
  
  def index
    respond_with(@events = current_user.events.all)
  end

  def new
    respond_with(@event = Event.new)
  end

  def show
    respond_with(@event ||= current_user.events.find(params[:id]))
  end
  
  def create
    @event = current_user.events.create(params[:event])
    respond_with(@event)
  end
  
  def update
    @event = current_user.events.find params[:id]
    @event.update_attributes(params[:event])
    respond_with(@event)
  end

  def edit
    respond_with(@event = current_user.events.find(params[:id]))
  end

  def destroy
    @event = current_user.events.find(params[:id]).destroy
    respond_with(@event)
  end
end
