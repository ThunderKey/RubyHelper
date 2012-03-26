module Clock
	def self.getTime t = Time.now
		h = t.hour.to_s
		m = valTime t.min
		s = valTime t.sec.to_s
		"#{h}:#{m}:#{s}"
	end

	def self.getDate t = Time.new
		y = t.year.to_s
		m = valTime t.month.to_s
		d = valTime t.day.to_s
		"#{y}-#{m}-#{d}" 
	end

	def self.getDateTime t = Time.now
		"#{getDate t} #{getTime t}"
	end

private

	def self.valTime value
		if value.to_i < 10
			return "0#{value}"
		end
		return value.to_s
	end
end