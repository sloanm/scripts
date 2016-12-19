#!/usr/bin/env ruby

#Make sure the fline on line 9 exists and that the nums array 1..100 contains the correct number of lines
# the number of lines in the nums array must equal the number of lines in replace-cmds-list
line_count = `cat first-array| wc -l`
  puts line_count

nums =* (1..30)

arrayone = IO.readlines("firstarray")
arraytwo = IO.readlines("secondarray")
arraythree = IO.readlines("thirdarray")


arrayone.zip(arraytwo, arraythree).each do |arraytwo, arraythree, arrayone|
#arrayone.zip(arraytwo, arraythree).each do |arrayone, arraytwo, arraythree|
  puts arrayone 
  puts arraytwo
  puts arraythree
end
