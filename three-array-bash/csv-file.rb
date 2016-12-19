#!/usr/bin/env ruby

#This is not working yet.

raw_data = IO.readlines("firstarray") 

def self.store_data_to_csv_file_first(raw_data, identifier)
    csv = CSV.new raw_data
    file_name = '1-network.csv'
    file_exists = File.exist?("#{file_name}")
    mode = file_exists ? "a+" : "wb"
    # begin
        formatted_data = csv.to_a
        CSV.open("#{file_name}", "#{mode}") do |file|
          formatted_data.each do |row|
            file << get_processed_row_custom(row, '')
          end
end

store_data_to_csv_file_first
