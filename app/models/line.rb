# frozen_string_literal: true

class Line < ApplicationRecord
  belongs_to :stanza
  has_many :words

  def next_line
    self.class.find_by(absolute_number: absolute_number + 1)
  end
end
