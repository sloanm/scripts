#!/usr/bin/env ruby
line_count = `cat first100| wc -l`
  puts line_count

nums = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110]

contents_array = IO.readlines("first100")
contents_array.each_slice(10) do |a| 
  puts 'echo "line number 10"' 
  puts a 
end
