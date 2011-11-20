class GooglePlacesController < ApplicationController
  respond_to :json, :xml

  def search
    g = GooglePlacesSearch.new(params)
    respond_to do |format|
      format.json { render :json => g.get_data }
      format.xml { render :xml => g.get_data }
    end
  end

  def details
    g = GooglePlacesDetails.new(params)
    respond_to do |format|
      format.json { render :json => g.get_data }
      format.xml { render :xml => g.get_data }
    end
  end
end
