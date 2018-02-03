# frozen_string_literal: true

class Canto < ApplicationRecord
  validates :name, :number, presence: true

  has_many :stanzas
  has_many :lines, through: :stanzas
  has_many :words, through: :lines

  def display_name
    "Canto #{name}"
  end
end
