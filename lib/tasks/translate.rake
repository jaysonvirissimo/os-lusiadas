# frozen_string_literal: true

EasyTranslate.api_key = ENV['GOOGLE_TRANSLATE_API_KEY']

namespace :migrate do
  desc 'Translate lines and individual words'
  task translate: :environment do
    puts 'Preparing to translate...'
    start_time = Time.current

    Line.includes(:words).find_each do |line|
      sentence = line.words.order(:position).pluck(:value).join(' ')
      unless line.in_english.present?
        translation = EasyTranslate.translate(sentence, to: :english)
        line.update(in_english: translation)
      end
    end

    end_time = Time.current
    puts "Finished translating in #{(end_time - start_time).round} seconds."
  end
end
