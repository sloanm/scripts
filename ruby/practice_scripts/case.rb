#!/usr/bin/env ruby

age = 12

print "Enter Greeting : "

greeting = gets.chomp

case greeting
when "French", "french"
   puts "Bonjour"
   exit
when "Spanish", "spanish"
   puts "Hola"
   exit
else "English" 
   puts "Hello"
end 
