#!/usr/bin/env ruby

File.open 'joboutput' do |file|
  file.find { |line| line =~ /info/ }
end
