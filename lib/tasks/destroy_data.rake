# frozen_string_literal: true

namespace :migrate do
  desc 'Destroy all the data'
  task destroy_data: :environment do
    raise 'Only destroy all the data in dev-mode!' unless Rails.env.development?

    puts 'Preparing to destroy all the data...'
    start_time = Time.current

    User.destroy_all
    [Word, Line, Stanza, Canto].each(&:delete_all)

    end_time = Time.current
    puts "Destruction completed in #{(end_time - start_time).round} seconds."
  end
end
