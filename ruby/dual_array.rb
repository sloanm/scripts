#!/usr/bin/env ruby
require 'pp'

qdc_array = %w[QCY-A QCY-B QCY-C QCY-D QCY-E QCY-F]
  type_array = %w[CPU* Memory* latency]

  type_array.each do |type|
    qdc_array.each do |qdc|
        puts   type_array+qdc_array
#	puts type_array 
#	puts qdc_array
    end
  end
