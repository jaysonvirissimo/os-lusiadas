# frozen_string_literal: true

class Word < ApplicationRecord
  ALPHABET = ('a'..'z')
  DIACRITICS_MAP = {
    'á': 'a',
    'â': 'a',
    'ã': 'a',
    'à': 'a',
    'ç': 'c',
    'é': 'e',
    'ê': 'e',
    'í': 'i',
    'ó': 'o',
    'ô': 'o',
    'õ': 'o',
    'ú': 'u'
  }.freeze

  belongs_to :line

  def match(guess)
    clean(value) == clean(guess)
  end

  private

  def clean(word)
    word.downcase.chars.map do |character|
      DIACRITICS_MAP[character.intern] || character
    end.select { |character| ALPHABET.include?(character) }.join
  end
end
