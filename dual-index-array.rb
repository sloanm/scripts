#!/usr/bin/env ruby

#NOTE: the nums array must match the number of lines in the $filename file.
#  Do a cat $filename | wc -l and change the size of the nums array.

#line_count = `cat first100| wc -l`
#  puts line_count

#while true
#  filename = ask "\nPlease enter the name of the file to process: "
#  puts $filename
#end

nums =* (1..500) 
contents_array = IO.readlines("replace-cmds-list")

a = [nums,contents_array]


nums.zip(contents_array).each do |array1, array2|
  puts "echo line #{array1}" 
  puts array2
end

