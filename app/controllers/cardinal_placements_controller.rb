class CardinalPlacementsController < ApplicationController
	before_filter :find_placement, :only => [:edit, :update]

	def index
		@placements = CardinalPlacement.all
	end

	def edit
	end

	def update
		@placement.dretitle = params[:title]
		@placement.qmsvalue1 = params[:url]
		@placement.qmsvalue2 = params[:position]
		@placement.qmsagentbool = params[:keywords]
		@placement.update

		redirect_to cardinal_placements_path
	end

	def new
		@placement = CardinalPlacement.new
	end

	def destroy
		CardinalPlacement.destroy(params[:id])
		redirect_to cardinal_placements_path 
	end

	def find_placement
		@placement = CardinalPlacement.find(params[:id])
	end

end
