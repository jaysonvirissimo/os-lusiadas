# frozen_string_literal: true

class User < ApplicationRecord
  include Authem::User
  has_deck :words

  validates :name, presence: true

  def next_line_to_learn
    return Word.first_word unless words.count.positive?
    Word.find_by(absolute_position: words.pluck(:absolute_position).max + 1).line
  end

  def next_line_to_review
    return nil unless words.count.positive? && words.review.count.positive?
    words.review.min_by(&:absolute_position).line
  end

  def review_count
    words.review.count
  end
end
