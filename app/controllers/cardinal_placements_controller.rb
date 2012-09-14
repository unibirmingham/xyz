class CardinalPlacementsController < ApplicationController
	before_filter :create_placement, :only => [:create, :new]

	def index
		@placements = CardinalPlacement.all
	end

	def edit
		@placement = CardinalPlacement.find(params[:id])
	end

	def update
		@placement = CardinalPlacement.find(params[:drereference])
		@placement.update_attributes(params[:cardinal_placement])
		if @placement.save
			flash[:info] = "#{@placement.dretitle} successfully updated"
		else
			flash[:error] = "Whoops! Something bad happened. Speak to Nick"
		end

		sleep(0.5)
		redirect_to cardinal_placements_path
	end

	def new
	end

	def create
		@placement.update_attributes(params[:cardinal_placement])
		if @placement.save
			flash[:info] = "#{@placement.dretitle} successfully created"
		else
			flash[:error] = "Whoops! Something bad happened"
		end

		sleep(0.5)
		redirect_to cardinal_placements_path
	end

	def destroy
		CardinalPlacement.destroy(params[:id])
		flash[:info] = "Placement successfully deleted"
		sleep 1 
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
