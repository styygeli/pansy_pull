#!/usr/bin/ruby

require 'rubygems'
require 'open-uri'
require 'csv'

csv_data = CSV.parse(URI.open("http://192.168.0.59/csv/InstVal.csv"), :headers => :first_row)

power = {
	"main" => csv_data[5][1].to_i(16)*10,
	"PV1" => csv_data[5][2].to_i(16),
	"Living_Lights" => csv_data[5][17].to_i(16),
	"Utility_Lights" => csv_data[5][18].to_i(16),
	"MBR/WiC_Lights" => csv_data[5][19].to_i(16),
	"AV_Lights" => csv_data[5][20].to_i(16),
	"Office_Lights" => csv_data[5][21].to_i(16),
	"Jin_Lights" => csv_data[5][22].to_i(16),
	"Bath/Toilet_Lights" => csv_data[5][23].to_i(16),
	"Hall/Toilet_Outlet" => csv_data[5][24].to_i(16),
	"Living/Pantry_Outlet" => csv_data[5][25].to_i(16),
	"Jin_Outlet" => csv_data[5][26].to_i(16),
	"MBR_Outlet" => csv_data[5][27].to_i(16),
	"Freezer" => csv_data[5][28].to_i(16),
	"Office_Outlet" => csv_data[5][29].to_i(16),
	"Washing_Machine" => csv_data[5][30].to_i(16),
	"AV_Outlet_Left" => csv_data[5][31].to_i(16),
	"AV_Outlet_Right" => csv_data[5][32].to_i(16),
	"Utility_Outlet_Left" => csv_data[5][33].to_i(16),
	"Utility_Outlet_Right" => csv_data[5][34].to_i(16),
	"Bath_Outlet" => csv_data[5][35].to_i(16),
	"Toilet_Outlet" => csv_data[5][36].to_i(16),
	"Microwave" => csv_data[5][37].to_i(16),
	"Kitchen_Counter" => csv_data[5][38].to_i(16),
	"Septic" => csv_data[5][39].to_i(16),
	"Diswasher" => csv_data[5][40].to_i(16),
	"Stiebel" => csv_data[5][41].to_i(16),
	"Aircon" => csv_data[5][42].to_i(16),
	"Stove" => csv_data[5][43].to_i(16),
	"EV_Charger" => csv_data[5][48].to_i(16),
	"Oven" => csv_data[5][49].to_i(16),
	"EcoCute" => csv_data[5][51].to_i(16)
	}

begin
	file = File.open("tmp.txt", "w")
	power.each do |key, value|
		file.write("#{key}_watts #{value}\n")
	end
rescue IOError => e
ensure
	file.close unless file.nil?
end
