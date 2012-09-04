module ApplicationHelper

	def to_boolean(string)	
		string.downcase == 'true'
	end

	def find_cardinal_placement_path(placement)
		return	cardinal_placement_path(placement.id) unless placement.id.nil?
		cardinal_placements_path
	end

	def form_tag_for(placement, &block)
		url = find_cardinal_placement_path(placement)
		method = placement.id.nil? ? "POST" : "PUT"
		form_tag(url, :method => method, &block)
	end
end
