# frozen_string_literal: true

class Canto < ApplicationRecord
  validates :name, :number, presence: true

  has_many :stanzas

  def display_name
    "Canto #{name}"
  end
end
