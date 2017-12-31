class Canto < ApplicationRecord
  validates :name, :number, presence: true
end
