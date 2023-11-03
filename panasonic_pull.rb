#!/usr/bin/ruby

# This script fetches data from a Panasonic breakerbox, processes it, and generates Prometheus metrics for a specific use case.

require 'open-uri'
require 'csv'

# Fetch data from a remote CSV file using its URL and treat the first row as headers.
csv_data = CSV.parse(URI.open("http://192.168.0.59/csv/InstVal.csv"), headers: :first_row)

# Define a mapping between metric names and their corresponding column indices in the CSV data.
power_mappings = {
  "main" => 1,
  "pv1" => 2,
  "ecocute" => 5,
  "living_lights" => 17,
  "utility_lights" => 18,
  "mbr_wic_lights" => 19,
  "av_lights" => 20,
  "office_lights" => 21,
  "jin_lights" => 22,
  "bath_toilet_lights" => 23,
  "hall_toilet_outlet" => 24,
  "living_pantry_outlet" => 25,
  "jin_outlet" => 26,
  "mbr_outlet" => 27,
  "freezer" => 28,
  "office_outlet" => 29,
  "washing_machine" => 30,
  "av_outlet_left" => 31,
  "av_outlet_right" => 32,
  "utility_outlet_left" => 33,
  "utility_outlet_right" => 34,
  "bath_outlet" => 35,
  "toilet_outlet" => 36,
  "microwave" => 37,
  "kitchen_counter" => 38,
  "septic" => 39,
  "diswasher" => 40,
  "stiebel" => 41,
  "aircon" => 42,
  "stove" => 43,
  "av_ac" => 44,
  "ev_charger" => 48,
  "oven" => 49
}

# Begin writing the generated metrics to a Prometheus data file.
begin
  # Open the file for writing. The file will be created or overwritten.
  file = File.open("/var/lib/prometheus/node-exporter/panasonic.prom", "w")

  # Iterate through the power_mappings and process the data for each metric.
  power_mappings.each do |key, column|

    # Read the value from the CSV data, converting it from hexadecimal to an integer.
    value = csv_data[5][column].to_i(16)

    # Multiply the value by 10 for "main" and "ecocute" metrics.
    value *= 10 if key == "main" || key == "ecocute"

    # Generate the friendly name by capitalizing words separated by underscores.
    friendly_name = key.to_s.split('_').map(&:capitalize).join(' ')

    # Write the Prometheus metric to the file, using string interpolation.
    file.write("power_w{domain=\"panasonic\",entity=\"#{key}\",friendly_name=\"#{friendly_name}\"} #{value}\n")
  end
rescue IOError => e
  # Handle any IO-related errors and exceptions, such as file access problems.
ensure
  # Ensure that the file is closed after writing (if it was opened).
  file&.close
end
