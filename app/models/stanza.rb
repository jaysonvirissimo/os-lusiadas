# frozen_string_literal: true

class Stanza < ApplicationRecord
  belongs_to :canto
  has_many :lines
  has_many :words, through: :lines
end
