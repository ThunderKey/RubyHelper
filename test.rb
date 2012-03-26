require "./AllHelpers"

puts "Testing AllHlepers".header
puts "all possibilities:"
puts MyHelpers::helpers.join($/)
puts "activated:"
puts MyHelpers::activated.join($/)
t = Time.new
MyHelpers::activate ["DateForNum"]
puts Time.new - t

puts "DateForNum".header
puts "seconds"
puts 5.seconds.ago
puts "minutes"
puts 5.minutes.ago
puts "hours"
puts 5.hours.ago
puts "days"
puts 5.days.ago
puts "weeks"
puts 5.weeks.ago
puts "years"
puts 5.years.ago
puts "in_minutes test (1 and 1.5 minutes)"
puts 60.in_minutes
puts 90.in_minutes

puts "join".header
hash = {"test1" => 5, "test2" => 10, "test3" => 15}
puts hash.join
puts "********"
puts hash.join(' is ')
puts "********"
puts hash.join(' is ', ' and ')

puts "join & linenumber".header
puts hash.join.linenumber

puts "tab".header
puts MyHelpers::helpers.join($/).tab
puts "********"
puts MyHelpers::helpers.join($/).indent(2)
puts "********"
puts MyHelpers::helpers.join($/).tab(4).tab(-1)

puts "StringSymbolComparison".header
puts "asdf".eql? :asdf
puts "asdf" == :asdf
puts :asdf.eql? "asdf"
puts :asdf == "asdf"

puts "Debugger".header
["asdf","asdfasdf"].debug "important", :error
debug "other debugging"
"asdf".debug "hello" do |msg, method|
	puts "hallo yield"
	"debug:\n\tmethod: #{method}\n\tmessage: #{msg}"
end

puts "ExtAttrAccessorForObject".header
class Test
	ext_attr_reader({"asdf?" => "asdf"})
	ext_attr_writer({"asdf" => "asdf"})
	ext_attr_accessor({"my var" => {:accessor => "my var"}})
	ext_attr_accessor({"my other var" => "my other var"})
	ext_attr_accessor({"my bool" => {:reader => "my bool?", :writer => "my bool="}})
end
t = Test.new
puts t.asdf?.inspect
t.asdf = "test"
puts t.asdf?
t.my_var = "blubb"
puts t.my_var
t.my_other_var = "blubb2"
puts t.my_other_var
t.my_bool = false
puts t.my_bool?

puts "ExtEqlForObject".header
puts '"asdf".eql_each? ["asdf", "not asdf"] => ' + ('asdf'.eql_each? ['asdf', 'not asdf']).to_s
puts '"asdf".eql_one? ["asdf", "not asdf"] => ' + ('asdf'.eql_one? ['asdf', 'not asdf']).to_s
puts '"asdf".eql_each? ["asdf", "asdf"] => ' + ('asdf'.eql_one? ['asdf', 'asdf']).to_s
puts '"asdf".eql_one? [] => ' + ('asdf'.eql_one? []).to_s
