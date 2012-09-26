class StaticPromotionsController < ApplicationController
  def index
		@promotions = StaticPromotion.all
  end

  def create
  end

  def new
  end

  def update
  end

  def edit
  end

	def destroy
	end
end
