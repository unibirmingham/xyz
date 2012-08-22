class CardinalPlacement
	require 'net/http'
	require 'xmlsimple'

	def initialize(attributes={})
		@attributes = attributes 
		attributes.each do |key,val|
			add_accessor_and_value(key, val)
		end
		if !attributes['content'].nil? && !attributes['content']['DOCUMENT'].nil?
			attributes['content']['DOCUMENT'][0].each do |key,val|
				add_accessor_and_value(key,val)
			end
		end
	end

	def self.all
		url = 'http://147.188.128.215:10150/action=Query&databasematch=activated&print=all&maxresults=5000&fieldtext=MATCH%7B1%7D%3AQMSTYPE&Text=*'
		response = Net::HTTP.get_response(URI.parse(url))
		xml_data = response.body

		data = XmlSimple.xml_in(xml_data)
		cardinals = []

		data['responsedata'][0]['hit'].each do |hit|
			cardinals << CardinalPlacement.new(hit) 
		end
		cardinals
	end

	def self.find(drereference)
		url = "http://147.188.128.215:10150/action=Query&databasematch=activated&print=all&maxresults=5000&fieldtext=MATCH{1}:QMSTYPE+AND+MATCH{#{drereference}}:drereference&Text=*"
		url = URI.encode(url)
		response = Net::HTTP.get_response(URI.parse(url))
		xml_data = response.body
		data = XmlSimple.xml_in(xml_data)
		CardinalPlacement.new(data['responsedata'][0]['hit'][0])
	end

	def add_accessor_and_value(key, val)
		key = key.downcase
		self.class_eval{attr_accessor key} unless respond_to?("#{key}=")
		val = val[0] if val.is_a?(Array) && val.count == 1
		send("#{key}=", val) 
	end
end
