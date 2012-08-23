require 'spec_helper'

describe 'cardinal placements' do

	describe 'GET /cardinal_placements' do

		before :each do
			@placement = double("placement")
			@placement.stub(:title).and_return("2012 Prospectus")
			@placement.stub(:qmsvalue1).and_return("http://www.birmingham.ac.uk/first_document.aspx")
			@placement.stub(:drereference).and_return("12345")
			CardinalPlacement.should_receive(:all).and_return([@placement]) 
		end

		it 'displays all the cardinal placements data' do
			visit cardinal_placements_path
			within 'table' do
				page.should have_content "2012 Prospectus"
				page.should have_content "http://www.birmingham.ac.uk/first_document.aspx"
			end
		end
	end

	describe 'GET /cardinal_placements/1/edit' do
		it "shows the form with the current info pre-populated" do
			@placement = double 'placement'
			@placement.stub(:title).and_return("2012 Prospectus")
			@placement.stub(:qmsvalue1).and_return("http://www.birmingham.ac.uk/first_document.aspx")
			@placement.stub(:id).and_return("12345")
			@placement.stub(:qmsvalue2).and_return("3")
			@placement.stub(:alwaysactive).and_return("TRUE")
			@placement.stub(:qmsagentbool).and_return("dave AND the AND fish")
			CardinalPlacement.should_receive(:find).and_return(@placement)

			visit edit_cardinal_placement_path(@placement)
			
			within 'form' do
				page.should have_field("Title")
				page.should have_field("URL")
				page.should have_checked_field("always_active_yes")
				page.should have_unchecked_field("always_active_no")
				page.should have_field("Position", :type => 'number')
			end
		end
	end

end
