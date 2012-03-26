MyHelpers::activate ["OppositeForNum"]

class String
	def tab times = 1
		if times > 0
			return self.split("\n").collect do |line|
				("\t" * times) + line
			end.join("\n")
		elsif times < 0
			return self.split("\n").collect do |line|
				line.gsub(/^#{'\t' * times.opposite}/, '')
			end.join("\n")
		end
		self
	end
	alias :indent :tab
end