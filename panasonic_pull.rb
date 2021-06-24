#!/usr/bin/ruby

require 'rubygems'
require 'open-uri'
require 'csv'

csv_data = CSV.parse(URI.open("http://192.168.0.59/csv/InstVal.csv"), :headers => :first_row)

power = {
	"main" => csv_data[5][1].to_i(16)*10,
	"pv1" => csv_data[5][2].to_i(16),
	"ecocute" => csv_data[5][5].to_i(16)*10,
	"living_lights" => csv_data[5][17].to_i(16),
	"utility_lights" => csv_data[5][18].to_i(16),
	"mbr_wic_lights" => csv_data[5][19].to_i(16),
	"av_lights" => csv_data[5][20].to_i(16),
	"office_lights" => csv_data[5][21].to_i(16),
	"jin_lights" => csv_data[5][22].to_i(16),
	"bath_toilet_lights" => csv_data[5][23].to_i(16),
	"hall_toilet_outlet" => csv_data[5][24].to_i(16),
	"living_pantry_outlet" => csv_data[5][25].to_i(16),
	"jin_outlet" => csv_data[5][26].to_i(16),
	"mbr_outlet" => csv_data[5][27].to_i(16),
	"freezer" => csv_data[5][28].to_i(16),
	"office_outlet" => csv_data[5][29].to_i(16),
	"washing_machine" => csv_data[5][30].to_i(16),
	"av_outlet_left" => csv_data[5][31].to_i(16),
	"av_outlet_right" => csv_data[5][32].to_i(16),
	"utility_outlet_left" => csv_data[5][33].to_i(16),
	"utility_outlet_right" => csv_data[5][34].to_i(16),
	"bath_outlet" => csv_data[5][35].to_i(16),
	"toilet_outlet" => csv_data[5][36].to_i(16),
	"microwave" => csv_data[5][37].to_i(16),
	"kitchen_counter" => csv_data[5][38].to_i(16),
	"septic" => csv_data[5][39].to_i(16),
	"diswasher" => csv_data[5][40].to_i(16),
	"stiebel" => csv_data[5][41].to_i(16),
	"aircon" => csv_data[5][42].to_i(16),
	"stove" => csv_data[5][43].to_i(16),
	"ev_charger" => csv_data[5][48].to_i(16),
	"oven" => csv_data[5][49].to_i(16)
	}

begin
	file = File.open("/var/lib/prometheus/node-exporter/panasonic.prom", "w")
	power.each do |key, value|
		friendly_name = key.to_s.split('_').map(&:capitalize).join(' ')
		file.write("power_w" "{domain=\"panasonic\"" ",entity=\"" "#{key}\"" ",friendly_name=\"" "#{friendly_name}\"}" " #{value}\n")
	end
rescue IOError => e
ensure
	file.close unless file.nil?
end
