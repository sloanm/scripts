#!/usr/bin/env ruby
require 'pry'

line_count = `cat first100| wc -l`
  puts line_count

nums = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110]

contents_array = IO.readlines("first100")

#nums.each_slice(10) { |a| p a }
contents_array.each do |line|
#contents_array.each_slice(10) { |a| p a }
#binding.pry
  puts line
  contents_array.each_slice(10) do |a|
  puts a
  end
  #nums.each_slice(1) { |a| p a }
  #if nums = 
  #puts line 
end
