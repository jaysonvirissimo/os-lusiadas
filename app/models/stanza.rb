class Stanza < ApplicationRecord
  belongs_to :canto
  has_many :lines
end
