require 'spec_helper'

describe "Synonyms" do

	describe "GET /synonyms" do
		
		it "displays all the existing synonyms" do
			@synonym = stub_model(Synonym)
			@synonym.stub(:dretitle).and_return('Cakes')
			@synonym.stub(:id).and_return('12345')
			Synonym.should_receive(:all).and_return([@synonym])
			
			visit synonyms_path

			within('table') do
				page.should have_content 'Cakes'
			end

		end

	end

	describe "GET /synonyms/1/edit" do
		
		it "displays the fields for a synonym" do
			@synonym = stub_model(Synonym)
			
			@synonym.stub(:id).and_return "123"
			@synonym.stub(:dretitle).and_return "Fishes"
			@synonym.stub(:keywords).and_return "cod haddock plaice"
			@synonym.stub(:concept).and_return "cod haddock plaice"
			@synonym.stub(:qmsagentbool).and_return "fish OR sea OR food"

			Synonym.should_receive(:find).with("123").and_return(@synonym)

			visit edit_synonym_path @synonym.id

			page.should have_field('Title', :with => 'Fishes')
			page.should have_field('Keywords', :with => 'cod haddock plaice')
			page.should have_field('Concept', :with => 'cod haddock plaice')
			page.should have_field('Matching Expression', :with => 'fish OR sea OR food')


		end

	end
end
