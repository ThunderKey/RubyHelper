class String
	def == other
		(self.eql?(other) || self.eql?(other.to_s))
	end
end

class Symbol
	alias :eql? :==
	def == other
		if other.respond_to? :to_sym
			return self.eql?(other.to_sym)
		end
		false
	end
end