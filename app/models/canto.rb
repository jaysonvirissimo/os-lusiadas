# frozen_string_literal: true

class Canto < ApplicationRecord
  validates :name, :number, presence: true

  has_many :stanzas, dependent: :destroy
  has_many :lines, through: :stanzas
  has_many :words, through: :lines
end
