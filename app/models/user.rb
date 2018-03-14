# frozen_string_literal: true

class User < ApplicationRecord
  include Authem::User
  has_deck :words

  validates :name, presence: true

  def next_line_to_learn
    if words.present?
      Word.find_by(absolute_position: words.pluck(:absolute_position).max + 1).line
    end
  end

  def next_line_to_review
    words.review.min_by(&:absolute_position).line
  end

  def review_count
    words.review.count
  end
end
