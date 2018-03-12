# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

before = Time.current
puts 'Seeding the entire epic can take up to 2 minutes.'
puts 'Building now...'

string = File.read("#{Rails.root}/lib/assets/os-lusiadas.txt")
EpicTextParser.call(string)

after = Time.current
puts "Completed in #{(after - before).round} seconds."
