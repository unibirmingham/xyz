module AppData
	extend self

	def parameter(*names)
		names = Hash[*names]
		names.each do |name, value|
			attr_accessor name
			define_method name do
				self.send("#{name}=", value)
			end
		end
	end

	def config(&block)
		instance_eval &block
	end

end
