class SynonymsController < ApplicationController
	before_filter :find, :only => [:edit, :update, :destroy]

  def index
		@synonyms = Synonym.all
  end

  def new
		@synonym = Synonym.new
  end

  def create
		@synonym = Synonym.new
		@synonym.update_attributes(params[:cardinal_placement])
		if @synonym.save
			flash[:info] = "#{@synonym.dretitle} successfully created"
		else
			flash[:error] = "Whoops! Something bad happened"
		end
  end

  def edit
  end

  def update
  end

  def destroy
  end

	def find
		@synonym = Synonym.find(params[:id])
	end
end
