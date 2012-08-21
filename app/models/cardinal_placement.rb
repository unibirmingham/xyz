class CardinalPlacement
	require 'net/http'
	require 'xmlsimple'

	def self.all
		url = 'http://147.188.128.215:10150/action=Query&databasematch=activated&print=all&maxresults=5000&fieldtext=MATCH%7B1%7D%3AQMSTYPE&Text=*'
		response = Net::HTTP.get_response(URI.parse(url))
		xml_data = response.body

		data = XmlSimple.xml_in(xml_data)
		cardinals = []

		data['responsedata'][0]['hit'].each do |hit|
			cardinals << hit
		end
	end
	
end
