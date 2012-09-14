require 'net/http'
require 'xmlsimple'

class Rule
	include ActiveModel::Validations
	include ActiveModel::Conversion
	extend ActiveModel::Naming
	
	attr_accessor :name

	def initialize(attributes={})
		@attributes = attributes
		add_attributes(attributes)
	end

	def persisted?
		!id.nil?
	end

	def update_attributes(params)
		return false if params.nil?
		params.each do |name, value|
			send("#{name}=", value)			
		end
	end
	
	def save	
		if persisted?
			filename = 	"app/idol_requests/#{self.class.name.tableize}/update.idx.erb"
			send_post(filename, '/DREREPLACE?&DATABASEMATCH=Activated')
		else
			filename = 	"app/idol_requests/#{self.class.name.tableize}/save.idx.erb"
			send_post(filename, '/DREADDDATA?&DREDBNAME=Activated')
		end
	end
	
	def self.all
		url = build_url_for("/action=Query&databasematch=activated&print=all&maxresults=5000&fieldtext=MATCH{#{rule_type}}:QMSTYPE&Text=*")
		data = query_idol_with(url)
		synonyms = []
		data['responsedata'][0]['hit'].each do |hit|
			synonyms << self.new(hit) 
		end
		synonyms	
	end

	def self.find(drereference)
		url = build_url_for "/action=Query&databasematch=activated&print=all&maxresults=5000&fieldtext=MATCH{#{rule_type}}:QMSTYPE&MATCHREFERENCE=#{drereference}"
		data = query_idol_with(url)
		self.new(data['responsedata'][0]['hit'][0])
	end

	def self.destroy(id)
		url = build_url_for "/DREDELETEDOC?docs=#{id}", 10151
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
		http = Net::HTTP.new(AppData.idol_host, AppData.qms_index_port)
		response = http.post(path, post_data, {'Content-Type' => 'text/plain'})
		response.code == "200"
	end

	def self.query_idol_with(url)
		url = URI.encode(url)
		response = Net::HTTP.get_response(URI.parse(url))
		xml_data = response.body
		data = XmlSimple.xml_in(xml_data)	
	end

	def self.build_url_for(path, port=AppData.qms_query_port)
		"#{AppData.idol_host_protocol}#{AppData.idol_host}:#{port}#{path}"	
	end

end

