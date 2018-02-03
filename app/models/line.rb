# frozen_string_literal: true

class Line < ApplicationRecord
  belongs_to :stanza
  has_many :words
end
