# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file .env file.

user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email
CreatePlantsService.new.call
puts 'ADDED PLANTS'
CreateLocationsService.new.call
puts "ADDED HARYALI LOCATIONS"