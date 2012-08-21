class CardinalPlacementsController < ApplicationController

	def index
		@placements = CardinalPlacement.all
		true
	end


end
