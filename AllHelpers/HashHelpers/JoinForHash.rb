class Hash
	def join after_key = ': ', after_value = $/
		self.to_a.collect { |entry| entry.join(after_key) }.join(after_value)
	end
end