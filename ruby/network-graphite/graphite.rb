#!/usr/bin/env ruby
# require 'mechanize'
require 'open-uri'
require 'json'
require 'pp'
require 'csv'

# class to manipulate URL and get the required data
class RequestUri
  # for testing purpose
  def self.return_url url
    "#{url}"
  end

  def self.request_open_uri url
    result = open( url ).read
    result
  end

  def self.request_mechanize url
    # mechanize = Mechanize.new
    # result = mechanize.get( url )
    # result
  end

  def self.store_data_to_csv_file(raw_data, identifier)
    csv = CSV.new raw_data
    file_name = 'output_data_dump.csv'
    file_exists = File.exist?("#{file_name}")
    mode = file_exists ? "a+" : "wb"
    begin
        formatted_data = csv.to_a
        CSV.open("#{file_name}", "#{mode}") do |file|
          formatted_data.each do |row|
            file << row
          end
        end
    rescue Exception => e
      puts "*************"
      puts "ERROR ADDING DATA TO FILE FOR " + identifier
      puts "*************\n"
    end
  end
end

# request_uri = 'http://google.com'

### standard URL and RESPONSE
# http://graphite-web.intuit.net/render?target=collectd.network.QCY-C.*.*.*.snmp.*CPU*&from=-10min&until=-5min&format=csv
# render?target=collectd.network.QCY-C.*.*.*.snmp.*Memory*&from=-10min&until=-5min&format=csv
# response = collectd.network.QCY-C.nx-os.N5kC5020pBf.ac1-storage-c-qcy__mgmt0_dcnet_intuit_net.snmp.cisco_cseMemory,2016-06-17 15:20:00,68.0

# there are 3 above.  memory latency and cpu
# each url needs to be run against all variables
# i send you that will replace the QCY-c field in the url

# QDC-A QDC-B  QDC-C QDC-D  QDC-E  QDC-F
# we may need to add or remove the variables in future script revisions

base_url_temp = 'http://graphite-web.intuit.net/'
base_url = 'http://url.net/'

network_part = 'render?target=collectd.network.'
# need changeable part here
steric_part = '.*.*.*.'
snmp_part = 'snmp.*'
# need to place * for CUP & Memory but not for latency
extra_params = '&from=-10min&until=-5min&format=csv'

request_query_cpu = 'render?target=collectd.network.QCY-C.*.*.*.snmp.*CPU*&from=-10min&until=-5min&format=csv'
request_query_memory = 'render?target=collectd.network.QCY-C.*.*.*.snmp.*Memory*&from=-10min&until=-5min&format=csv'
request_query_latency = 'render?target=collectd.network.QCY-C.*.*.*.latency&from=-10min&until=-5min&format=csv'

# for now adding these variables
qdc_array = %w[QCY-A QCY-B QCY-C QCY-D QCY-E QCY-F]
type_array = %w[CPU* Memory* latency]

type_array.each do |type|
  qdc_array.each do |qdc|
    if type == 'latency'
      complete_url = "#{base_url_temp}#{network_part}#{qdc}#{steric_part}#{type}#{extra_params}"
    else
      complete_url = "#{base_url_temp}#{network_part}#{qdc}#{steric_part}#{snmp_part}#{type}#{extra_params}"
    end

    puts "***********************************************"
    puts "Processing STARTED -> " + type + '_' + qdc
    puts RequestUri.return_url(complete_url)
    puts "***********************************************\n\n"

    # check if response is fine
    # result = RequestUri.request_open_uri("http://google.com")
    result = RequestUri.request_open_uri(complete_url)
    puts  RequestUri.store_data_to_csv_file result, type+qdc
    #puts  RequestUri.store_data_to_csv_file "result,2,3", type+qdc

    puts "***********************************************"
    puts "Processing ENDED -> " + type + '_' + qdc
    puts "***********************************************\n\n"


    # puts result
    # test URL string
    # puts RequestUri.return_url(complete_url)
    # puts "**********************"
  end
end

# puts "Result: #{result.inspect}"
# puts "***********************************************"
#
# puts "Result: " + open_result.inspect
# puts "***********************************************"

# puts "Parsed result: " + JSON.parse( result )
