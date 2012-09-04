class CardinalPlacementsController < ApplicationController
	before_filter :find_placement, :only => [:edit, :update]
	before_filter :create_placement, :only => [:create, :new]
	
	def index
		@placements = CardinalPlacement.all
	end

	def edit
	end

	def update
		update_placement
		if @placement.update
			flash[:info] = "#{@placement.dretitle} updated successfully"
		else
			flash[:error] = "Whoops! Something bad happened"
		end
		redirect_to cardinal_placements_path
	end

	def new
	end

	def create
		update_placement
		@placement.save

		redirect_to cardinal_placements_path
	end

	def destroy
		CardinalPlacement.destroy(params[:id])
		redirect_to cardinal_placements_path 
	end

	private 

	def find_placement
		@placement = CardinalPlacement.find(params[:id])
	end

	def create_placement
		@placement = CardinalPlacement.new
	end

	def update_placement	
		@placement.dretitle = params[:title]
		@placement.qmsvalue1 = params[:url]
		@placement.qmsvalue2 = params[:position]
		@placement.qmsagentbool = params[:keywords]
		@placement.alwaysactive = params[:always_active] == "yes" ? "TRUE" : "FALSE"
	end
end
