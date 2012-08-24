module ApplicationHelper

	def to_boolean(string)	
		string.downcase == 'true'
	end
	
	def find_cardinal_placement_path(placement)
		return	cardinal_placement_path(placement.id) unless placement.id.nil?
		new_cardinal_placement_path
	end
end
