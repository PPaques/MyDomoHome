#!/bin/env ruby
# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Home.delete_all
Home.create(mode_auto: true)

Room.delete_all
Room.create(name: "Extérieur", heating: false, light: false, home: Home.first, isoutside: true)
Room.create(name: "Salon", heating: false, light: false, home: Home.first)
Room.create(name: "Cuisine", heating: false, light: false, home: Home.first)
Room.create(name: "Chambre", heating: false, light: false, home: Home.first)

Opening.delete_all
Opening.create(name: "Porte entrée", opened: false, rooms: [Room.find_by_name("Extérieur"), Room.find_by_name("Salon")] )
Opening.create(name: "Fenêtre gauche", opened: false, rooms: [Room.find_by_name("Extérieur"), Room.find_by_name("Salon")] )
Opening.create(name: "Fenêtre droite", opened: false, rooms: [Room.find_by_name("Extérieur"), Room.find_by_name("Salon")] )

Opening.create(name: "Fenêtre cuisine", opened: false, rooms: [Room.find_by_name("Extérieur"), Room.find_by_name("Cuisine")] )

Opening.create(name: "Fenêtre chambre", opened: false, rooms: [Room.find_by_name("Extérieur"), Room.find_by_name("Chambre")] )

Opening.create(name: "Porte cuisine", opened: false, rooms: [Room.find_by_name("Salon"), Room.find_by_name("Cuisine")] )
Opening.create(name: "Porte chambre", opened: false, rooms: [Room.find_by_name("Salon"), Room.find_by_name("Chambre")] )

User.delete_all
User.create(name: "admin", password: "admin", email: "admin@admin.com", role: 1)

TemperatureMeasure.delete_all
OpeningMeasure.delete_all

HeatingLog.delete_all