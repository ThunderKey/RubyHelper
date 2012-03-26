class String
	def == other
		(self.eql?(other) || self.eql?(other.to_s))
	end
end

class Symbol
	alias :eql? :==
	def == other
		if other.respond_to? :to_sym
			self.eql?(other.to_sym)
		else
			false
		end
	end
end