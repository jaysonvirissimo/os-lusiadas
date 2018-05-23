# frozen_string_literal: true

class Line < ApplicationRecord
  belongs_to :stanza
  has_many :words, dependent: :destroy

  def next_line
    self.class.find_by(absolute_number: absolute_number + 1)
  end

  def to_s
    words.order(:position).pluck(:value).join(' ')
  end
end
