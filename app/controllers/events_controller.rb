class EventsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :xml, :json
  
  def index
    respond_with(@events = Event.all)
  end

  def new
    respond_with(@event = Event.new)
  end

  def show
    respond_with(@event ||= Event.find(params[:id]))
  end
  
  def create
    @event = Event.new(params[:event])
    @event.save
    respond_with(@event)
  end
  
  def update
    @event = Event.find params[:id]
    @event.update_attributes(params[:event])
    respond_with(@event)
  end

  def edit
    respond_with(@event = Event.find(params[:id]))
  end

end
