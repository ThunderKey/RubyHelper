class Object
	# "asdf".eql_each? ["asdf", "not asdf"] => "asdf" == "asdf" && "asdf" == "not asdf" => false
	def eql_each? values
		if values.class == Array
			return false if values.empty?
			values.each do |value|
				return false unless value.eql? self
			end
			return true
		else
			return to_check == values
		end
	end
	
	# "asdf".eql_one? ["asdf", "not asdf"] => "asdf" == "asdf" || "asdf" == "not asdf" => true
	def eql_one? values
		if values.class == Array
			return false if values.empty?
			values.each do |value|
				return true if value.eql? self
			end
			return false
		else
			return to_check == values
		end
	end
end