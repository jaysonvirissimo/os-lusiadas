class Canto < ApplicationRecord
  validates :name, :number, presence: true

  has_many :stanzas
end
