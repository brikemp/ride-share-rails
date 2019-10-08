class PassengersController < ApplicationController
  
  def index
    @passengers = Passenger.all
  end
  
  def show
    passenger_id = params[:id].to_i
    @passenger = Passenger.find_by(id: passenger_id)
    if @passenger.nil?
      redirect_to root_path
      return
    end
    total_charges = @passenger.trips.map {|t| t.cost }
    @total_charges = total_charges.sum
  end
  
  
  def create
    @passenger = Passenger.new( strongs_params )
    if @passenger.save
      redirect_to passenger_path(@passenger.id)
    else
      render new_passenger_path
    end
  end
  
  
  def new
    @passenger = Passenger.new
  end
  
  
  def destroy
    passenger = Passenger.find_by( id: params[:id] )
    if passenger.nil?
      redirect_to passengers_path
      return
    else
      passenger.destroy
      redirect_to passengers_path
      return
    end
  end
  
  
  private
  
  def strongs_params
    return params.require(:passenger).permit(:name, :phone_num)
  end
  
end
