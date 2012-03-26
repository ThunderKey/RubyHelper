MyHelpers::activate ['DebuggerHelper']

class Object
	def debug msg, method = nil
		if method == nil
			if block_given?
				$debugger.debugging(self, msg) # yield mit geben
			else
				$debugger.debugging(self, msg)
				puts "no yield"
			end
		else
			if block_given?
				$debugger.debugging(self, msg, method) # yield mit geben
			else
				$debugger.debugging(self, msg, method)
				puts "no yield"
			end
		end
	end
end