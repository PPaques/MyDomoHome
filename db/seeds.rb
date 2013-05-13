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
Home.create(mode_auto: true, light_threeshold: 50)

Room.delete_all
Room.create(name: "Extérieur", temperature_channel: 5,                       heating: false, light: false, temperature: 20, home: Home.first, isoutside: true,  temperature_slope: "equ", color:"#006CFF", light_channel: 7, gpio_light_number: 15)
Room.create(name: "Salon",     temperature_channel: 4, gpio_heat_number: 14, heating: false, light: false, temperature: 20, home: Home.first, isoutside: false, temperature_slope: "equ", color:"#EE3C19")
Room.create(name: "Cuisine",   temperature_channel: 3, gpio_heat_number: 23, heating: false, light: false, temperature: 20, home: Home.first, isoutside: false, temperature_slope: "equ", color:"#AED100")
Room.create(name: "Chambre",   temperature_channel: 6, gpio_heat_number: 18, heating: false, light: false, temperature: 20, home: Home.first, isoutside: false, temperature_slope: "equ", color:"#FF9900")

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
User.create(name: "admin", password: "admin", email: "admin@mydomohome.com", role: 1)
User.create(name: "gestion", password: "gestion", email: "gestion@mydomohome.com", role: 2)
User.create(name: "invite", password: "invite", email: "invite@mydomohome.com", role: 3)

# cleaning log
TemperatureMeasure.delete_all
OpeningMeasure.delete_all
HeatingLog.delete_all

#cleaning setpoint
Setpoint.delete_all
for d in 0..6
  for h in 0..23
    Setpoint.create(room: Room.find_by_name("Salon"), temperature: 20, day: d, times: Time.new(2002, 10, 31, h, 0, 0))
    Setpoint.create(room: Room.find_by_name("Chambre"), temperature: 22, day: d, times: Time.new(2002, 10, 31, h, 0, 0))
    Setpoint.create(room: Room.find_by_name("Cuisine"), temperature: 17, day: d, times: Time.new(2002, 10, 31, h, 0, 0))
  end
end
