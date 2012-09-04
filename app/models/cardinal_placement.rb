class CardinalPlacement
	require 'net/http'
	require 'xmlsimple'
	attr_accessor :id, :dretitle, :qmsvalue1, :qmsvalue2, :alwaysactive, :qmsagentbool

	def initialize(attributes={:alwaysactive => 'true'})
		@attributes = attributes
		add_attributes(attributes)
	end
	
	def save	
		filename = 'app/idol_requests/cardinal_placements/save.idx.erb'
		send_post(filename, '/DREADDDATA?&DREDBNAME=Activated')
	end
	
	def update
		filename = 'app/idol_requests/cardinal_placements/update.idx.erb'
		send_post(filename, '/DREREPLACE?&DATABASEMATCH=Activated')
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

	def self.find(id)
		url = "http://147.188.128.215:10150/action=Query&databasematch=activated&print=all&maxresults=5000&fieldtext=MATCH{1}:QMSTYPE&MATCHID=#{id}"
		data = query_idol_with(url)
		CardinalPlacement.new(data['responsedata'][0]['hit'][0])
	end

	def self.destroy(id)
		url = "http://147.188.128.215:10151/DREDELETEDOC?docs=#{id}"
		response = Net::HTTP.get_response(URI.parse(url))
		response.code == "200"
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

	def send_post(erb_file, path)
		filename = erb_file 
		erb = ERB.new(File.read(filename))
		erb.filename = filename
		post_data = erb.result(binding) 
		http = Net::HTTP.new("147.188.128.215", 10151)
		response = http.post(path, post_data, {'Content-Type' => 'text/plain'})
		response.code == "200"
	end
	
	def self.query_idol_with(url)
		url = URI.encode(url)
		response = Net::HTTP.get_response(URI.parse(url))
		xml_data = response.body
		data = XmlSimple.xml_in(xml_data)	
	end
end
