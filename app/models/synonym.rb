class Synonym < Rule
	attr_accessor :id, :dretitle, :keywords, :concept, :qmsagentbool
	
	def self.rule_type
		4
	end
	
end
