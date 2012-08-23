class CardinalPlacementsController < ApplicationController

	def index
		@placements = CardinalPlacement.all
	end

	def edit
		@placement = CardinalPlacement.find(params[:id])
	end

	def new
		@placement = CardinalPlacement.new
	end

	def destroy
		CardinalPlacement.destroy(params[:id])
		redirect_to cardinal_placements_path 
	end

end
