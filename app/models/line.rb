class Line < ApplicationRecord
  belongs_to :stanza
  has_many :words
end
