# frozen_string_literal: true

EasyTranslate.api_key = ENV['GOOGLE_TRANSLATE_API_KEY']

namespace :migrate do
  desc 'Translate lines and individual words'
  task translate: :environment do
    puts 'Preparing to translate...'
    start_time = Time.current

    Line.where.not(in_english: [nil, '']).includes(:words).find_each do |line|
      line.update(in_english: EasyTranslate.translate(line.to_s, to: :english))
    end

    end_time = Time.current
    puts "Finished translating in #{(end_time - start_time).round} seconds."
  end
end
