class Object
protected
	def self.ext_attr_reader values
		ExtAttrAccessor::create_reader self, values
	end
	
	def self.ext_attr_writer values
		ExtAttrAccessor::create_writer self, values
	end
	
	def self.ext_attr_accessor values
		ExtAttrAccessor::create_accessor self, values
	end
end
	
module ExtAttrAccessor
	@@reader_function = %Q{
		def %{meth_name}
			@%{var}
		end
	}
	@@writer_function = %Q{
		def %{meth_name}=(%{var})
			@%{var} = %{var}
		end
	}
	
	def self.create_reader caller, values
		create caller, values, @@reader_function
	end
	def self.create_writer caller, values
		create caller, values, @@writer_function
	end
	
	def self.create_accessor caller, values
		reader, writer = {}, {}
		values.each do |var, meth_names|
			if meth_names.class == String
				reader[meth_names] = var
				writer[meth_names] = var
			elsif meth_names.has_key?(:accessor)
				reader[meth_names[:accessor]] = var
				writer[meth_names[:accessor]] = var
			else
				reader[meth_names[:reader]] = var
				writer[meth_names[:writer]] = var
			end
		end
		create_reader caller, reader
		create_writer caller, writer
	end
	
	def self.create caller, values, function
		values = to_hash(values)
		values.each do |meth_name, var|
			meth_name, var = validate(meth_name, var)
			create_function(caller, meth_name, var, function)
		end
	end
	
	def self.to_hash values
		if values.class == Array
			hash = {}
			values.each { |value| hash[value] = value }
			return hash
		elsif values.class == Hash
			return values
		else
			return nil
		end
	end
	
	def self.create_function caller, meth_name, var, function
		caller.class_eval(function % {:meth_name => meth_name, :var => var})
	end
	
	def self.validate meth_name, var
		return meth_name.gsub(' ', '_').gsub(/=$/, ''),
				var.gsub(' ', '_').gsub(/^@*/, '')
	end
end