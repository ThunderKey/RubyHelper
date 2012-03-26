module MyHelpers
	@@all_helpers = File.dirname(__FILE__) + '/AllHelpers/'
	@@activated = []
	
	def self.activate to_activate = :all, folder = @@all_helpers
		files = Dir.glob get_filenames(to_activate)
		files.each do |file|
			unless @@activated.include? file
				if require file
					@@activated.push(file)
				else
					puts "an error accured while loading #{file}"
				end
			end
		end
	end
	
	def self.helpers folder = @@all_helpers
		Dir.glob(["#{folder}*", "#{folder}*/*.rb"]).collect{ |file| get_name_from_file(file, folder) }.sort
	end
	
	def self.activated folder = @@all_helpers
		@@activated.collect{ |file| get_name_from_file(file, folder) }
	end

private

	def self.get_filenames to_activate, folder = @@all_helpers
		if to_activate == :all
			return get_all_filenames(folder)
		elsif to_activate.class == Hash || to_activate.class == Array
			to_activate = {:just => to_activate} if to_activate.class == Array
			if to_activate.has_key? :just
				return get_files(to_activate[:just])
			elsif to_activate.has_key? :not
				return get_all_filenames(folder) - get_files(to_activate[:not])
			end
		end
		return []
	end
	
	def self.get_all_filenames folder = @@all_helpers
		return Dir.glob(["#{folder}*.rb", "#{folder}*/*.rb"])
	end
	
	def self.get_files files
		if files.class == String
			file_or_dir files
		else
			files.collect do |name|
				file_or_dir name
			end
		end
	end
	
	def self.file_or_dir file, folder = @@all_helpers
		if Dir.glob("#{folder}#{file}.rb").length > 0
			file = "#{folder}#{file}.rb"
		else
			file = "#{folder}*/#{file}.rb"
		end
		raise ArgumentError, "File #{file} does not exist" unless Dir.glob(file).length > 0
		(File.directory?(file) ? file + '/*' : validate_file(file))
	end
	
	def self.validate_file file	
		(file.end_with?('.rb') ? file : file + '.rb')
	end
	
	def self.get_name_from_file file, folder = @@all_helpers
		file.gsub(/^#{folder}/, '').chomp('.rb')
	end
end