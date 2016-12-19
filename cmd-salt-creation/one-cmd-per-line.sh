#!/usr/bin/env ruby

#Make sure the fline on line 9 exists and that the nums array 1..100 contains the correct number of lines
# the number of lines in the nums array must equal the number of lines in replace-cmds-list
line_count = `cat first100| wc -l`
  puts line_count

nums =* (1..98)

contents_array = IO.readlines("replace-cmds-list")

a = [nums,contents_array]

nums.zip(contents_array).each do |nums, contents_array|
#nums.zip(contents_array).each do |contents_array, nums|
  puts "echo line #{nums}" 
  puts contents_array 
end
