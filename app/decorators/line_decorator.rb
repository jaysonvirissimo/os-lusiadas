# frozen_string_literal: true

class LineDecorator
  attr_reader :line

  def initialize(line)
    @line = line
  end

  def classes
    'line'
  end

  def words
    @words ||= line.words.order(:position).map do |word|
      WordDecorator.new(word)
    end
  end

  class WordDecorator < SimpleDelegator
    def classes
      'word'
    end

    def present_html
      WordPresenter.new(self).html
    end
  end
end
