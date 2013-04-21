# -*- encoding : utf-8 -*-
#!/bin/env ruby
# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# cleaning model and regerate it
Home.delete_all
Home.create(mode_auto: true)

Room.delete_all
Room.create(name: "Extérieur",  gpio_heat_number: 14,heating: false, light: false, temperature: 20, home: Home.first, isoutside: true, temperature_slope: "equ")
Room.create(name: "Salon",      gpio_heat_number: 15,heating: false, light: false, temperature: 20, home: Home.first, isoutside: false, temperature_slope: "equ")
Room.create(name: "Cuisine",    gpio_heat_number: 18,heating: false, light: false, temperature: 20, home: Home.first, isoutside: false, temperature_slope: "equ")
Room.create(name: "Chambre",    gpio_heat_number: 23,heating: false, light: false, temperature: 20, home: Home.first, isoutside: false, temperature_slope: "equ")

Opening.delete_all
Opening.create(name: "Porte entrée",    gpio_number: 22, opened: false, rooms: [Room.find_by_name("Extérieur"), Room.find_by_name("Salon")], home: Home.first)
Opening.create(name: "Fenêtre gauche",  gpio_number: 9 , opened: false, rooms: [Room.find_by_name("Extérieur"), Room.find_by_name("Salon")], home: Home.first )
Opening.create(name: "Fenêtre droite",  gpio_number: 11, opened: false, rooms: [Room.find_by_name("Extérieur"), Room.find_by_name("Salon")], home: Home.first )

Opening.create(name: "Fenêtre cuisine", gpio_number: 10, opened: false, rooms: [Room.find_by_name("Extérieur"), Room.find_by_name("Cuisine")], home: Home.first )

Opening.create(name: "Fenêtre chambre", gpio_number: 21, opened: false, rooms: [Room.find_by_name("Extérieur"), Room.find_by_name("Chambre")], home: Home.first )

Opening.create(name: "Porte cuisine",   gpio_number: 17, opened: false, rooms: [Room.find_by_name("Salon"), Room.find_by_name("Cuisine")], home: Home.first )
Opening.create(name: "Porte chambre",   gpio_number: 4 , opened: false, rooms: [Room.find_by_name("Salon"), Room.find_by_name("Chambre")], home: Home.first )

#cleaning user
User.delete_all
User.create(name: "admin", password: "admin", email: "admin@admin.com", role: 1)

# cleaning log
TemperatureMeasure.delete_all
OpeningMeasure.delete_all
HeatingLog.delete_all

#cleaning setpoint
Setpoint.delete_all
