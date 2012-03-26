# adds some neat functions to all Numerics
class Numeric
	# pre-defined functions
	# first function returns the number converted from type to seconds
	# second function returns the number converted from seconds to type
	@@functions = %Q{
		def %{type}
			self * %{seconds}
		end
		
		def in_%{type}
			(self.modulo(%{seconds}) == 0 ? self : self.to_f) / %{seconds}
		end
	}
	
	# numbers in seconds (pre-calculated)
	{
		:seconds  => 1,				#1
		:minutes  => 60,			#60
		:hours    => 3_600,			#60*60
		:days     => 86_400,		#60*60*24
		:weeks    => 604_800,		#60*60*24*7
		:years    => 31_536_000		#60*60*24*365
	}.each do |type, seconds|
		# add functions to module
		module_eval(
			# replace %{type} and %{seconds} in @@functions (same as: format(@@functions, {...}))
			@@functions % {:type => type, :seconds => seconds}
		)
	end
	
	# get time: x seconds ago
	def ago
		Time.now - self
	end
	# get time: x seconds from now
	def from_now
		Time.now + self
	end
end