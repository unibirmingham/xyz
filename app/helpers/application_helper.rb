module ApplicationHelper

	def to_boolean(string)	
		string.downcase == 'true' unless string.nil?
	end

	def selected_nav(user_controller_name)
  	"selected" if controller_name == user_controller_name
	end
	
end
