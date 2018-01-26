class Api::V1::StateCityController < ApplicationController

	def get_state
		states = CS.states(:in)
		state_array = []
		states.each do |k, v|
			state_json = Hash.new
			state_json[:state_key] = k
			state_json[:state_value] = v
			state_array << state_json
		end
		render json: { status: true, states: state_array }
	end

	def get_cities
		cities = CS.cities(params[:state], :in)
		render json: { status: true, cities: cities }
	end

end
