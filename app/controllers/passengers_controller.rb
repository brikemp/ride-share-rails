class PassengersController < ApplicationController
  
  def index
    @passengers = Passenger.all
  end
  
  def show
    passenger_id = params[:id].to_i
    @passenger = Passenger.find_by(id: passenger_id)
    if @passenger.nil?
      redirect_to passengers_path
      return
    end
  end
  
  
  def create
    @passenger = Passenger.new( strong_params )
    if @passenger.save
      redirect_to passenger_path(@passenger.id)
    else
      render new_passenger_path
    end
  end
  
  def new
    @passenger = Passenger.new
  end
  
  def edit
    @passenger = Passenger.find_by(id: params[:id] )
    if @passenger.nil?
      redirect_to passengers_path
      return
    end
    
  end
  
  def update
    @passenger = Passenger.find_by(id: params[:id] )
    if @passenger.nil?
      redirect_to passengers_path
      return
    end
    if @passenger.update( strong_params )
      redirect_to passenger_path(@passenger.id)
    else
      render :edit
    end
  end
  
  def destroy
    passenger = Passenger.find_by( id: params[:id] )
    if passenger.nil?
      redirect_to passengers_path
      return
    else
      passenger.trips.each do |trip|
        trip.destroy
      end
      passenger.destroy
      redirect_to passengers_path
      return
    end
  end
  
  
  private
  
  def strong_params
    return params.require(:passenger).permit(:name, :phone_num)
  end
  
end
