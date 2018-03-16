class Api::V1::VehiclesController < ApiController
  before_action :set_vehicle, only: %i(show edit update destroy)

  # GET /vehicles
  # GET /vehicles.json
  def index
    @vehicles = Vehicle.all
  end

  # GET /vehicles/1
  # GET /vehicles/1.json
  def show
    bus_stations = @vehicle.bus_stations.order(sequence: :asc)
    stations = bus_stations.map{ |bus_station| bus_station.as_json.merge({
      name: bus_station.station.name
    })}
    render json: {status: true, stations: stations}
  end

  # GET /vehicles/1/edit
  def edit; end

  # POST /vehicles
  # POST /vehicles.json
  def create
    vehicle = Vehicle.new(vehicle_params)
    begin
      if vehicle.save!
        render json: { status: true, vehile: vehicle }
      end
    rescue => error
      render json: { status: false, message: error }
    end
  end


  # PATCH/PUT /vehicles/1
  # PATCH/PUT /vehicles/1.json
  def update
    begin
      if @vehicle.update!(vehicle_params)
        render json: { status: true, vehicle: @vehicle }
      end
    rescue => error
      render json: { status: false, message: error }
    end
  end

  # DELETE /vehicles/1
  # DELETE /vehicles/1.json
  def destroy
    @vehicle.destroy
    render json: { status: true }
  end

  def search_vehicle
    destination_station = Station.find_by(name: vehicle_params[:destination])
    source_station = Station.find_by(name: vehicle_params[:source])
    source_vehicles =  Vehicle.includes([:bus_stations, :stations]).where(
      stations: { name: vehicle_params[:source] }
      )
    destination_vehicles =  Vehicle.includes([:bus_stations, :stations]).where(
      stations: { name: vehicle_params[:destination] }
      )
    available_vehicle = source_vehicles & destination_vehicles
    available_vehicle = available_vehicle.select {
     |vehicle| vehicle.bus_stations.find_by(station_id: source_station.id).
     sequence < vehicle.bus_stations.find_by(station_id: destination_station.id).sequence
   }

    available_vehicle = available_vehicle.map{ |vehicle| vehicle.as_json.merge({
          arrival_time: vehicle.bus_stations.find_by(station_id: source_station.id).arrival_time,
          departure_time: vehicle.bus_stations.find_by(station_id: source_station.id).departure_time,
          source_price: vehicle.bus_stations.find_by(station_id: source_station.id).price,
          destination_price: vehicle.bus_stations.find_by(station_id: destination_station.id).price,
          source_duration: vehicle.bus_stations.find_by(station_id: source_station.id).duration,
          destination_duration: vehicle.bus_stations.find_by(station_id: destination_station.id).duration
        })}
    render json: { status: true, vehicles: available_vehicle }
   end

   def get_stations
    stations = Station.all.order(id: :desc)
    render json: {status: true, stations: stations}
   end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def vehicle_params
    params.permit(:model_no, :registration_no, :vehicle_type, :vehicle_number,
     :name, :source, :destination)
  end
end
