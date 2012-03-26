class String
	def linenumber
		count = 0
		self.split("\n").collect do |line|
			"#{count += 1}: #{line}"
		end.join("\n")
	end
end