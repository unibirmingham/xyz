class CardinalPlacement
	require 'net/http'
	require 'xmlsimple'

	def initialize(attributes={})
		@attributes = attributes
		add_attributes(attributes)
	end
	
	def self.all
		url = 'http://147.188.128.215:10150/action=Query&databasematch=activated&print=all&maxresults=5000&fieldtext=MATCH{1}:QMSTYPE&Text=*'
		data = query_idol_with(url)
		cardinals = []
		data['responsedata'][0]['hit'].each do |hit|
			cardinals << CardinalPlacement.new(hit) 
		end
		cardinals
	end

	def self.find(drereference)
		url = "http://147.188.128.215:10150/action=Query&databasematch=activated&print=all&maxresults=5000&fieldtext=MATCH{1}:QMSTYPE+AND+MATCH{#{drereference}}:drereference&Text=*"
		data = query_idol_with(url)
		CardinalPlacement.new(data['responsedata'][0]['hit'][0])
	end

	def self.query_idol_with(url)
		url = URI.encode(url)
		response = Net::HTTP.get_response(URI.parse(url))
		xml_data = response.body
		data = XmlSimple.xml_in(xml_data)	
	end

	private

	def add_attributes(attributes)
		attributes.each do |key,val|
			add_accessor_and_value(key, val)
		end
		
		if !attributes['content'].nil? && !attributes['content']['DOCUMENT'].nil?
			attributes['content']['DOCUMENT'][0].each do |key,val|
				add_accessor_and_value(key,val)
			end
		end
	end

	def add_accessor_and_value(key, val)
		key = key.downcase
		self.class_eval{attr_accessor key} unless respond_to?("#{key}=")
		val = val[0] if val.is_a?(Array) && val.count == 1
		send("#{key}=", val) 
	end
end
