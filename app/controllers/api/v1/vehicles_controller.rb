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
  end

  # GET /vehicles/1/edit
  def edit
  end

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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def vehicle_params
    params.permit(:model_no, :registration_no, :vehicle_type, :vehicle_number,
     :name)
  end
end
