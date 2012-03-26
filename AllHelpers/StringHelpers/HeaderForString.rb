# add a header function to String, which creates a simple header format for the console
class String
	def header
		stars = '*' * (self.length + 4)
		"#{stars}\n* #{self} *\n#{stars}"
	end
end