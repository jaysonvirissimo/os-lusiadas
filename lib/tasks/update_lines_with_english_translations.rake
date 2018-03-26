namespace :db do
  desc 'Parse English translations and associate lines with existing records'
  task update_lines_with_english_translations: :environment do
    puts 'Parsing translations and associating records...'
    string = File.read("#{Rails.root}/lib/assets/the-lusiads.txt")
    LusiadsParser.call(string)
    puts 'Done!'
  end
end
