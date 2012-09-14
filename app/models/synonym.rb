class Synonym < Rule
	attr_accessor :id, :dretitle, :keywords, :concept, :qmsagentbool
	
	def self.save_file_path	
			'app/idol_requests/synonyms/update.idx.erb'
	end

	def self.update_file_path
			'app/idol_requests/synonyms/save.idx.erb'
	end
	
	def self.rule_type
		4
	end
	
end
