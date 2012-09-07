class Synonym < Rule
	attr_accessor :id, :dretitle, :keywords, :concept, :qmsagentbool
	
	def save	
		if persisted?
			filename = 'app/idol_requests/synonyms/update.idx.erb'
			send_post(filename, '/DREREPLACE?&DATABASEMATCH=Activated')
		else
			filename = 'app/idol_requests/synonyms/save.idx.erb'
			send_post(filename, '/DREADDDATA?&DREDBNAME=Activated')
		end
	end
	
	def self.all
		url = build_url_for('/action=Query&databasematch=activated&print=all&maxresults=5000&fieldtext=MATCH{4}:QMSTYPE&Text=*')
		data = query_idol_with(url)
		synonyms = []
		data['responsedata'][0]['hit'].each do |hit|
			synonyms << self.new(hit) 
		end
		synonyms	
	end

	def self.find(id)
		url = build_url_for "/action=Query&databasematch=activated&print=all&maxresults=5000&fieldtext=MATCH{4}:QMSTYPE&MATCHID=#{id}"
		data = query_idol_with(url)
		Synonym.new(data['responsedata'][0]['hit'][0])
	end

	def self.destroy(id)
		#url = build_url_for "/DREDELETEDOC?docs=#{id}", 10151
		#response = Net::HTTP.get_response(URI.parse(url))
		#response.code == "200"
	end

end
