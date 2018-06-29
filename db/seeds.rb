# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

puts 'Seeding the entire epic can take more than 5 minutes.'
before = Time.current

puts 'Parsing Os Lusiadas...'
string = File.read("#{Rails.root}/lib/assets/os-lusiadas.txt")
LusiadasParser.call(string)

after = Time.current
puts "Completed in #{(after - before).round} seconds."
