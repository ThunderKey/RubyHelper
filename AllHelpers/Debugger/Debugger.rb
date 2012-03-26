MyHelpers::activate ['Clock', 'HeaderForString', 'ExtAttrAccessorForObject']

class Debugger
	def initialize opts = {}
		set_default opts
		create_log if write_log?
	end
	
	ext_attr_reader({
		"inspect?" => "opts[:inspect]",
		"write_console?" => "opts[:write_console]",
		"write_log?" => "opts[:write_log]",
		"log" => "opts[:log]"
	})
	
	def debugging caller, msg, method = :info, inspect = inspect?, to_log = write_log?, to_console = write_console?
		method ||= :info
		begin
			msg = yield(msg, method)
		rescue
			msg = "#{method}> #{msg}"
			msg += "\n\t#{caller.class.to_s}: #{caller.inspect}" if inspect?
		end
		write "#{Clock::getTime} #{msg}\n" if to_log
		puts msg if to_console
	end
	
private

	def write msg
		File.open(log, 'a') do |f|
			f.write(msg)
		end
	end

	def create_log
		path_parts = log.split(/[\/\\]/)
		file = path_parts.pop
		file = get_folder(path_parts) + file
		
		write "\n\n" + "log from #{Clock::getDate}".header + "\n\n"
	end
	
	def get_folder path_parts
		folder = ''
		path_parts.each do |dir|
			folder = folder + dir + '/'
			Dir.mkdir(folder) unless File.exists?(folder)
		end
		return folder
	end

	def set_default opts
		@opts = {
			:write_console => true,
			:write_log => true,
			:inspect => true,
			:log => "./logs/debugger.log"
		}.merge(opts)
	end
end