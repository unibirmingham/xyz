class CardinalPlacementsController < ApplicationController

	def index
		@placements = CardinalPlacement.all
	end

	def edit
		@placement = CardinalPlacement.find(params[:id])
	end


end
