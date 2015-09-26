class ItinerariesController < ApplicationController
  before_action :authenticate_user!

  def index
    @itineraries = current_user.itineraries
  end

  def new
    @itinerary = Itinerary.new
  end

  def create
    @itinerary = current_user.itineraries.build itinerary_safe_params
    if @itinerary.save
      redirect_to itineraries_path
    else
      flash_first_error(@itinerary)
      render "new"
    end
  end

  def show
    @itinerary = current_user.itineraries.find params[:id]
  end

  private

  def itinerary_safe_params
    params.require(:itinerary).permit(:start_date, :end_date, :city, :country)
  end

end