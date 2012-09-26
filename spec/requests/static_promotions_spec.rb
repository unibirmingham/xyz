require 'spec_helper'

describe "Static Promotions" do
	
		describe "GET /promotions" do
				
			it "lists all the promotions" do
				@promotion = FactoryGirl.build(:static_promotion)
				StaticPromotion.should_receive(:all).and_return([@promotion])

				visit static_promotions_path

				within 'table' do
					page.should have_content "Static Promotion 1"
					within 'tbody tr:first-child td:nth-child(2)' do
						page.should have_content "Static"
					end
				end



			end


		end

end
