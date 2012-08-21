require 'spec_helper'

describe 'cardinal placements' do

	describe 'GET /cardinal_placements' do
		it 'displays all the cardinal placements' do
				placement = double("placement")
				placement.stub(:title).and_return("2012 Prospectus")
				placement.stub(:url).and_return("http://www.birmingham.ac.uk/first_document.aspx")

				CardinalPlacement.should_receive(:all).and_return([placement]) 
				visit cardinal_placements_path
				within 'table' do
					page.should have_content "2012 Prospectus"
					page.should have_content "http://www.birmingham.ac.uk/first_document.aspx"
				end
		end
	end

end
