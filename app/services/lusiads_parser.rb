# frozen_string_literal: true

class LusiadsParser
  def self.call(string)
    new(string).call
  end

  def initialize(string)
    @string = string
    @line_number = 1
  end

  def call
    string.each_line do |potential_translation|
      if valid?(potential_translation)
        associate_with_line(parse(potential_translation)) && increment_number
      end
    end
  end

  private

  attr_reader :string

  def associate_with_line(translation)
    Line
      .find_by(absolute_number: @line_number)
      .update(english_translation: translation)
  end

  def increment_number
    @line_number += 1
  end

  def parse(translation)
    translation.split(/\t/).first.gsub('\t', '').strip
  end

  def valid?(potential_line)
    return false if potential_line.include?('CANTO')
    return false if potential_line.blank?
    true
  end
end
