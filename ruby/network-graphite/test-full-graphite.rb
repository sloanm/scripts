#!/usr/bin/env ruby
# require 'mechanize'
# http://ruby-doc.org/stdlib-2.1.0/libdoc/open-uri/rdoc/OpenURI.html 
require 'open-uri'
# http://ruby-doc.org/stdlib-2.0.0/libdoc/csv/rdoc/CSV.html
require 'json'
# http://ruby-doc.org/stdlib-2.0.0/libdoc/csv/rdoc/CSV.html 
require 'pp'
#  http://ruby-doc.org/stdlib-2.0.0/libdoc/pp/rdoc/PP.html 
require 'csv'
# http://ruby-doc.org/stdlib-2.0.0/libdoc/csv/rdoc/CSV.html
require "highline/import"
require 'pry'

# class to manipulate URL and get the required data
class RequestUri
  # for testing purposes
  def self.return_url url
    "#{url}"
  end

  def self.request_open_uri url
    result = open( url ).read
    result
  end

  def self.request_mechanize url
  end

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
    # rescue Exception => e
    #   puts "*************"
    #   puts "ERROR ADDING DATA TO FILE FOR " + identifier
    #   puts "*************\n"
    # end
  end

  def self.store_data_to_csv_file(raw_data, identifier, after_cli)
    csv = CSV.new raw_data
    file_name = '2-network.csv'
    file_exists = File.exist?("#{file_name}")
    mode = file_exists ? "a+" : "wb"
    
    # be#3gin
        formatted_data = csv.to_a
        CSV.open("#{file_name}", "#{mode}") do |file|
          formatted_data.each do |row|
            # puts "key: " + after_cli.to_s
            # puts "final_row: " + after_cli && after_cli == 'Nexus'
            # final_row = after_cli && after_cli == 'Nexus' ? get_processed_row_custom(row) : get_processed_row(row)
            file << get_processed_row_custom(row, after_cli)
          end
        end
    # rescue Exception => e
    #   puts "*************"
    #   puts "ERROR ADDING DATA TO FILE FOR " + identifier
    #   puts "*************\n"
    # end
  end

  def self.get_processed_row_custom(row, identifier)
    puts 'row: ' 
    puts row

    main_array = []
    # begin
      # first column from the complete row; comma separated
      first_col = row[0]

      # split and manage first column
      splitted_elem = first_col.split('.')
      len = splitted_elem.length
binding.pry
      if identifier == 'Nexus'
        # puts 'split: ' + len.to_ + '**' + first_col
        main_array << splitted_elem[2] # model
        main_array << splitted_elem[3] # zone
        main_array << splitted_elem[4] # orig element
        main_array << splitted_elem[5] # device
        main_array << splitted_elem[6]
      elsif identifier == 'Junipers'
        main_array << splitted_elem[2] << splitted_elem[6] << splitted_elem[4] << splitted_elem[5]
      else
        puts 'values '
        puts splitted_elem[3]
        puts splitted_elem[5]
        puts splitted_elem[len-1]
        main_array << splitted_elem[3] << '' << splitted_elem[5] << splitted_elem[len - 1] << row[2].to_s
      end
      main_array << row[0].to_s
      main_array << row[1].to_s


    main_array
  end

  def self.get_processed_row(row)
    # puts 'row: ' 
    # puts row

    main_array = []
    # begin
      # first column from the complete row; comma separated
      first_col = row[0]

      # split and manage first column
      splitted_elem = first_col.split('.')
      len = splitted_elem.length

      # puts 'split: ' + len.to_ + '**' + first_col

      main_array << splitted_elem[0..len - 3].join('.')
      main_array << splitted_elem[len - 2] << splitted_elem[len - 1]
      main_array << row[1].to_s
      # array without first element
      # final_array = []
      # final_array << row[1]
      # final_array.zip(main_array).flatten.compact

      # puts 'main_arr '
      # puts main_array

    # rescue Exception => e
      # puts "*************"
      # puts "ERROR in get_processed_row "
      # puts "*************\n"
      # main_array = []
    # end

    main_array
  end
end


# QDC-A QDC-B  QDC-C QDC-D  QDC-E  QDC-F

base_url_temp = 'http://graphite-web.intuit.net/'
base_url = 'http://url.net/'

network_part = 'render?target=collectd.network.'


# need changeable part here
asterisk = '.*.*.*.'
steric_part1 = '.*.*.*.*.'
snmp_part = 'snmp.*'

router = 'Nexus.'
router1 = 'Junipers.'

# need to place * for CUP & Memory but not for latency
extra_params = '&from=-10min&until=-5min&format=csv'

request_query_cpu = 'render?target=collectd.network.QCY-C.*.*.*.snmp.*CPU*&from=-10min&until=-5min&format=csv'
request_query_memory = 'render?target=collectd.network.QCY-C.*.*.*.snmp.*Memory*&from=-10min&until=-5min&format=csv'
request_query_latency = 'render?target=collectd.network.QCY-C.*.*.*.latency&from=-10min&until=-5min&format=csv'

request_query_network_script2 = 'render?target=network-script.CLI.Nexus.QDC_A.7K.*.*&from=12:00+20160708&until=12:15+20160708&format=csv'
request_query_network_script3 = 'render?target=network-script.CLI.Junipers.*.*.*.*&from=12:00+20160708&until=12:15+20160708&format=csv'  

# user prompts for dynamic dates
from_date = ask "\n\nPlease enter FROM date (for example: 20160708)"
until_date = ask "Please enter UNTIL date (for example: 20160708)"

if from_date.to_s != '' && until_date.to_s != ''
  puts "\n\n\t ***** First script *****\n\n"

  # for now adding these variables
  qdc_array = %w[QCY-A QCY-B QCY-C QCY-D QCY-E QCY-F]
  type_array = %w[CPU* Memory* latency]

  type_array.each do |type|
    qdc_array.each do |qdc|
      if type == 'latency'
        complete_url = "#{base_url_temp}#{network_part}#{qdc}#{asterisk}#{type}#{extra_params}"
      else
        complete_url = "#{base_url_temp}#{network_part}#{qdc}#{asterisk}#{snmp_part}#{type}#{extra_params}"
      end

      puts "***********************************************"
      puts "Processing STARTED -> " + type + '_' + qdc
      puts RequestUri.return_url(complete_url)
      puts "***********************************************\n\n"

      result = RequestUri.request_open_uri(complete_url)
      puts  RequestUri.store_data_to_csv_file_first result, type+qdc

      puts "***********************************************"
      puts "Processing ENDED -> " + type + '_' + qdc
      puts "***********************************************\n\n"

    end
  end



  puts "\n\n\t ***** Second script *****\n\n"

    network_script = 'render?target=network-script.CLI.'
    after_cli_array = %w[Nexus Junipers]
    second_asterisk_array = %w[5k 7k]
    forth_asterisk_array = %w[MacDynamicAddressCount MacMulticastAddressCount MacOverlayAddressCount MacSecureAddressCount
                              MacStaticAddressCount SpanningTree-Active SpanningTree-Blocking SpanningTree-Forwarding
                              SpanningTree-Learning SpanningTree-Listening TotalMacAddressInUse TotalPVLANCloneMacAddressCount
                              numOfExtendedVLANs numOfUserVLANs numOfVLANs]

    extra_params1 = '&from=12:00+'+ from_date +'&until=12:15+' + until_date + '&format=csv'
    node_array = %w[node0 node1]

    after_cli_array.each do |after_cli|
        forth_asterisk_array = node_array unless after_cli == 'Nexus'
        forth_asterisk_array.each do |forth|
          if after_cli == 'Nexus'
            updated_url = "#{base_url_temp}#{network_script}#{after_cli}.*.*.*.#{forth}#{extra_params1}"
          else
            updated_url = "#{base_url_temp}#{network_script}#{after_cli}.*.*.pcbMemory.#{forth}#{extra_params1}"
          end

          puts "***********************************************"
          puts "Processing STARTED -> " + after_cli  + '_' + forth
          puts RequestUri.return_url(updated_url)
          puts "***********************************************\n\n"

          result = RequestUri.request_open_uri(updated_url)
        RequestUri.store_data_to_csv_file result, after_cli+forth, after_cli.to_s

        puts "***********************************************"
        puts "Processing ENDED -> " + after_cli + '_' + forth
        puts "***********************************************\n\n"
      end
  end
else
  puts "\n\nERROR:->Please input FROM date and UNTIL date!\n\n\n"
end
