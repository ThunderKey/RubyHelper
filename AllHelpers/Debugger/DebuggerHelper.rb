require File.dirname(__FILE__) + '/Debugger.rb'

# use default:
$debugger = Debugger.new

# specify settings (not all required) in this case it's the same as the default:
#$debugger = Debugger.new({
#	:write_console => true,
#	:write_log => true,
#	:inspect => true,
#	:log => "./logs/debugger.log"
#})