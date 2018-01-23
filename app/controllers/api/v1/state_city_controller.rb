class Api::V1::StateCityController < ApplicationController

	def get_state
		states = CS.states(:in)
		render json: { status: true, states: states }
	end

	def get_cities
		cities = CS.cities(params[:state], :in)
		render json: { status: true, cities: cities }
	end

end
