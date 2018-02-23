# frozen_string_literal: true

class Line < ApplicationRecord
  belongs_to :stanza
  has_many :words

  def next_line
    self.class.find_by(number: number + 1, stanza: stanza) ||
      self.class.find_by(number: 1, stanza: next_stanza)
  end

  def next_stanza
    Stanza.find_by(number: stanza.number + 1)
  end
end
