class SynonymsController < ApplicationController

  def index
		@synonyms = Synonym.all
  end

  def new
		@synonym = Synonym.new
  end

  def create
		@synonym = Synonym.new
		@synonym.update_attributes(params[:synonym])
		if @synonym.save
			flash[:info] = "#{@synonym.dretitle} successfully created"
			redirect_to synonyms_path
		else
			flash[:error] = "Whoops! Something bad happened"
			render :new
		end
  end

  def edit
		@synonym = Synonym.find(params[:id])
  end

  def update
		@synonym = Synonym.find(params[:drereference])
		@synonym.update_attributes(params[:synonym])
		if @synonym.save
			flash[:info] = "#{@synonym.dretitle} successfully created"
			redirect_to synonyms_path
		else
			flash[:error] = "Whoops! Something bad happened"
			render :edit
		end
  end

  def destroy
		Synonym.destroy(params[:id])
		flash[:info] = "Synonym successfully deleted"
		sleep 1 
		redirect_to synonyms_path 
  end

end
