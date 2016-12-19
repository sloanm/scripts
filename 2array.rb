#!/usr/bin/env ruby

nums =* (1..100)

lines = IO.readlines("first100")

nums.each_with_index do |a, i|
  puts "#{nums},#{lines[i]}"  
end

