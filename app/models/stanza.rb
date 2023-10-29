# frozen_string_literal: true

class Stanza < ApplicationRecord
  belongs_to :canto
  has_many :lines, dependent: :destroy
  has_many :words, through: :lines

  def to_ssml
    "<p>#{lines.order(:number).map(&:to_ssml).join(BREAK)}</p>"
  end

  private

  BREAK = '<break time="200ms"/>'
end
