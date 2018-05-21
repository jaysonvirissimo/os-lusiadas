# frozen_string_literal: true

namespace :migrate do
  desc 'Delete the last 5 of 10 cantos from the database'
  task truncate_poem: :environment do
    puts 'Preparing to destroy cantos 6-10...'
    start_time = Time.current

    Canto.where(number: (6..10)).each(&:destroy)

    end_time = Time.current
    puts "Destruction completed in #{(end_time - start_time).round} seconds."
    puts "Now there only #{Canto.count} cantos left."
  end
end
