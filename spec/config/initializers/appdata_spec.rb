require 'spec_helper' 

describe 'AppData' do
	
	it 'adds methods and their values to itself when initialised' do
		AppData.config 	do
			parameter url:"147.188.128.215"
			parameter port:12345
			parameter path:"/DREADDDATA"
		end

		AppData.url.should eql "147.188.128.215"
		AppData.port.should eql 12345
		AppData.path.should eql "/DREADDDATA"
	end
end
