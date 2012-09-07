require 'spec_helper'

describe 'cardinal placements' do

	describe 'GET /cardinal_placements' do

		before :each do
			@placement = mock_model(CardinalPlacement)
			@placement.stub(:title).and_return("2012 Prospectus")
			@placement.stub(:qmsvalue1).and_return("http://www.birmingham.ac.uk/first_document.aspx")
			@placement.stub(:id).and_return("12345")
			CardinalPlacement.should_receive(:all).any_number_of_times.and_return([@placement])
		end

		it 'displays all the cardinal placements data' do
			visit cardinal_placements_path
			within 'table' do
				page.should have_content "2012 Prospectus"
				page.should have_content "http://www.birmingham.ac.uk/first_document.aspx"
			end
		end

		it "destroys the cardinal_placement in IDOL" do
			CardinalPlacement.should_receive(:destroy).with("12345")
			visit cardinal_placements_path
			click_link 'delete'
			current_path.should eql cardinal_placements_path
		end

	end

	describe 'GET /cardinal_placements/1/edit' do

		before :each do
			@placement = mock_model CardinalPlacement 
			@placement.stub(:dretitle).and_return("2012 Prospectus")
			@placement.stub(:qmsvalue1).and_return("http://www.birmingham.ac.uk/first_document.aspx")
			@placement.stub(:id).and_return("12345")
			@placement.stub(:qmsvalue2).and_return("3")
			@placement.stub(:alwaysactive).and_return("true")
			@placement.stub(:qmsagentbool).and_return("dave AND the AND fish")	
			CardinalPlacement.should_receive(:find).any_number_of_times.and_return(@placement)
		end

		it "shows the form with the current info pre-populated" do
			visit edit_cardinal_placement_path(@placement)
			
			within 'form' do
				page.should have_field("Title", :with => "2012 Prospectus")
				page.should have_field("URL", :with => "http://www.birmingham.ac.uk/first_document.aspx")
				page.should have_checked_field("cardinal_placement_alwaysactive_yes")
				page.should have_unchecked_field("cardinal_placement_alwaysactive_no")
				page.should have_field("Position", :type => 'number', :with => "3")
				page.should have_field("Keywords", :with => "dave AND the AND fish")
			end
		end

		it "updates the placement" do
			visit edit_cardinal_placement_path(@placement.id)

			fill_in 'Title', :with => "2013 Prospectus"
			fill_in 'URL', :with => "http://www.birmingham.ac.uk/document.aspx"
			fill_in 'Position', :with => "6"
			fill_in 'Keywords', :with => "dave AND the AND fish"
			choose 'Yes'

			@placement.stub(:dretitle).and_return("2013 Prospectus")
			@placement.should_receive(:update_attributes)
			@placement.should_receive(:save).and_return(true)

			click_button 'Update Cardinal placement'

			current_path.should eql cardinal_placements_path
			page.should have_content "2013 Prospectus successfully updated"
		end
	end

end
