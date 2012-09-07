require 'spec_helper'

describe CardinalPlacement do

	describe "destroy" do
		it "sends the delete doc command to IDOL" do
			@response = double('response')
			@response.stub(:code).and_return(200)
			Net::HTTP.should_receive(:get_response).with(URI.parse("http://147.188.128.215:10151/DREDELETEDOC?docs=12345")).and_return(@response)

			CardinalPlacement.destroy(12345)			
		end
	end

end
